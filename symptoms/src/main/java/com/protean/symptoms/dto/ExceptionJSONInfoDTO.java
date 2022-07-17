package com.protean.symptoms.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class ExceptionJSONInfoDTO implements Serializable {
	private static final long serialVersionUID = 3999014525078508265L;

	private String errorCode;

	private String message;
	
	public ExceptionJSONInfoDTO() {

	}

	public ExceptionJSONInfoDTO(String errorCode, String message) {
		this.errorCode=errorCode;
		this.message = message;
	}

}
