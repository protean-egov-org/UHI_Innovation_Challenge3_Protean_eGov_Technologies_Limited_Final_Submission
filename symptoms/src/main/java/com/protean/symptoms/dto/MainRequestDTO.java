package com.protean.symptoms.dto;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class MainRequestDTO<T> implements Serializable {

	private static final long serialVersionUID = -4966448852014107698L;

	private String version;
	
	private String id;
	
	private Date requesttime;
	
	private T request;
	
	private String mimeType;
	
	private String API;

}
