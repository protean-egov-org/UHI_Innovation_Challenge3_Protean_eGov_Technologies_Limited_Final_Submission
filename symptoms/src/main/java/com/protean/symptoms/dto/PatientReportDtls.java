package com.protean.symptoms.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class PatientReportDtls {

	private String drName;

	private String ptName;
	
	private String reportType;
	
	private String reportPath;
	
	private LocalDateTime createdTime;
}
