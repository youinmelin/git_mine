package com.forgetfulr.common.utils;

import com.forgetfulr.common.exception.HttpException;
import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.*;
import org.apache.http.conn.socket.LayeredConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 提供常用HTTP协议功能的封装，包括GET、POST请求等
 * 该功能包基于apache的httpclient工具包为基础开发包
 *
 * @author caorui
 * @date 2019-01-10
 */
public class HttpProtocolUtil {

    private static PoolingHttpClientConnectionManager connMgr;

    private static RequestConfig connConfig;

    private static final int CONNECT_TIMEOUT = 60000;

    private static final int REQUEST_CONNECT_TIMEOUT = 60000;

    private static final int SOCKET_TIMEOUT = 60000;

    private static final int POOL_SIZE = 100;

    static {
        // 设置连接池
        connMgr = new PoolingHttpClientConnectionManager();
        // 设置连接池大小
        connMgr.setMaxTotal(POOL_SIZE);
        connMgr.setDefaultMaxPerRoute(POOL_SIZE);

        RequestConfig.Builder configBuilder = RequestConfig.custom();
        // 设置连接超时
        configBuilder.setConnectTimeout(CONNECT_TIMEOUT);
        // 设置读取超时
        configBuilder.setSocketTimeout(SOCKET_TIMEOUT);
        // 设置从连接池获取连接实例的超时
        configBuilder.setConnectionRequestTimeout(REQUEST_CONNECT_TIMEOUT);
        connConfig = configBuilder.build();
    }

    /**
     * HTTP GET请求
     *
     * @param url
     * @return
     * @throws HttpException
     */
    public static String getRequest(String url) throws HttpException {
        HttpGet httpGet = new HttpGet(url);
        return commonRequest(httpGet, getHttpClient());
    }

    /**
     * HTTP GET请求（带header）
     *
     * @param url
     * @param headerParams
     * @return
     * @throws HttpException
     */
    public static String getRequest(String url, Map<String, String> headerParams) throws HttpException {
        HttpGet httpGet = new HttpGet(url);
        // 请求头
        if (headerParams != null) {
            Iterator<Map.Entry<String, String>> iterator = headerParams.entrySet().iterator();
            Map.Entry<String, String> entry;
            while (iterator.hasNext()) {
                entry = iterator.next();
                httpGet.setHeader(entry.getKey(), entry.getValue());
            }
        }
        return commonRequest(httpGet, getHttpClient());
    }

    /**
     * HTTP POST FORM格式请求
     *
     * @param url    请求地址
     * @param params 请求参数
     * @return
     * @throws HttpException
     */
    public static String postFormRequest(String url, Map<String, String> params) throws HttpException {
        HttpPost httpPost = new HttpPost(url);
        List<BasicNameValuePair> pairs = new ArrayList<>();
        Iterator<Map.Entry<String, String>> iterator = params.entrySet().iterator();
        Map.Entry<String, String> entry;
        while (iterator.hasNext()) {
            entry = iterator.next();
            pairs.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
        }

        UrlEncodedFormEntity requestEntity = null;
        try {
            requestEntity = new UrlEncodedFormEntity(pairs, "UTF-8");

        } catch (UnsupportedEncodingException e) {
            throw new HttpException();
        }
        httpPost.setEntity(requestEntity);

        return commonRequest(httpPost, getHttpClient());
    }

    /**
     * HTTP POST 通用格式请求
     *
     * @param url
     * @param content
     * @return
     * @throws HttpException
     */
    public static String postRequest(String url, String content) throws HttpException {
        HttpPost httpPost = new HttpPost(url);
        StringEntity postEntity = new StringEntity(content, Charset.forName("UTF-8"));
        httpPost.setEntity(postEntity);

        return commonRequest(httpPost, getHttpClient());
    }

