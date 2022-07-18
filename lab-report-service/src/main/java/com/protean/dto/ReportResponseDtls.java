package com.protean.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ReportResponseDtls {
/*    private String reportType;
    private String reportName;*/
    private String reportDoc;
    private String docCreationTimestamp;
}
