package com.protean.symptoms.dto;

import lombok.Data;

@Data
public class SavePriscriptionRequest {
	
	private String drName;
	
	private String ptName;

	private String symptoms;

	private String daignosis;

	private String advice;

	private String medicines;

	private Integer temperature;

	private Integer respiratoryRate;

	private Integer bloodPressureMax;
	
	private Integer bloodPressureMin;

	private Integer heartRate;
	
	private Integer uniqueId;
}
