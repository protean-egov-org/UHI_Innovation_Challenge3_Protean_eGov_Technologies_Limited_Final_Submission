package com.protean.symptoms.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ExternalDTO {

    private String labName;
    private String pdfData;
}
