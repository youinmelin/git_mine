package com.forgetfulr.common.utils;

import com.alibaba.fastjson.JSONObject;
import com.forgetfulr.common.exception.AlgorithmException;
import com.forgetfulr.common.exception.HttpException;
import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

/**
 * 提供常用加密算法工具类
 * 该功能包基于apache的commons-codec工具包为基础包
 * <p>
 *
 * @author caorui
 */
public class ArithmeticUtil {

    private static final String ALGORITHM_RSA = "RSA";

    /**
     * RSA最大加密明文大小
     */
    private static final int MAX_ENCRYPT_BLOCK = 245;

    /**
     * RSA最大解密密文大小
     */
    private static final int MAX_DECRYPT_BLOCK = 256;

    // 加密算法
    private static final String ALG = "AES";
    // 字符编码
    private static final String ENC = "UTF-8";
    // 密钥正规化算法
    private static final String SEC_NORMALIZE_ALG = "MD5";
    // 默认密钥
    private static final String SECRET = "www.mingyouCOM123@";

    /**
     * MD5加密算法，返回Hex编码字符串
     *
     * @param data
     * @return
     */
    public static String MD5(String data) {
        return DigestUtils.md5Hex(data);
    }

    /**
     * MD5加密算法
     *
     * @param data
     * @return
     */
    public static String MD5(byte[] data) {
        return DigestUtils.md5Hex(data);
    }

    /**
     * SHA1加密算法，返回Hex编码字符串
     *
     * @param data
     * @return
     */
    public static String SHA1(String data) {
        return DigestUtils.sha1Hex(data);
    }

    /**
     * SHA256加密算法，返回Hex编码字符串
     *
     * @param data
     * @return
     */
    public static String SHA256(String data) {
        return DigestUtils.sha256Hex(data);
    }

    /**
     * Base64加密算法，返回UTF8字符串
     * 注意待加密的字符串在编码和生成字符时，需要使用相同的编码格式，否则容易造成乱码问题
     * 字符范围参看Base64加密算法
     *
     * @param data
     * @return
     */
    public static String Base64Encode(byte[] data) {
        return Base64.encodeBase64String(data);
    }

    /**
     * Base64解密算法，返回原始字符串数组
     *
     * @param data
     * @return
     */
    public static byte[] Base64Decode(String data) {
        return Base64.decodeBase64(data);
    }

    /**
     * RSA加密
     *
     * @param plainText
     * @return base64格式密文
     */
    public static String RSAEncrypt(String plainText, String keyResource) throws AlgorithmException {
        byte[] encryptedData = null;
        try {
            byte[] b = plainText.getBytes("UTF-8");
            int inputLen = b.length;
            int offSet = 0;
            byte[] cache;
            int i = 0;
            Cipher cipher = Cipher.getInstance(ALGORITHM_RSA);
            cipher.init(Cipher.ENCRYPT_MODE, getPublicKey(keyResource));

            try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
                // 对数据分段解密
                while (inputLen - offSet > 0) {
                    if (inputLen - offSet > MAX_ENCRYPT_BLOCK) {
                        cache = cipher.doFinal(b, offSet, MAX_ENCRYPT_BLOCK);
                    } else {
                        cache = cipher.doFinal(b, offSet, inputLen - offSet);
                    }
                    out.write(cache, 0, cache.length);
                    i++;
                    offSet = i * MAX_ENCRYPT_BLOCK;
                }

                encryptedData = out.toByteArray();
            }
        } catch (NoSuchAlgorithmException | NoSuchPaddingException | InvalidKeyException | InvalidKeySpecException
                | IllegalBlockSizeException | BadPaddingException | IOException | HttpException e) {
            throw new AlgorithmException("algorithm exception", e.getCause());
        }

