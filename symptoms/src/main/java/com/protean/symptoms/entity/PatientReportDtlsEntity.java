package com.protean.symptoms.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="patient_report_dtls", schema = "public")
public class PatientReportDtlsEntity {

	@Id
	@Column(name="prd_id_pk")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column(name="prd_dr_name")
	private String drName;

	@Column(name="prd_patient_name")
	private String ptName;

	@Column(name="prd_report_type")
	private String reportType;
	
	@Column(name="prd_report_path")
	private String reportPath;
	
	@Column(name="prd_created_tmstmp")
	private LocalDateTime createdTime;

	
}
