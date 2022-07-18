package com.protean.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name="patient_dtls", schema = "public")
public class PatientDtlsEntity {

    @Id
    @Column(name="pd_id_pk")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name="pd_dr_name")
    private String drName;

    @Column(name="pd_patient_name")
    private String ptName;

    @Column(name="pd_mobile_no")
    private String mobileNo;

    @Column(name="pd_email")
    private String email;

    @Column(name="pd_appointment_id")
    private Integer apptId;

    @Column(name="pd_blood_grp")
    private String bloodGrp;

    @Column(name="pd_height")
    private Integer height;

    @Column(name="pd_weight")
    private Integer weight;

    @Column(name="pd_gender")
    private String gender;

    @Column(name="pd_dob")
    private String dob;

    @Column(name="pd_abha_id")
    private String abhaId;

    @Column(name="pd_abha_no")
    private String abhaNo;
}
