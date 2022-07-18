package com.protean.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DataRequestDTO {
    private String labName;
    private String transactionId;
    private String timestamp;
    private String appointmentId;
    private DataRangeDTO dateRange;
    private String dataPushUrl;
    private KeyMaterialDTO keyMaterial;
}
