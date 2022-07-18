package com.protean.symptoms.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.protean.symptoms.dto.AdviceResponse;
import com.protean.symptoms.dto.MainRequestDTO;
import com.protean.symptoms.dto.MainResponseDTO;
import com.protean.symptoms.dto.MainResponseSymptomsDTO;
import com.protean.symptoms.dto.MedicineResponse;
import com.protean.symptoms.dto.PatientResponseList;
import com.protean.symptoms.dto.ResponseList;
import com.protean.symptoms.dto.SaveRuleEngineDTO;
import com.protean.symptoms.dto.SymptomDetailsDTO;
import com.protean.symptoms.service.SymptomService;

@RestController
@RequestMapping(value="/symptoms")
public class SymptomController {
	private static final Logger logger = LoggerFactory.getLogger(SymptomController.class);
	
	@Autowired
	SymptomService symptomService;
	
	@GetMapping(value = "/getSymptomDetailsList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<MainResponseDTO<ResponseList>> getSymptomDetailsList(@RequestParam(name="query", required = true) String query) {
		logger.info("Request Receive for getSymptomDetailsList");
		 
		return ResponseEntity.status(HttpStatus.OK).body(symptomService.fetchSymptomDetailsList(query));
   }
	
	@GetMapping(value = "/getDiagnosisDetailsList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<MainResponseDTO<ResponseList>> getDiagnosisDetailsList(@RequestParam(name="query", required = true) String query) {
		logger.info("Request Receive for getDiagnosisDetailsList");
		 
		return ResponseEntity.status(HttpStatus.OK).body(symptomService.fetchDiagnosisDetailsList(query));
   }
	
	@GetMapping(value = "/getPatientDetailsList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<MainResponseDTO<List<PatientResponseList>>> getPatientDetailsList() {
		logger.info("Request Receive for getPatientDetailsList");
		 
		return ResponseEntity.status(HttpStatus.OK).body(symptomService.fetchPatientDetailsList());
   }
	
	
	@GetMapping(value = "/advice")
	public ResponseEntity<MainResponseDTO<List<AdviceResponse>>> fetchAllAdvice() {
		logger.info("Request Receive for advice");
		
		return ResponseEntity.status(HttpStatus.OK).body(symptomService.fetchAdvices());
	}

	@GetMapping(value = "/medicines")
	public ResponseEntity<MainResponseDTO<List<MedicineResponse>>> fetchAllMedicines() {
		logger.info("Request Receive for medicines");
		
		return ResponseEntity.status(HttpStatus.OK).body(symptomService.fetchMedicine());
	}
	
	@GetMapping(value = "/getSearchEngineDetailsBySymtpoms")
	public @ResponseBody MainResponseSymptomsDTO fetchSearchEngineDetailsBySymtpoms(
			@RequestParam(value = "id") String id) {

		// preparing the id list from comma separated string
		List<Long> idList = Stream.of(id.split(",")).map(Long::valueOf).sorted().collect(Collectors.toList());
		
		SymptomDetailsDTO fetchSymptomsById = symptomService.fetchSymptomsById(idList);
		MainResponseSymptomsDTO mainResponseDTO = new MainResponseSymptomsDTO();
		mainResponseDTO.setId("Symptoms");
		mainResponseDTO.setVersion("1.0");
		mainResponseDTO.setResponsetime(LocalDateTime.now());
		mainResponseDTO.setResponse(fetchSymptomsById);
		mainResponseDTO.setStatus(true);
		return mainResponseDTO;
	}
	
	@PostMapping(path = "/saveOrUpdateSearchEngineDetails", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody MainResponseDTO<String> saveOrUpdateSearchEngineDetails(
			@Valid @RequestBody MainRequestDTO<SaveRuleEngineDTO> request) {
		return symptomService.saveOrUpdateSearchEngineDetails(request);
	}
	
}
