package com.dzl.service.impl;


import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectRequest;
import com.dzl.common.ResponseResult;
import com.dzl.service.UploadService;
import com.dzl.utils.ConstantPropertiesUtils;
import lombok.Data;
import org.joda.time.DateTime;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

@Service
@Data
public class OssUploadService implements UploadService {

    @Override
    public ResponseResult uploadImg(MultipartFile file) {
        // 1.通过工具类获取常量值
        String endPoint = ConstantPropertiesUtils.END_POIND;
        String accessKeyId = ConstantPropertiesUtils.ACCESS_KEY_ID;
        String accessKeySecret = ConstantPropertiesUtils.ACCESS_KEY_SECRET;
        String bucketName = ConstantPropertiesUtils.BUCKET_NAME;
        try {
            // 2.创建OSS实例
            OSS ossClient = new OSSClientBuilder().build(endPoint, accessKeyId, accessKeySecret);
            // 3.获取上传的文件的输入流
            InputStream inputStream = file.getInputStream();
            // 4.获取文件名称
            String fileName = file.getOriginalFilename();

            /**
             * 6.调用oss方法实现上传
             * 第一个参数 Bucket名称
             * 第二个参数 上传oss文件路径和名称 aa/bb/1.jpg
             * 第三个参数 上传文件的输入流
             */

            // 7.在文件名称里面添加随机唯一值，使用UUID生成
            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
            fileName = uuid + fileName;
            // 8.把文件按照日期进行分类
            // 获取当前日期
            String datePath = new DateTime().toString("yyyy/MM/dd");
            // 9.拼接fileName
            fileName = datePath + "/" + fileName;
            // 10.如果需要上传时设置存储类型与访问权限，请参考以下示例代码。
            ObjectMetadata metadata = new ObjectMetadata();         metadata.setContentType(getContentType(fileName.substring(fileName.lastIndexOf("."))));

            // 11.<yourObjectName>表示上传文件到OSS时需要指定包含文件后缀在内的完整路径，例如abc/efg/123.jpg。
            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, fileName, inputStream);
            putObjectRequest.setMetadata(metadata);
            // ossClient.putObject(bucketName, fileName, inputStream);
            ossClient.putObject(putObjectRequest);
            // 12.关闭ossClient
            ossClient.shutdown();
            // 13.把上传到oss的路径返回
            // 需要将路径手动拼接出来，https://xxxxxx.oss-cn-shanghai.aliyuncs.com/edu/avatar/girl.jpg
            String url = "https://"+ bucketName + "." + endPoint + "/" + fileName;
            return ResponseResult.okResult(url);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 返回contentType
     * @param FileNameExtension
     * @return
     */
    public static String getContentType(String FileNameExtension) {
        if (FileNameExtension.equalsIgnoreCase(".bmp")) {
            return "image/bmp";
        }
        if (FileNameExtension.equalsIgnoreCase(".gif")) {
            return "image/gif";
        }
        if (FileNameExtension.equalsIgnoreCase(".jpeg") ||
                FileNameExtension.equalsIgnoreCase(".jpg") ||
                FileNameExtension.equalsIgnoreCase(".png")
        ) {
            return "image/jpg";
        }
        return "image/jpg";
    }
}

