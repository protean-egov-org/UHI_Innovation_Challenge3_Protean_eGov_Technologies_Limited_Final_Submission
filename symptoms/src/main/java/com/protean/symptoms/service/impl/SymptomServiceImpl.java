package com.protean.symptoms.service.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.protean.symptoms.dto.AdviceDetails;
import com.protean.symptoms.dto.AdviceResponse;
import com.protean.symptoms.dto.DiagnosisDetails;
import com.protean.symptoms.dto.MainRequestDTO;
import com.protean.symptoms.dto.MainResponseDTO;
import com.protean.symptoms.dto.MedicineResponse;
import com.protean.symptoms.dto.MedicinesDetails;
import com.protean.symptoms.dto.PatientResponseList;
import com.protean.symptoms.dto.ResponseList;
import com.protean.symptoms.dto.SaveRuleEngineDTO;
import com.protean.symptoms.dto.SymptomDetailsDTO;
import com.protean.symptoms.entity.AdviceEntity;
import com.protean.symptoms.entity.MedicineEntity;
import com.protean.symptoms.entity.PatientDtlsEntity;
import com.protean.symptoms.entity.SearchEngineDetails;
import com.protean.symptoms.repository.AdviceRepository;
import com.protean.symptoms.repository.MedicinesRepository;
import com.protean.symptoms.repository.PatientDetailsRepo;
import com.protean.symptoms.repository.SearchEngineDetailsRepository;
import com.protean.symptoms.service.SymptomService;
import com.protean.symptoms.utility.AuthUtil;

@Service
public class SymptomServiceImpl implements SymptomService{
	
	private static final Logger logger = LoggerFactory.getLogger(SymptomServiceImpl.class);

	@Autowired
	private RestTemplate restTemplate;

	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	PatientDetailsRepo patientDetailsRepo;
	
	@Autowired
	AdviceRepository adviceRepository;
	
	@Autowired
	MedicinesRepository medicinesRepository;
	
	@Value("${external.api.url}")
	private String symptomsUrl;
	
	@Value("${external.api.url.disorder}")
	private String diagnosisUrl;
	
	@Value("${active.param}")
	private String activeParam;
	
	@Value("${resolver.param}")
	private String resolverParam;
	
	@Value("${handler.param}")
	private String handlerParam;
	
	@Value("${offset.param}")
	private String offsetParam;
	
	@Value("${limit.param}")
	private String limitParam;
	
	@Value("${expression.finding}")
	private String findingParam;
	
	@Value("${expression.disorder}")
	private String disorderParam;
	
	@Autowired
	SearchEngineDetailsRepository searchEngRepo;
	
	@Autowired
	ObjectMapper mapper;
	
	@Override
	public MainResponseDTO<ResponseList> fetchSymptomDetailsList(String query) {
		MainResponseDTO<ResponseList> response = new MainResponseDTO<ResponseList>();
		ResponseList masterDataObjt= null;
		try {
		ResponseEntity<String> entityResponse = restTemplate.getForEntity(symptomsUrl, String.class, query,activeParam,resolverParam,handlerParam,offsetParam,limitParam,findingParam);
		masterDataObjt = objectMapper.readValue(entityResponse.getBody(),ResponseList.class);
		}catch (Exception e) {
    		e.printStackTrace();
    	}	
		response.setResponse(masterDataObjt);
		response.setStatus(true);
		return response;
	}

	@Override
	public MainResponseDTO<ResponseList> fetchDiagnosisDetailsList(String query) {
		
		MainResponseDTO<ResponseList> response = new MainResponseDTO<ResponseList>();
		ResponseList masterDataObjt= null;
		try {
		ResponseEntity<String> entityResponse = restTemplate.getForEntity(diagnosisUrl, String.class, query,activeParam,resolverParam,handlerParam,offsetParam,limitParam,disorderParam);
		masterDataObjt = objectMapper.readValue(entityResponse.getBody(),ResponseList.class);
		}catch (Exception e) {
    		e.printStackTrace();
    	}	
		response.setResponse(masterDataObjt);
		response.setStatus(true);	
		return response;
	}

