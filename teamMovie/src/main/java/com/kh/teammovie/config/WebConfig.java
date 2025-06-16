package com.kh.teammovie.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.teammovie.common.interceptor.AdminInterceptor;

@Configuration
@ComponentScan(basePackages = {"com.kh.teammovie"})
public class WebConfig implements WebMvcConfigurer {
//    public WebConfig() {
//        System.out.println("✅ WebConfig 로딩됨");
//    } 로그 확인 용
	
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AdminInterceptor())
                .addPathPatterns("/admin/**")               // 관리자 경로만 감시
                .excludePathPatterns(                       // ❗ 로그인, 메인, 리소스 등 예외처리
                    "/",
                    "/login.me",
                    "/logout.me",
                    "/resources/**",
                    "/css/**",
                    "/js/**",
                    "/images/**",
                    "/member/**",
                    "/error"
                );
    }
}