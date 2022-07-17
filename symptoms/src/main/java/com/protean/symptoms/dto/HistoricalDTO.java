package com.protean.symptoms.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class HistoricalDTO {
    private String date;
    private String symptoms;
    private String advices;
    private Integer bloodPressureMin;
    private Integer bloodPressureMax;
    private String daignosis;
    private String medicines;
    private Integer temperature;
    private Integer respiratoryRate;
    private Integer heartRate;
    private String pdfPath;
    private byte[] pdfData;
    private String jsonPath;
    private String jsonData;
}
