package com.protean.symptoms.dto;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.protean.symptoms.exception.ServiceError;

import lombok.Data;

@Data
public class MainResponseDTO<T> implements Serializable {

	private static final long serialVersionUID = 3384945682672832638L;
	
	private String id;
	
	private String version;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
	private String responsetime = LocalDateTime.now(ZoneId.of("UTC")).toString();
	
	private String mimeType;

	private T response;
	
	private boolean status;

	private List<ServiceError> errors;

}
