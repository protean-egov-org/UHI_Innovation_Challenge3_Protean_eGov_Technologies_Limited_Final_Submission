package com.protean.symptoms.service;

import com.protean.symptoms.dto.*;

import javax.validation.Valid;
import java.util.List;

public interface PriscriptionService {

	public MainResponseDTO<String> fetchSymptomDetailsList(@Valid MainRequestDTO<SavePriscriptionRequest> saveRequest);

	public MainResponseDTO<PriscriptionReportResponse> fetchPriscriptionReport(Integer uniqueId);

	public MainResponseDTO<List<PatientReportDTO>> getPatientReportDetails(String patientName);

	public MainResponseDTO<List<HistoricalDTO>> fetchHistoricalData();

}
