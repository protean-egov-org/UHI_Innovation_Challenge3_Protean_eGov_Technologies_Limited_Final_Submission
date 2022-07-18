package com.protean.service;

import com.protean.dto.DataRequestDTO;
import com.protean.dto.DocPatientDTO;
import com.protean.dto.LabNameDTO;

import java.util.List;

public interface DataCommService {

    List<String> docNameList();

    void requestData(DataRequestDTO dataRequestDTO);

    void getByLabName(LabNameDTO labNameDTO);

    void saveJson(DocPatientDTO docPatientDTO);
}
