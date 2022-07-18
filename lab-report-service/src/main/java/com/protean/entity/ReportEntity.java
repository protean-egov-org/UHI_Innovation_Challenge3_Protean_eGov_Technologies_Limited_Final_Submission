package com.protean.entity;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "report_dtls")
public class ReportEntity {
    @Id
    @Column(name = "labname")
    private String labName;

    @Column(name = "appointmentid")
    private String appointmentId;

    @Column(name = "patientid")
    private String patientId;

    @Column(name = "patientname")
    private String patientName;

    @Column(name = "abhaid")
    private String abhaId;

    @Column(name = "abhano")
    private String abhaNo;

    @Column(name = "patientgender")
    private String patientGender;

    @Column(name = "patientdob")
    private String patientDob;

    @Column(name = "patientmob")
    private String patientMob;

    @Column(name = "drid")
    private String drId;

    @Column(name = "drname")
    private String drName;

    @Column(name = "dremail")
    private String drEmail;

    @Column(name = "drmob")
    private String drMob;

    @Column(name = "drmcino")
    private String drMciNo;

    @Column(name = "drsmcno")
    private String drSmcNo;

    @Column(name = "drspeciality")
    private String drspeciality;
}
