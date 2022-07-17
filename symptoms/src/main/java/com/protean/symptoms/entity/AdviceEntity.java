package com.protean.symptoms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="advice", schema = "master")
public class AdviceEntity {

	@Id
	@Column(name = "id")
	private Long id;

	@Column(name = "name")
	private String name;

	
}
