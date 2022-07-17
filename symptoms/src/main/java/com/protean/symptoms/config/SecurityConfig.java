/**
 * 
 */
package com.protean.symptoms.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class SecurityConfig {
	
	@Bean
	public RestTemplate getRestTemlate() {
		return new RestTemplate();
	}
}
