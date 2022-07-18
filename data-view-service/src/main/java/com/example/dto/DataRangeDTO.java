package com.example.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DataRangeDTO {

    private String from;
    @JsonProperty("to")
    private String to;

}
