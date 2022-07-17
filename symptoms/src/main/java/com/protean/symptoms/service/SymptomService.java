package com.protean.symptoms.service;

import java.util.List;

import com.protean.symptoms.dto.AdviceResponse;
import com.protean.symptoms.dto.MainResponseDTO;
import com.protean.symptoms.dto.MedicineResponse;
import com.protean.symptoms.dto.PatientResponseList;
import com.protean.symptoms.dto.ResponseList;

public interface SymptomService {

	public MainResponseDTO<ResponseList> fetchSymptomDetailsList(String query);

	public MainResponseDTO<ResponseList> fetchDiagnosisDetailsList(String query);

	public MainResponseDTO<List<PatientResponseList>> fetchPatientDetailsList();

	public MainResponseDTO<List<AdviceResponse>> fetchAdvices();

	public MainResponseDTO<List<MedicineResponse>> fetchMedicine();
}
