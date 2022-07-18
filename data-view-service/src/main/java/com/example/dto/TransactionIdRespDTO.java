package com.example.dto;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TransactionIdRespDTO {

    private String transactionId;

    @JsonCreator
    public TransactionIdRespDTO(@JsonProperty("transactionId") String transactionId) {
        this.transactionId = transactionId;
    }
}
