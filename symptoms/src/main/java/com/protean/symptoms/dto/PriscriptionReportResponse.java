package com.protean.symptoms.dto;

import lombok.Data;

@Data
public class PriscriptionReportResponse {

//	private String pdfName;

	private String pdfPath;

	private byte[] pdfData;

}
