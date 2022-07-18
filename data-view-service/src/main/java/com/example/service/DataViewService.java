package com.example.service;

import com.example.dto.DataRequestDTO;
import com.example.dto.DataTransferDTO;
import com.example.dto.LabNameDTO;
import com.example.dto.TransactionIdRespDTO;

import java.util.List;
import java.util.Map;

public interface DataViewService {

    TransactionIdRespDTO dataRequest(Map<String, String> headers, DataRequestDTO dataRequestDTO);

    boolean hiInfoTransfer(DataTransferDTO dataTransferDTO);

    void fetchRequest(LabNameDTO labNameDTO);

    List<String> findReportByLabName(String labName);
}
