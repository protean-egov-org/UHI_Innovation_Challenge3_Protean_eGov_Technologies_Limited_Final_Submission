package com.protean.entity;

import lombok.Data;

import javax.persistence.*;
import java.math.BigInteger;

@Data
@Entity
@Table(name="priscription_dtls", schema = "public")
public class PriscriptionDtlsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="pd_id_pk")
    private Integer id;

    @Column(name="pd_dr_name")
    private String drName;

    @Column(name="pd_patient_name")
    private String ptName;

    @Column(name="pd_symptoms")
    private String symptoms;

    @Column(name="pd_diagnosis")
    private String diagnosis;

    @Column(name="pd_medicine")
    private String medicines;

    @Column(name="pd_advice")
    private String advice;

    @Column(name="pd_temperature")
    private Integer temperature;

    @Column(name="pd_respiratory_Rate")
    private Integer respiratoryRate;

    @Column(name="pd_heart_rate")
    private Integer heartRate;

    @Column(name="pd_blood_pressure_max")
    private Integer bloodPressureMax;

    @Column(name="pd_blood_pressure_min")
    private Integer bloodPressureMin;

    @Column(name="pd_priscription_path")
    private String pdfPath;

    @Column(name="pd_json_path")
    private String jsonPath;

    @Column(name="uniqueid")
    private BigInteger uniqueId;
}
