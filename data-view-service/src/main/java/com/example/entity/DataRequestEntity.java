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
@Table(name = "data_request_dtls")
public class DataRequestEntity {

    @Id
    private String transactionId;
    private String timestamp;
    private String appointmentId;
    private String dateRangeFrom;
    private String dateRangeTo;
    private String dataPushUrl;
    @Column(columnDefinition = "TEXT")
    private String request;
    @Column(name = "isCalled", columnDefinition = "boolean default false")
    private boolean status;
    private String keyCryptoAlg;
    private String keyCurve;
    private String keyExpiry;
    private String keyParameters;
    private String receiverPublicKey;
    private String receiverPrivateKey;
    private String receiverNonce;
}
