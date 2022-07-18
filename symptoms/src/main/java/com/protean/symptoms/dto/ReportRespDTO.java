package com.protean.symptoms.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ReportRespDTO {
    private String name;
    private List<String> recordsPath;
}
