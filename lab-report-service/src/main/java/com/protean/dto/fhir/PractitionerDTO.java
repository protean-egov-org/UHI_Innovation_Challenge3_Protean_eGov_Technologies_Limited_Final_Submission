package com.protean.dto.fhir;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@Builder
@Component
@NoArgsConstructor
@AllArgsConstructor
public class PractitionerDTO {
    private String id;
    private String versionId;
    private String lastUpdatedElement;
    private String addProfile;
    private String divAsString;
    private CodingDTO codingDTO;
    private String identifierSystem;
    private String identifierValue;
    private String nameText;
}
