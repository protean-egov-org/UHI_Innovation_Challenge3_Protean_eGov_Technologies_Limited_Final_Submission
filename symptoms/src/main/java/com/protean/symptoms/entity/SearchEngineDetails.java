package com.protean.symptoms.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.hibernate.annotations.TypeDefs;

import com.vladmihalcea.hibernate.type.json.JsonBinaryType;
import com.vladmihalcea.hibernate.type.json.JsonStringType;

@Entity
@Table(name = "consultation_ruling_engine", schema = "master")
@TypeDefs({
        @TypeDef(name = "json", typeClass = JsonStringType.class),
        @TypeDef(name = "jsonb", typeClass = JsonBinaryType.class)
})
public class SearchEngineDetails implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rule_engine_generator")
	@SequenceGenerator(name = "rule_engine_generator", sequenceName = "master.consultation_ruling_engine_sequence", allocationSize = 1)
	@Column(name = "id")
	private Long id;

	@Column(name = "diagnosis_id")
	private Long diagnosisId;

	@Type(type = "jsonb")
	@Column(name = "symptoms_id", columnDefinition = "json")
	private String symptomsId;

	@Type(type = "jsonb")
	@Column(name = "medicine_id", columnDefinition = "json")
	private String medicineId;

	@Type(type = "jsonb")
	@Column(name = "advice_id", columnDefinition = "json")
	private String adviceId;
	
	@Type(type = "jsonb")
	@Column(name = "investigation_id", columnDefinition = "json")
	private String investigationId;


	@Column(name = "created_at")
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getDiagnosisId() {
		return diagnosisId;
	}

	public void setDiagnosisId(Long diagnosisId) {
		this.diagnosisId = diagnosisId;
	}

	public String getSymptomsId() {
		return symptomsId;
	}

	public void setSymptomsId(String symptomsId) {
		this.symptomsId = symptomsId;
	}

	public String getMedicineId() {
		return medicineId;
	}

	public void setMedicineId(String medicineId) {
		this.medicineId = medicineId;
	}

	public String getAdviceId() {
		return adviceId;
	}

	public void setAdviceId(String adviceId) {
		this.adviceId = adviceId;
	}

	public String getInvestigationId() {
		return investigationId;
	}

	public void setInvestigationId(String investigationId) {
		this.investigationId = investigationId;
	}


	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}