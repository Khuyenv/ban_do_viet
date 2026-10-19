package com.example.ban_do_viet;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class BanDoVietApplication extends SpringBootServletInitializer {

    // Cần thiết để WAR chạy đúng trên cả embedded Tomcat lẫn external server
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(BanDoVietApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(BanDoVietApplication.class, args);
    }

}
