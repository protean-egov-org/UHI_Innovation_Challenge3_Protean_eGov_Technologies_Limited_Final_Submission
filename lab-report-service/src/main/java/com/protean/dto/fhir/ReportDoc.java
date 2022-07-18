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
public class ReportDoc {
    private String docContentType;
    private String docLanguage;
    private String docTitle;
    private String docCreationDate;
    private String docData;
}
