package com.protean.repository;

import com.protean.entity.HipDataEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HipDataRepository extends JpaRepository<HipDataEntity,Long> {

    HipDataEntity findByLabname(String labname);
}
