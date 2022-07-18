package com.protean.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class KeyMaterialDTO {
    private String cryptoAlg;
    private String curve;
    private DhPublicKeyDTO dhPublicKey;
    private String nonce;
}
