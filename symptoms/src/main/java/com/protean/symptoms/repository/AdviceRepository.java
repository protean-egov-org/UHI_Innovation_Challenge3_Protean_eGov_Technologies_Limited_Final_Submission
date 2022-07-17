package com.protean.symptoms.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.protean.symptoms.entity.AdviceEntity;

@Repository
public interface AdviceRepository extends JpaRepository<AdviceEntity, String>{



}