    public static String postRequest(String url, String content, String charset, Map<String, String> headerParams) throws HttpException {
        HttpPost httpPost = new HttpPost(url);
        // 请求头
        if (headerParams != null) {
            Iterator<Map.Entry<String, String>> iterator = headerParams.entrySet().iterator();
            Map.Entry<String, String> entry;
            while (iterator.hasNext()) {
                entry = iterator.next();
                httpPost.setHeader(entry.getKey(), entry.getValue());
            }
        }

        StringEntity postEntity = new StringEntity(content, Charset.forName(charset));
        httpPost.setEntity(postEntity);

        return commonRequest(httpPost, getHttpClient());
    }

    /**
     * 发送 SSL POST 请求（HTTPS），JSON形式
     *
     * @param url  API接口URL
     * @param json JSON对象
     * @return
     */
    public static String postSSLRequest(String url, Object json) {
        HttpPost httpPost = new HttpPost(url);
        StringEntity stringEntity = new StringEntity(json.toString(), "UTF-8");//解决中文乱码问题
        stringEntity.setContentEncoding("UTF-8");
        stringEntity.setContentType("application/json");
        httpPost.setEntity(stringEntity);

        try {
            return commonRequest(httpPost, getSSLHttpClient());
        } catch (NoSuchAlgorithmException | KeyManagementException e) {
            throw new HttpException();
        }
    }

    public static String postSSLRequest(String url, String postData, Map<String, String> headerParams) {
        HttpPost httpPost = new HttpPost(url);

        // 请求头
        if (headerParams != null) {
            Iterator<Map.Entry<String, String>> iterator = headerParams.entrySet().iterator();
            Map.Entry<String, String> entry;
            while (iterator.hasNext()) {
                entry = iterator.next();
                httpPost.setHeader(entry.getKey(), entry.getValue());
            }
        }

        // 请求消息体
        StringEntity stringEntity = new StringEntity(postData, "UTF-8");//解决中文乱码问题
        stringEntity.setContentEncoding("UTF-8");
        stringEntity.setContentType("application/json");
        httpPost.setEntity(stringEntity);

        try {
            return commonRequest(httpPost, getSSLHttpClient());
        } catch (NoSuchAlgorithmException | KeyManagementException e) {
            throw new HttpException();
        }
    }

    /**
     * From表单形式的HTTPS POST 请求
     *
     * @param url
     * @param postData
     * @param headerParams
     * @return
     */
    public static String postSSLFormRequest(String url, String postData, Map<String, String> headerParams) {
        HttpPost httpPost = new HttpPost(url);

        // 请求头
        if (headerParams != null) {
            Iterator<Map.Entry<String, String>> iterator = headerParams.entrySet().iterator();
            Map.Entry<String, String> entry;
            while (iterator.hasNext()) {
                entry = iterator.next();
                httpPost.setHeader(entry.getKey(), entry.getValue());
            }
        }

        // 请求消息体
        //解决中文乱码问题
        StringEntity stringEntity = new StringEntity(postData, "UTF-8");
        stringEntity.setContentEncoding("UTF-8");
        stringEntity.setContentType("application/x-www-form-urlencoded");
        httpPost.setEntity(stringEntity);

        try {
            return commonRequest(httpPost, getSSLHttpClient());
        } catch (NoSuchAlgorithmException | KeyManagementException e) {
            throw new HttpException();
        }
    }

//    public static String postSSLFormRequest(String url, String postData, File uploadFile) {
//        HttpPost httpPost = new HttpPost(url);
//
//        // 请求消息体
//        //解决中文乱码问题
//        StringEntity stringEntity = new StringEntity(postData, "UTF-8");
//        stringEntity.setContentEncoding("UTF-8");
//        stringEntity.setContentType("multipart/form-data");
//        FileBody file = new FileBody(uploadFile, ContentType.DEFAULT_BINARY);
//        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
//        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
//        builder.addPart(fileName, file);
//        httpPost.setEntity(builder.build());
//        httpPost.setEntity(stringEntity);
//
//        try {
//            return commonRequest(httpPost, getSSLHttpClient());
//        } catch (NoSuchAlgorithmException | KeyManagementException e) {
//            LOGGER.warn("create ssl http client error:{}", e.getCause());
//            throw new HttpException();
//        }
//    }

