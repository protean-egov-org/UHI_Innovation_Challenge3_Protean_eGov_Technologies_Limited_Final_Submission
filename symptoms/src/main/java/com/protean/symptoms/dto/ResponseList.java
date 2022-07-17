package com.protean.symptoms.dto;

import java.util.List;

import lombok.Data;

@Data
public class ResponseList {
	
	private List<SymptomsList> items;
}
