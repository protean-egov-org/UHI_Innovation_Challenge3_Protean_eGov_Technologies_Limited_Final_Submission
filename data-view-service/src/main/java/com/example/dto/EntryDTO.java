package com.example.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class EntryDTO {
    private String timestamp;
    private String appointmentId;
    private String content;
    private String media;
}