	@Override
	public MainResponseDTO<List<PatientResponseList>> fetchPatientDetailsList() {
		MainResponseDTO<List<PatientResponseList>> response = new MainResponseDTO<List<PatientResponseList>>();
		List<PatientResponseList> patientList= new ArrayList<PatientResponseList>();
		List<PatientDtlsEntity> patientEntityList= patientDetailsRepo.fetchPateintDtls();	
		if(patientEntityList!=null) {
			for(PatientDtlsEntity patientDtls : patientEntityList) {
				PatientResponseList patientResponse = new PatientResponseList();
				patientResponse.setDrName(patientDtls.getDrName());
				patientResponse.setPtName(patientDtls.getPtName());
				patientResponse.setDob(patientDtls.getDob());
				patientResponse.setHeight(patientDtls.getHeight());
				patientResponse.setWeight(patientDtls.getWeight());
				patientResponse.setEmail(patientDtls.getEmail());
				patientResponse.setBloodGrp(patientDtls.getBloodGrp());
				patientResponse.setGender(patientDtls.getGender());
				patientResponse.setAbhaId(patientDtls.getAbhaId());
				patientResponse.setAbhaNo(patientDtls.getAbhaNo());
				patientResponse.setAppointmentId(patientDtls.getApptId());
				patientResponse.setMobileNo(patientDtls.getMobileNo());
				patientList.add(patientResponse);
		}
	}
		response.setResponse(patientList);
		response.setStatus(true);
		return response;
	}

	@Override
	public MainResponseDTO<List<AdviceResponse>> fetchAdvices() {
		MainResponseDTO<List<AdviceResponse>> response = new MainResponseDTO<List<AdviceResponse>>();
		List<AdviceResponse> adviceResponse=new ArrayList<AdviceResponse>();
		List<AdviceEntity> adviceEntity= adviceRepository.findAll();
		
		if(adviceEntity!=null) {
		for(AdviceEntity advice:adviceEntity) {
			AdviceResponse adviceDto = new AdviceResponse();
			adviceDto.setId(advice.getId());
			adviceDto.setName(advice.getName());
			adviceResponse.add(adviceDto);
		}
		}
		response.setResponse(adviceResponse);
		response.setStatus(true);
		return response;
	}

	@Override
	public MainResponseDTO<List<MedicineResponse>> fetchMedicine() {
		MainResponseDTO<List<MedicineResponse>> response = new MainResponseDTO<List<MedicineResponse>>();
		List<MedicineResponse> medicineList=new ArrayList<MedicineResponse>();
		List<MedicineEntity> medicineEntity = medicinesRepository.findAll();
		
		if(medicineEntity != null) {
			for(MedicineEntity entity :medicineEntity) {
				MedicineResponse medDto = new MedicineResponse();
				medDto.setId(entity.getId());
				medDto.setName(entity.getName());
				medicineList.add(medDto);
			}
		}
		response.setResponse(medicineList);
		response.setStatus(true);
		return response;
	}

	
	public List<DiagnosisDetails> fetchDiagnosisDetails(List<Long> idList) {
		List<Object[]> fetchDiagnosisDetailsList = searchEngRepo.fetchDiagnosisDetails(idList);

		List<DiagnosisDetails> fetchDiagnosisDetails = new ArrayList<DiagnosisDetails>();
		if (fetchDiagnosisDetailsList != null && !fetchDiagnosisDetailsList.isEmpty()) {

			for (Object[] obj : fetchDiagnosisDetailsList) {

				DiagnosisDetails diagnosisDetails = new DiagnosisDetails();
				for (Object obj1 : obj) {

					if (obj1 instanceof Long) {
						Long daignosisId = (Long) obj1;
						diagnosisDetails.setId(daignosisId);
					}

					if (obj1 instanceof String) {
						String diagnosisName = (String) obj1;
						diagnosisDetails.setName(diagnosisName);
					}
				}
				fetchDiagnosisDetails.add(diagnosisDetails);
			}
		}

		return fetchDiagnosisDetails;
	}

