package com.protean.repository;

import com.protean.entity.PatientDtlsEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PatientDetailsRepo extends CrudRepository<PatientDtlsEntity, String> {

    @Query(value = "SELECT * FROM public.patient_dtls ORDER BY pd_id_pk ASC", nativeQuery = true)
    public List<PatientDtlsEntity> fetchPateintDtls();

    @Query(value = "SELECT * FROM public.patient_dtls where pd_patient_name= :ptName", nativeQuery = true)
    public PatientDtlsEntity findByptName(@Param("ptName") String ptName);
}
