package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

import java.net.UnknownHostException;

@SpringBootApplication
public class DataViewServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(DataViewServiceApplication.class, args);
    }

    /*
     * for rest template bean
     */
    @Bean
    public RestTemplate restTemplate() throws UnknownHostException {
        return new RestTemplate();
    }

}
