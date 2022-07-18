package com.protean.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ReportDTO {
    private String labName;
    private String appointmentId;
    private String patientId;
    private String patientName;
    private String abhaId;
    private String abhaNo;
    private String patientGender;
    private String patientDob;
    private String patientMob;
    private String drId;
    private String drName;
    private String drEmail;
    private String drMob;
    private String drMciNo;
    private String drSmcNo;
    private String drspeciality;
}
