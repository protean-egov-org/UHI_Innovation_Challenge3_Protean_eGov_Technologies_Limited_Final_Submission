package com.protean.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PatientRegDetailsDTO {
    private String id;
    private String name;
    private String abhaId;
    private String abhaNo;
    private String gender;
    private String dob;
    private String mob;
}
