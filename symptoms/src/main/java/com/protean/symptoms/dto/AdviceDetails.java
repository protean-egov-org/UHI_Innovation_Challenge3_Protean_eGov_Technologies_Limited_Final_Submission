package com.protean.symptoms.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class AdviceDetails implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name= "advice_id")
	Long id;
	
	@Column(name="advice")
	String name;

	
	
	

}
