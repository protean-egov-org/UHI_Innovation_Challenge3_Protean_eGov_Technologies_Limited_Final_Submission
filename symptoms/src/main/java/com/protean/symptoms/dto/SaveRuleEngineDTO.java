package com.protean.symptoms.dto;

import java.util.List;

import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class SaveRuleEngineDTO {

	@NotNull
	private Long diagnosisId;
	@NotNull
	private List<Long> symptomsIds;
	@NotNull
	private List<Long> medicineIds;
	@NotNull
	private List<Long> adviceIds;

	

}
