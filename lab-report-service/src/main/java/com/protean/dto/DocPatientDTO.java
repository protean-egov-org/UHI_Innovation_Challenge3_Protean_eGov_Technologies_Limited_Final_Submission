package com.protean.dto;

import lombok.Builder;
import lombok.Data;

import java.math.BigInteger;

@Data
@Builder
public class DocPatientDTO {
    private BigInteger uniqueId;
    private String patientName;
    private String doctorName;
}
