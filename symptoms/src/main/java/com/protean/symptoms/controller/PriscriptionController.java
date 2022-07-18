package com.protean.symptoms.controller;

import com.protean.symptoms.dto.*;
import com.protean.symptoms.service.PriscriptionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.math.BigInteger;
import java.util.List;

@RestController
@RequestMapping(value="/priscription")
public class PriscriptionController {

	private static final Logger logger = LoggerFactory.getLogger(PriscriptionController.class);
	
	@Autowired
	PriscriptionService priscriptionService;
	
	@PostMapping(value = "/savePriscriptionDtls", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<MainResponseDTO<String>> savePriscriptionDtls(@RequestBody @Valid MainRequestDTO<SavePriscriptionRequest> saveRequest) {
		logger.info("Request Receive for savePriscriptionDtls");
		 
		return ResponseEntity.status(HttpStatus.OK).body(priscriptionService.fetchSymptomDetailsList(saveRequest));
   }
	
	@GetMapping(value = "/getPriscriptionReport/{uniqueId}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<MainResponseDTO<PriscriptionReportResponse>> getPriscriptionReport(@PathVariable("uniqueId") BigInteger uniqueId) {
		logger.info("Request Receive for savePriscriptionDtls");
		 
		return ResponseEntity.status(HttpStatus.OK).body(priscriptionService.fetchPriscriptionReport(uniqueId));
   }
	
	
	
	
	@GetMapping(value = "/downloadPatientReport/{patientName}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<MainResponseDTO<List<PatientReportDTO>>> downloadDocument(@PathVariable("patientName") String patientName) {
		MainResponseDTO<List<PatientReportDTO>> responseWrapper = new MainResponseDTO<List<PatientReportDTO>>();
		responseWrapper=priscriptionService.getPatientReportDetails(patientName);
		logger.debug("Returning from Download Patient Report of Controller");
		return ResponseEntity.ok().body(responseWrapper);
	}

	@GetMapping(value = "/view-historical-data", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<MainResponseDTO<List<HistoricalDTO>>> getHistoricalData() {
		logger.info("Request Receives for getHistoricalData");

		return ResponseEntity.status(HttpStatus.OK).body(priscriptionService.fetchHistoricalData());
	}

	@GetMapping(value = "/external-data", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<MainResponseDTO<List<ExternalDTO>>> getExternalData() {
		logger.info("Request Receives for getHistoricalData");

		return ResponseEntity.status(HttpStatus.OK).body(priscriptionService.fetchExternalData());
	}

	@GetMapping(value = "/getFetchRecords", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<MainResponseDTO<List<ReportRespDTO>>> getFetchRecords() {
		logger.info("Request Receives for getFetchRecords");

		return ResponseEntity.status(HttpStatus.OK).body(priscriptionService.getFetch());
	}
}
