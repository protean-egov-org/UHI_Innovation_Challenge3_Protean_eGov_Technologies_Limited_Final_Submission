package com.protean.repository;

import com.protean.entity.ReportEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReportRepository extends JpaRepository<ReportEntity, String> {

    ReportEntity findByLabName(String labname);

}
