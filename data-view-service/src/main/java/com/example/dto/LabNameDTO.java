package com.example.dto;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LabNameDTO {

    private String labName;

    @JsonCreator
    public LabNameDTO(@JsonProperty("labName") String labName) {
        this.labName = labName;
    }

}
