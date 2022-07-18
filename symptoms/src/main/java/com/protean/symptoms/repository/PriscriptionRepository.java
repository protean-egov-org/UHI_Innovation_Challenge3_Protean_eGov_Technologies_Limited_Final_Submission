package com.protean.symptoms.repository;

import java.math.BigInteger;
import com.protean.symptoms.entity.PriscriptionDtlsEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PriscriptionRepository extends CrudRepository<PriscriptionDtlsEntity, String> {

	
	@Query(value = "SELECT * FROM public.priscription_dtls where uniqueid= :uniqueId", nativeQuery = true)
	PriscriptionDtlsEntity findByuniqueId(@Param("uniqueId") BigInteger uniqueId);

	List<PriscriptionDtlsEntity> findAll();

}
