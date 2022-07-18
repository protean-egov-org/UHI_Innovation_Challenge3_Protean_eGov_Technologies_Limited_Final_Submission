package com.protean.entity;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "hip_request_dtls")
public class HipRequestEntity {
    @Id
    private String transactionId;
    private String labName;
    private String patientName;
    private String timestamp;
    private String appointmentId;
    private String dateRangeFrom;
    private String dateRangeTo;
    private String dataPushUrl;
    private String keyCryptoAlg;
    private String keyCurve;
    private String keyExpiry;
    private String keyParameters;
    private String receiverPublicKey;
    private String receiverNonce;
}
