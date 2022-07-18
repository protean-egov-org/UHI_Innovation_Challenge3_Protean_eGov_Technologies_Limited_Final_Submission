package com.example.entity;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "data_transfer_dtls")
public class DataTransferEntity {

    @Id
    private String id;
    @Column(name = "labname")
    private String labName;
    private String transactionId;
    private String appointmentId;
    private String timestamp;
    @Column(columnDefinition = "TEXT")
    private String fhirString;
    @Column(name = "isCalled", columnDefinition = "boolean default false")
    private boolean status;

}
