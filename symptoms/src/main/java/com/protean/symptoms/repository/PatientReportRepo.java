package com.protean.symptoms.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.protean.symptoms.entity.PatientReportDtlsEntity;

public interface PatientReportRepo extends CrudRepository<PatientReportDtlsEntity, String>{

	List<PatientReportDtlsEntity> findByptName(String patientName);

}