	public List<MedicinesDetails> fetchMedicinesDetails(List<Long> idList) {
		List<Object[]> fetchMedicinesDetailsList = searchEngRepo.fetchMedicinesDetails(idList);

		List<MedicinesDetails> fetchMedicinesDetails = new ArrayList<MedicinesDetails>();
		if (fetchMedicinesDetailsList != null && !fetchMedicinesDetailsList.isEmpty()) {

			for (Object[] obj : fetchMedicinesDetailsList) {

				MedicinesDetails medicinesDetails = new MedicinesDetails();
				for (Object obj1 : obj) {

					if (obj1 instanceof Long) {
						Long daignosisId = (Long) obj1;
						medicinesDetails.setId(daignosisId);
					}
					if (obj1 instanceof String) {
						String diagnosisName = (String) obj1;
						medicinesDetails.setName(diagnosisName);
					}
				}
				fetchMedicinesDetails.add(medicinesDetails);
			}
		}

		return fetchMedicinesDetails;
	}

	public List<AdviceDetails> fetchAdviceDetails(List<Long> idList) {
		List<Object[]> fetchAdviceDetailsList = searchEngRepo.fetchAdviceDetails(idList);

		List<AdviceDetails> fetchAdviceDetails = new ArrayList<AdviceDetails>();
		if (fetchAdviceDetailsList != null && !fetchAdviceDetailsList.isEmpty()) {

			for (Object[] obj : fetchAdviceDetailsList) {

				AdviceDetails adviceDetails = new AdviceDetails();
				for (Object obj1 : obj) {

					if (obj1 instanceof Long) {
						Long daignosisId = (Long) obj1;
						adviceDetails.setId(daignosisId);
					}

					if (obj1 instanceof String) {
						String diagnosisName = (String) obj1;
						adviceDetails.setName(diagnosisName);
					}
				}
				fetchAdviceDetails.add(adviceDetails);
			}
		}
		return fetchAdviceDetails;
	}
	
	
	@Override
	public SymptomDetailsDTO fetchSymptomsById(List<Long> idList) {
		
	//	List<DiagnosisDetails> fetchDiagnosisDetails = this.fetchDiagnosisDetails(idList);
		List<AdviceDetails> fetchAdvicesDetails = this.fetchAdviceDetails(idList);
		List<MedicinesDetails> fetchMedicinesDetails = this.fetchMedicinesDetails(idList);

		SymptomDetailsDTO symptomInfo = new SymptomDetailsDTO();
		//symptomInfo.setDiagnosisDetails(fetchDiagnosisDetails);
		symptomInfo.setMedicinesDetails(fetchMedicinesDetails);
		symptomInfo.setAdvicesDetails(fetchAdvicesDetails);

		return symptomInfo;
	}

	@Override
	public MainResponseDTO<String> saveOrUpdateSearchEngineDetails(@Valid MainRequestDTO<SaveRuleEngineDTO> request) {
		
		MainResponseDTO<String> response = new MainResponseDTO<String>();
		response = (MainResponseDTO<String>) AuthUtil.getMainResponseDto(request);

		SearchEngineDetails ruleEngineDetails = searchEngRepo
				.getSearchEngineDetailsByDiagnosisId(request.getRequest().getDiagnosisId());

		try {
			if (ruleEngineDetails == null) {
				SearchEngineDetails entity = new SearchEngineDetails();
				entity.setDiagnosisId(request.getRequest().getDiagnosisId());
				entity.setSymptomsId(mapper.writeValueAsString(request.getRequest().getSymptomsIds()));
				entity.setMedicineId(mapper.writeValueAsString(request.getRequest().getMedicineIds()));
				entity.setAdviceId(mapper.writeValueAsString(request.getRequest().getAdviceIds()));
				entity.setCreatedAt(LocalDateTime.now());
				entity.setUpdatedAt(LocalDateTime.now());
				searchEngRepo.save(entity);
				response.setResponse("Rule Engine Details Created Successfully");
			} else {
				ruleEngineDetails.setSymptomsId(mapper.writeValueAsString(request.getRequest().getSymptomsIds()));
				ruleEngineDetails.setMedicineId(mapper.writeValueAsString(request.getRequest().getMedicineIds()));
				ruleEngineDetails.setAdviceId(mapper.writeValueAsString(request.getRequest().getAdviceIds()));
				searchEngRepo.save(ruleEngineDetails);
				response.setResponse("Rule Engine Details Updated Successfully");
			}
			response.setStatus(true);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.setStatus(false);
		}
		return response;
		
	}

}
