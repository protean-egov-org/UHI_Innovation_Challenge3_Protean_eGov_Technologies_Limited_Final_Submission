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
public class DocumentReferenceDTO {
    private String id;
    private String addProfile;
    private String subjectReference;
    private CodingDTO typeCode;
    private String documentText;
    private String docContentType;
    private String docLanguage;
    private String docTitle;
    private String docCreationDate;
    private String docData;
}
