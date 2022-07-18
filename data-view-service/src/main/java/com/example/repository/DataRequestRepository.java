package com.example.repository;

import com.example.entity.DataRequestEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DataRequestRepository extends JpaRepository<DataRequestEntity, String> {

    DataRequestEntity findByTransactionId(String transactionId);

    DataRequestEntity findByAppointmentId(String appointmentId);
}
