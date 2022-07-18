package com.protean.repository;

import com.protean.entity.HipRequestEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HipRequestRepository extends JpaRepository<HipRequestEntity, String> {
}
