package com.protean.symptoms.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class DiagnosisDetails implements Serializable {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column (name= "diagnosis_id")
	Long   id;

	@Column (name="diagnosis")
	String name;

	
	

}