        return Base64Encode(encryptedData);
    }

    /**
     * RSA解码
     *
     * @param data 密文
     * @return 解密明文
     */
    public static String RSADecrypt(String data, String keyResource) throws AlgorithmException {
        String plainText;

        try {
            byte[] b = ArithmeticUtil.Base64Decode(data);
            int inputLen = b.length;
            int offSet = 0;
            byte[] cache;
            int i = 0;
            Cipher cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.DECRYPT_MODE, getPrivateKey(keyResource));
            byte[] decryptedData = null;
            try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
                // 对数据分段解密
                while (inputLen - offSet > 0) {
                    if (inputLen - offSet > MAX_DECRYPT_BLOCK) {
                        cache = cipher.doFinal(b, offSet, MAX_DECRYPT_BLOCK);
                    } else {
                        cache = cipher.doFinal(b, offSet, inputLen - offSet);
                    }
                    out.write(cache, 0, cache.length);
                    i++;
                    offSet = i * MAX_DECRYPT_BLOCK;
                }
                decryptedData = out.toByteArray();
            }

            plainText = new String(decryptedData, "UTF-8");
        } catch (Exception e) {
            throw new AlgorithmException("algorithm exception", e.getCause());
        }

        return plainText;
    }


    public static String calcRsaSign(String plainText, String keyResource) throws AlgorithmException {
        try {
            String privateKey = getKeyFile(keyResource);
            byte[] data;
            try {
                data = plainText.getBytes("UTF-8");
            } catch (UnsupportedEncodingException e) {
                throw new RuntimeException(e.getMessage(), e);
            }
            byte[] sign = null;
            // 解密由base64编码的私钥
            byte[] privateKeyBytes = Base64.decodeBase64(privateKey.getBytes());

            // 构造PKCS8EncodedKeySpec对象
            PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(privateKeyBytes);

            // KEY_ALGORITHM 指定的加密算法
            KeyFactory keyFactory;
            try {
                keyFactory = KeyFactory.getInstance("RSA");
            } catch (NoSuchAlgorithmException e) {
                throw new RuntimeException(e.getMessage(), e);
            }

            // 取私钥匙对象
            PrivateKey priKey;
            try {
                priKey = keyFactory.generatePrivate(pkcs8KeySpec);
            } catch (InvalidKeySpecException e) {
                throw new RuntimeException(e.getMessage(), e);
            }

            // 用私钥对信息生成数字签名
            Signature signature;
            try {
                signature = Signature.getInstance("SHA1withRSA");
            } catch (NoSuchAlgorithmException e) {
                throw new RuntimeException(e.getMessage(), e);
            }
            try {
                signature.initSign(priKey);
            } catch (InvalidKeyException e) {
                throw new RuntimeException(e.getMessage(), e);
            }

            try {
                signature.update(data);
                sign = signature.sign();
            } catch (SignatureException e) {
                throw new RuntimeException(e.getMessage(), e);
            }
            return new String(Base64.encodeBase64(sign));
        } catch (Exception e) {
            throw new AlgorithmException("algorithm exception", e.getCause());
        }
    }

    /**
     * 获取公钥
     *
     * @return
     */
    private static PublicKey getPublicKey(String resourcePath) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
        Resource resource = new ClassPathResource(resourcePath);
        String readLine;
        StringBuilder key = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(resource.getInputStream()))) {
            while ((readLine = br.readLine()) != null) {
                if (readLine.charAt(0) == '-') {
                    continue;
                } else {
                    key.append(readLine).append('\r');
                }
            }
        }

        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM_RSA);
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(ArithmeticUtil.Base64Decode(key.toString()));
        PublicKey publicKey = keyFactory.generatePublic(keySpec);

        return publicKey;
    }

    /**
     * 获取私钥
     *
     * @return
     */
    private static PrivateKey getPrivateKey(String resourcePath) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
        Resource resource = new ClassPathResource(resourcePath);
        String readLine;
        StringBuilder key = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(resource.getInputStream()))) {
            while ((readLine = br.readLine()) != null) {
                if (readLine.charAt(0) == '-') {
                    continue;
                } else {
                    key.append(readLine).append('\r');
                }
            }
        }

        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(ArithmeticUtil.Base64Decode(key.toString()));
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM_RSA);
        PrivateKey privateKey = keyFactory.generatePrivate(keySpec);

        return privateKey;
    }

    /**
     * 获取密钥文件
     *
     * @param resourcePath
     * @return
     * @throws IOException
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeySpecException
     */
    private static String getKeyFile(String resourcePath) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
        Resource resource = new ClassPathResource(resourcePath);
        String readLine;
        StringBuilder key = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(resource.getInputStream()))) {
            while ((readLine = br.readLine()) != null) {
                if (readLine.charAt(0) == '-') {
                    continue;
                } else {
                    key.append(readLine).append('\r');
                }
            }
        }
        return key.toString();
    }

    // AES 加解密可以参考：https://gist.github.com/pfmiles/d911d5488be5b23d0d07

    /**
     * AES 加密
     *
     * @param data
     * @return
     * @throws Exception
     */
    public static String AESEncrypt(String data) throws Exception {
        return AESEncrypt(data, SECRET);
    }

    /**
     * AES 加密
     *
     * @param data
     * @param secret
     * @return
     * @throws Exception
     */
    public static String AESEncrypt(String data, String secret) throws Exception {
        MessageDigest dig = MessageDigest.getInstance(SEC_NORMALIZE_ALG);
        byte[] key = dig.digest(secret.getBytes(ENC));
        SecretKeySpec secKey = new SecretKeySpec(key, ALG);

        Cipher aesCipher = Cipher.getInstance(ALG);
        byte[] byteText = data.getBytes(ENC);

        aesCipher.init(Cipher.ENCRYPT_MODE, secKey);
        byte[] byteCipherText = aesCipher.doFinal(byteText);

        Base64 base64 = new Base64();
        return new String(base64.encode(byteCipherText), ENC);
    }

    /**
     * AES 解密
     *
     * @param ciphertext
     * @return
     * @throws Exception
     */
    public static String AESDecrypt(String ciphertext) throws Exception {
        return AESDecrypt(ciphertext, SECRET);
    }

    /**
     * AES 解密
     *
     * @param ciphertext
     * @param secret
     * @return
     * @throws Exception
     */
    public static String AESDecrypt(String ciphertext, String secret) throws Exception {
        MessageDigest dig = MessageDigest.getInstance(SEC_NORMALIZE_ALG);
        byte[] key = dig.digest(secret.getBytes(ENC));
        SecretKeySpec secKey = new SecretKeySpec(key, ALG);

        Cipher aesCipher = Cipher.getInstance(ALG);
        aesCipher.init(Cipher.DECRYPT_MODE, secKey);
        Base64 base64 = new Base64();
        byte[] cipherbytes = base64.decode(ciphertext.getBytes());
        byte[] bytePlainText = aesCipher.doFinal(cipherbytes);
        return new String(bytePlainText, ENC);
    }

    /**
     * Hex 加密
     *
     * @param data
     * @return
     */
    public static String HexEncode(String data) {
        return Hex.encodeHexString(data.getBytes());
    }

    /**
     * Hex 解密
     *
     * @param data
     * @return
     * @throws DecoderException
     */
    public static String HexDecode(String data) throws DecoderException {
        return new String(Hex.decodeHex(data.toCharArray()));
    }

    /**
     * 登录加密
     *
     * @param md5password
     * @return
     */
    public static String loginmd5(String md5password) {
        if (md5password.length() != 32) {
            md5password = ArithmeticUtil.MD5(md5password);
        }
        char[] temp = md5password.toCharArray();
        //0-31，1-30.。。。15-16互换位子
        for (int i = 0; i < 16; i++) {
            char t = temp[i];
            temp[i] = temp[31 - i];
            temp[31 - i] = t;
        }
        StringBuilder sha = new StringBuilder();
        for (char c : temp) {
            sha.append(c);
        }
        return ArithmeticUtil.MD5(ArithmeticUtil.SHA256(sha.toString()).toUpperCase());
    }

    public static String sign(String rftKey, String rftSecret, JSONObject data) {
        String md5Key = ArithmeticUtil.MD5(rftKey + rftSecret);
        String serial = convertMapToJson(data);

        return MD5(serial + md5Key);
    }

    private static String convertMapToJson(Map<String, Object> requestBody) {
        TreeSet<String> sortedKey = new TreeSet<>(requestBody.keySet());
        StringBuilder builer = new StringBuilder();
        for (String key : sortedKey) {
            if (requestBody.get(key) != null && !key.equals("sign")) {
                builer.append(key).append("=").append(convertObjectToJson(requestBody.get(key))).append("&");
            }
        }
        String result = builer.toString();
        if (result.length() > 1) {
            return result.substring(0, result.length() - 1);
        } else {
            return result;
        }
    }

    private static String convertObjectToJson(Object obj) {
        if (obj == null) {
            return "";
        }
        if (obj.getClass().isArray()) {
            return StringUtils.join((Object[]) obj, "&");
        } else if (obj instanceof Map) {
            return convertMapToJson((Map<String, Object>) obj);
        } else if (obj.getClass().isPrimitive() || obj.getClass() == String.class) {
            return String.valueOf(obj);
        } else if (obj instanceof Collection) {
            StringBuilder builder = new StringBuilder();
            for (Object _obj : (List<Object>) obj) {
                builder.append(convertObjectToJson(_obj)).append("&");
            }
            String result = builder.toString();
            if (result.length() > 1) {
                return result.substring(0, result.length() - 1);
            } else {
                return result;
            }
        } else {
            return String.valueOf(obj);
        }
    }
}