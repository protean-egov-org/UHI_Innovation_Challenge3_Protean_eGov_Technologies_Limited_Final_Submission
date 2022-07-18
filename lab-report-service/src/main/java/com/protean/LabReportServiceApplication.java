package com.protean;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

import java.net.UnknownHostException;

@SpringBootApplication
public class LabReportServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(LabReportServiceApplication.class, args);
    }

    /*
     * for rest template bean
     */
    @Bean
    public RestTemplate restTemplate() throws UnknownHostException {
        return new RestTemplate();
    }
}
