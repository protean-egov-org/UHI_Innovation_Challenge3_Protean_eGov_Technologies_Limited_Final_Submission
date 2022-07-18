package com.example.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class DataTransferDTO {

    private String labName;
    private String transactionId;
    private List<EntryDTO> entries;
    private KeyMaterialDTO keyMaterial;
}
