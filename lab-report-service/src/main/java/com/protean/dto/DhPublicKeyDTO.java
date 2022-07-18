package com.protean.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DhPublicKeyDTO {
    private String expiry;
    private String parameters;
    private String keyValue;
}
