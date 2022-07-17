package com.protean.symptoms.dto;

import lombok.Data;

@Data
public class PatientReportDTO {
	
	private String ptName;
	
	private String report;

	private String reporttype;
	
	// private String mimetype;
	
	private String reportpath;

}