    /**
     * HTTP POST FILE上传请求
     *
     * @param url        请求地址
     * @param uploadFile 上传文件
     * @param fileName   文件名字
     * @return
     * @throws HttpException
     */
    public static String postFileRequest(String url, File uploadFile, String fileName) throws HttpException {
        HttpPost httpPost = new HttpPost(url);
        FileBody file = new FileBody(uploadFile, ContentType.DEFAULT_BINARY);
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
        builder.addPart(fileName, file);
        httpPost.setEntity(builder.build());

        return commonRequest(httpPost, getHttpClient());
    }

    public static String putFormRequest(String url, Map<String, String> params) throws HttpException {
        HttpPut httpPut = new HttpPut(url);

        List<BasicNameValuePair> pairs = new ArrayList<>();
        Iterator<Map.Entry<String, String>> iterator = params.entrySet().iterator();
        Map.Entry<String, String> entry;
        while (iterator.hasNext()) {
            entry = iterator.next();
            pairs.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
        }

        UrlEncodedFormEntity requestEntity = null;
        try {
            requestEntity = new UrlEncodedFormEntity(pairs, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new HttpException();
        }
        httpPut.setEntity(requestEntity);

        return commonRequest(httpPut, getHttpClient());
    }

    /**
     * HTTP DELETE方法
     *
     * @param url
     * @return
     * @throws HttpException
     */
    public static String deleteRequest(String url) throws HttpException {
        HttpDelete httpDelete = new HttpDelete(url);
        return commonRequest(httpDelete, getHttpClient());
    }

    /**
     * 创建httpclient对象
     *
     * @return
     */
    private static CloseableHttpClient getHttpClient() {
        return HttpClients.custom()
                .setConnectionManager(connMgr)
                .setConnectionManagerShared(true)
                .setDefaultRequestConfig(connConfig).build();
    }

    /**
     * 读取授信证书，并创建SSL连接工厂
     *
     * @return
     */
    private static LayeredConnectionSocketFactory createSSLConnSocketFactory() throws NoSuchAlgorithmException, KeyManagementException {
        TrustManager[] trustCerts = new TrustManager[]{
                new X509TrustManager() {
                    @Override
                    public X509Certificate[] getAcceptedIssuers() {
                        return null;
                    }

                    @Override
                    public void checkClientTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {

                    }

                    @Override
                    public void checkServerTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {

                    }
                }
        };
        SSLContext sslContext = SSLContext.getInstance("TLS");
        sslContext.init(null, trustCerts, null);
        LayeredConnectionSocketFactory sslSocketFactory = new SSLConnectionSocketFactory(sslContext);

        return sslSocketFactory;
    }

    /**
     * 创建基于SSL的httpclient对象
     *
     * @return
     * @throws NoSuchAlgorithmException
     * @throws KeyManagementException
     */
    private static CloseableHttpClient getSSLHttpClient() throws NoSuchAlgorithmException, KeyManagementException {
        return HttpClients.custom()
                .setSSLSocketFactory(createSSLConnSocketFactory())
                .setConnectionManager(connMgr)
                .setDefaultRequestConfig(connConfig).build();
    }

    /**
     * 通用请求模板
     */
    private static String commonRequest(HttpRequestBase httpRequest, CloseableHttpClient httpClient) {
        try {
            CloseableHttpClient client = httpClient;
            CloseableHttpResponse response = client.execute(httpRequest);
            HttpEntity entity = response.getEntity();

            // 请求结果code!=200
            if (response.getStatusLine().getStatusCode() != HttpStatus.SC_OK) {
                return null;
            }
            return EntityUtils.toString(entity, "UTF-8");

        } catch (IOException e) {
            throw new HttpException();
        }
    }
}
