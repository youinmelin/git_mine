package com.forgetfulr.common.utils;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;

/**
 * 文件操作工具类
 *
 * @author caorui
 * @date 2018/7/12
 */
@Component
public class FileUtil {

//    private static String uploadFilePath;
//
//    @Value("${upload-files}")
//    public void setUploadFilePath(String uploadFilePath) {
//        FileUtil.uploadFilePath = uploadFilePath;
//    }

    /**
     * HTML文档内容转换为PDF文件流
     *
     * @param text
     * @return
     */
//    public static Map<String, Object> html2pdf(String text) {
//        Map<String, Object> result = new HashMap<>();
//        try {
//            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
//            byte[] bytes = text.getBytes();
//            ByteArrayInputStream msInput = new ByteArrayInputStream(bytes);
//            // A4纸大小 可以选择
//            Document doc = new Document(PageSize.A4);
//            PdfWriter pdfWriter = PdfWriter.getInstance(doc, outputStream);
//
//            PdfDestination pdfDest = new PdfDestination(PdfDestination.XYZ, 0, 0, 0f);
//            //开启Document文件
//            doc.open();
//            //使用XMLWorkerHelper把Html parse到PDF档里
//            XMLWorkerHelper.getInstance().parseXHtml(pdfWriter, doc, msInput, null, new AsianFontProvider());
//
//            //将pdfDest设定的资料写到PDF档
//            PdfAction action = PdfAction.gotoLocalPage(1, pdfDest, pdfWriter);
//
//            pdfWriter.setOpenAction(action);
//            doc.close();
//            msInput.close();
//            outputStream.close();
//            //回传PDF档案
//
//            // 文件尺寸
//            result.put("PageSize", pdfWriter.getPageSize());
//            // 文件页数
//            result.put("PageNumber", pdfWriter.getPageNumber());
//            // Base64编码
//            result.put("Base64Encode", ArithmeticUtil.Base64Encode(outputStream.toByteArray()));
//            // md5
//            result.put("md5", ArithmeticUtil.MD5(outputStream.toByteArray()));
//
////            System.out.println("PDF文件尺寸：" + pdfWriter.getPageSize());
////            System.out.println("PDF文件页数：" + pdfWriter.getPageNumber());
////
////            String base64Str = ArithmeticUtil.Base64Encode(outputStream.toByteArray());
////
////            String md5 = ArithmeticUtil.MD5(outputStream.toByteArray());
////
////            //将文件写入本地
////            File file = new File(uploadFilePath + File.separator + "paper");
////            if (!file.exists()) {
////                file.mkdirs();
////            }
////            file = new File(uploadFilePath + File.separator + "paper" + File.separator + "test1.pdf");
////            OutputStream out = new FileOutputStream(file);
////            out.write(outputStream.toByteArray());
////            out.close();
//
//        } catch (DocumentException | IOException e) {
//            e.printStackTrace();
//        }
//        return result;
//    }
//
//    public static void html2pdf2localfile(String text, String localFilePath, String fileName) {
//        try {
//            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
//            byte[] bytes = text.getBytes();
//            ByteArrayInputStream msInput = new ByteArrayInputStream(bytes);
//            // A4纸大小 可以选择
//            Document doc = new Document(PageSize.A4);
//            PdfWriter pdfWriter = PdfWriter.getInstance(doc, outputStream);
//
//            PdfDestination pdfDest = new PdfDestination(PdfDestination.XYZ, 0, 0, 0f);
//            //开启Document文件
//            doc.open();
//            //使用XMLWorkerHelper把Html parse到PDF档里
//            XMLWorkerHelper.getInstance().parseXHtml(pdfWriter, doc, msInput, null, new AsianFontProvider());
//
//            //将pdfDest设定的资料写到PDF档
//            PdfAction action = PdfAction.gotoLocalPage(1, pdfDest, pdfWriter);
//
//            pdfWriter.setOpenAction(action);
//            doc.close();
//            msInput.close();
//            outputStream.close();
//            //将文件写入本地
//            File file = new File(uploadFilePath + File.separator + localFilePath);
//            if (!file.exists()) {
//                file.mkdirs();
//            }
//            file = new File(uploadFilePath + File.separator + localFilePath + File.separator + fileName + ".pdf");
//            OutputStream out = new FileOutputStream(file);
//            out.write(outputStream.toByteArray());
//            out.close();
//
//        } catch (DocumentException | IOException e) {
//            e.printStackTrace();
//        }
//    }
//
//    static class AsianFontProvider extends XMLWorkerFontProvider {
//
//        @Override
//        public Font getFont(final String fontname, final String encoding,
//                            final boolean embedded, final float size, final int style,
//                            final BaseColor color) {
//            BaseFont bf = null;
//            try {
//                bf = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H",
//                        BaseFont.NOT_EMBEDDED);
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//            Font font = new Font(bf, size, style, color);
//            font.setColor(color);
//            return font;
//        }
//    }

    /**
     * base64 转 MultipartFile
     *
     * @param base64
     * @return
     */
    public static MultipartFile base64ToMultipart(String base64) {
        byte[] b;
        b = Base64.decodeBase64(base64);

        for (int i = 0; i < b.length; ++i) {
            if (b[i] < 0) {
                b[i] += 256;
            }
        }

        return new BASE64DecodedMultipartFile(b, "data:image/png;base64");
    }

    public static class BASE64DecodedMultipartFile implements MultipartFile {

        private final byte[] imgContent;
        private final String header;

        public BASE64DecodedMultipartFile(byte[] imgContent, String header) {
            this.imgContent = imgContent;
            this.header = header.split(";")[0];
        }

        @Override
        public String getName() {
            // TODO - implementation depends on your requirements
            return System.currentTimeMillis() + Math.random() + "." + header.split("/")[1];
        }

        @Override
        public String getOriginalFilename() {
            // TODO - implementation depends on your requirements
            return System.currentTimeMillis() + (int) (Math.random() * 10000) + "." + header.split("/")[1];
        }

        @Override
        public String getContentType() {
            // TODO - implementation depends on your requirements
            return header.split(":")[1];
        }

        @Override
        public boolean isEmpty() {
            return imgContent == null || imgContent.length == 0;
        }

        @Override
        public long getSize() {
            return imgContent.length;
        }

        @Override
        public byte[] getBytes() throws IOException {
            return imgContent;
        }

        @Override
        public InputStream getInputStream() throws IOException {
            return new ByteArrayInputStream(imgContent);
        }

        @Override
        public void transferTo(File dest) throws IOException, IllegalStateException {
            new FileOutputStream(dest).write(imgContent);
        }
    }

    /**
     * InputStream 转 Base64
     *
     * @param file
     * @return
     */
    public static String InputStreamToBase64(InputStream file) {
        try {
            InputStream is = file;
            // 处理图片
            ByteArrayOutputStream outStream = new ByteArrayOutputStream();
            //创建一个Buffer字符串  
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = is.read(buffer)) != -1) {
                outStream.write(buffer, 0, len);
            }
            return ArithmeticUtil.Base64Encode(outStream.toByteArray());
        } catch (IOException e) {
            return null;
        }
    }
}
