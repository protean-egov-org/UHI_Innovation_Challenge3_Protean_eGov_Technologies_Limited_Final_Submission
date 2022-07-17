package com.protean.symptoms.dto;

import lombok.Data;

@Data
public class SymptomsList {


	private Boolean local;

	private Boolean active;

	private String name;
	
	private String code;
	
	private String terminology;
	
	private Boolean sufficientlyDefined;

}
