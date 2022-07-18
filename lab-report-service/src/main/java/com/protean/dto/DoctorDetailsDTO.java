package com.protean.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DoctorDetailsDTO {
    private String drId;
    private String drName;
    private String email;
    private String mob;
    private String mciNo;
    private String smcNo;
    private String speciality;
}
