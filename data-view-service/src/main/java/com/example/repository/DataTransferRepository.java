package com.example.repository;

import com.example.entity.DataTransferEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DataTransferRepository extends JpaRepository<DataTransferEntity, String> {

    List<DataTransferEntity> findAllByLabName(String labName);

    List<DataTransferEntity> findAllByTransactionId(String transactionId);

    List<DataTransferEntity> findAllByAppointmentId(String appointmentId);

    List<DataTransferEntity> findAllByLabNameAndAppointmentId(String labName, String appointmentId);

    List<DataTransferEntity> findAllByTransactionIdAndAppointmentId(String transactionId, String appointmentId);

    List<DataTransferEntity> findAllByAppointmentIdAndTimestamp(String appointmentId, String timestamp);

    List<DataTransferEntity> findAllByLabNameAndAppointmentIdAndTimestamp(String labName, String appointmentId,
                                                                           String timestamp);

}
