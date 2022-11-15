package com.dzl.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

@Configuration
public class SwaggerConfig {
    @Bean
    public Docket customDocket() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.dzl.controller"))
                .build();
    }

    private ApiInfo apiInfo() {
        Contact contact = new Contact("都忠良", "http://www.my.com", "2354315459my@my.com");
        return new ApiInfoBuilder()
                .title("博客")
                .description("springboot+vu博客项目")
                .contact("2354315459@qq.com")   // 联系方式
                .version("1.1.0")  // 版本
                .build();
    }
}
