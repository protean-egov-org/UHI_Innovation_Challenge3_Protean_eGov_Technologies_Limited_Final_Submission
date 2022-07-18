package com.example.dto;

import com.example.utility.keys.KeyMaterial;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class KeygenMaterialDTO {
    private KeyMaterial keygen;
    private KeyMaterialDTO keyMaterialDTO;
}
