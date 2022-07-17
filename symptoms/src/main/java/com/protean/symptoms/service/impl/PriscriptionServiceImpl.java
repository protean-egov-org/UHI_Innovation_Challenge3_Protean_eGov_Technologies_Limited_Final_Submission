package com.protean.symptoms.service.impl;

import com.protean.symptoms.constants.ConsultationConstants;
import com.protean.symptoms.constants.ErrorConstants;
import com.protean.symptoms.dto.*;
import com.protean.symptoms.entity.PatientDtlsEntity;
import com.protean.symptoms.entity.PatientReportDtlsEntity;
import com.protean.symptoms.entity.PriscriptionDtlsEntity;
import com.protean.symptoms.exception.ConsultationServiceException;
import com.protean.symptoms.repository.PatientDetailsRepo;
import com.protean.symptoms.repository.PatientReportRepo;
import com.protean.symptoms.repository.PriscriptionRepository;
import com.protean.symptoms.service.PriscriptionService;
import com.protean.symptoms.utility.CommonUtils;
import com.protean.symptoms.utility.PdfGenerator;
import org.apache.tomcat.util.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.Valid;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PriscriptionServiceImpl implements PriscriptionService{
	
	private static final Logger logger = LoggerFactory.getLogger(PriscriptionServiceImpl.class);
	
	@Autowired
	PriscriptionRepository priscriptionRepository;
	
	@Autowired
	PatientDetailsRepo patientDetailsRepo;
	
	@Autowired
	private PdfGenerator pdfGenerator;
	
	@Autowired
	PatientReportRepo patientReportRepo;

	@Override
	public MainResponseDTO<String> fetchSymptomDetailsList(@Valid MainRequestDTO<SavePriscriptionRequest> saveRequest) {
		
		MainResponseDTO<String> response = new MainResponseDTO<String>();
		PriscriptionDtlsEntity entity = new PriscriptionDtlsEntity();
		
		if(saveRequest!=null) {
		SavePriscriptionRequest requestDto= saveRequest.getRequest();	
			
		entity.setDrName(requestDto.getDrName());
		entity.setPtName(requestDto.getPtName());
		entity.setSymptoms(requestDto.getSymptoms());
		entity.setMedicines(requestDto.getMedicines());
		entity.setAdvice(requestDto.getAdvice());
		entity.setDiagnosis(requestDto.getDaignosis());
		entity.setTemperature(requestDto.getTemperature());
		entity.setHeartRate(requestDto.getHeartRate());
		entity.setRespiratoryRate(requestDto.getRespiratoryRate());
		entity.setBloodPressureMax(requestDto.getBloodPressureMax());
		entity.setBloodPressureMin(requestDto.getBloodPressureMin());
		entity.setUniqueId(requestDto.getUniqueId());
		 priscriptionRepository.save(entity);
		
		}
		
		response.setResponse("Priscription Saved Successfully");
		response.setStatus(true);
		return response;
	}

	@Override
	public MainResponseDTO<PriscriptionReportResponse> fetchPriscriptionReport(Integer uniqueId) {

		MainResponseDTO<PriscriptionReportResponse> response = new MainResponseDTO<PriscriptionReportResponse>();
		PriscriptionReportResponse report = new PriscriptionReportResponse();
		String pdfFilePath = null;
		byte[] pdfData = null;
		PriscriptionDtlsEntity priscriptionEntity = priscriptionRepository.findByuniqueId(uniqueId);
		if (priscriptionEntity != null) {

			PatientDtlsEntity patientEntity = patientDetailsRepo.findByptName(priscriptionEntity.getPtName());

			String medicationList = priscriptionEntity.getMedicines();
			String symptomsList = priscriptionEntity.getSymptoms();
			String diagnosisList = priscriptionEntity.getDiagnosis();
			String adviceList = priscriptionEntity.getAdvice();
			Map<String, String> details = new HashMap<String, String>();

			details.put(ConsultationConstants.APPTID.getValue(), patientEntity.getApptId().toString());

			details.put(ConsultationConstants.DRNAME.getValue(), patientEntity.getDrName());

			details.put(ConsultationConstants.PTNAME.getValue(), patientEntity.getPtName());

			details.put(ConsultationConstants.PTMOBILENO.getValue(), patientEntity.getMobileNo());
			details.put(ConsultationConstants.GENDER.getValue(), patientEntity.getGender());
			details.put(ConsultationConstants.PTEMAILID.getValue(), patientEntity.getEmail());
			details.put(ConsultationConstants.ABHAID.getValue(),
					(patientEntity.getAbhaId() == null) ? "NA" : patientEntity.getAbhaId());
			details.put(ConsultationConstants.ABHANUMBER.getValue(),
					(patientEntity.getAbhaNo() == null) ? "NA" : patientEntity.getAbhaNo());

			details.put(ConsultationConstants.SYMPTOMS.getValue(), symptomsList);
			details.put(ConsultationConstants.DIAGNOSIS.getValue(), diagnosisList);
			details.put(ConsultationConstants.ADVICE.getValue(), adviceList);
			details.put(ConsultationConstants.MEDICATION.getValue(), medicationList);

			logger.info("Prepared data to generate pdf");

			try {
				pdfFilePath = pdfGenerator.generatePrescriptionPDF(details);

				if (pdfFilePath != null) {
					logger.info("Pdf generated successfully");
					File file = new File(pdfFilePath);
					FileInputStream fis = new FileInputStream(file);
					pdfData = new byte[(int) file.length()];
					fis.read(pdfData);
					logger.info("Converted pdf to bye array");
					logger.info("Return response with pdf path");
					fis.close();
				} else {
					logger.error("error while generation pdf");
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		priscriptionEntity.setPdfPath(pdfFilePath);
		priscriptionRepository.save(priscriptionEntity);
		
		report.setPdfPath(pdfFilePath);
		report.setPdfData(pdfData);
		response.setResponse(report);
		response.setStatus(true);
		return response;
	}

	@Override
	public MainResponseDTO<List<PatientReportDTO>> getPatientReportDetails(String patientName) {

		// TODO Auto-generated method stub
		logger.info("Fetch Patient Report Details");
		String finalResponse = null;
		MainResponseDTO<List<PatientReportDTO>> responseWrapper = new MainResponseDTO<List<PatientReportDTO>>();
		List<PatientReportDtlsEntity> patientReportUploadDtlsEntityList = patientReportRepo.findByptName(patientName);
		if (null != patientReportUploadDtlsEntityList && patientReportUploadDtlsEntityList.size() > 0) {
			List<PatientReportDTO> list = new ArrayList<PatientReportDTO>();
			try {
				for (int i = 0; i < patientReportUploadDtlsEntityList.size(); i++) {
					PatientReportDTO response = new PatientReportDTO();
					try {
						finalResponse = new String(Base64.encodeBase64(
								Files.readAllBytes(Paths.get(patientReportUploadDtlsEntityList.get(i).getReportPath()))));
					} catch (ConsultationServiceException e) {
						throw new ConsultationServiceException(ErrorConstants.NO_FILE_PRESENT.getCode(),
								ErrorConstants.NO_FILE_PRESENT.getMessage());
					}
					response.setPtName(patientReportUploadDtlsEntityList.get(i).getPtName());
					response.setReportpath(patientReportUploadDtlsEntityList.get(i).getReportPath());
					response.setReport(finalResponse);
					response.setReporttype(patientReportUploadDtlsEntityList.get(i).getReportType());
					list.add(response);
				}
				logger.info("Size of Patient Report"+list.size());
				responseWrapper.setResponse(list);
				responseWrapper.setStatus(true);

			} catch (Throwable e) {
				e.printStackTrace();
				throw new ConsultationServiceException(ErrorConstants.SOMETHING_WENT_WRONG.getCode(),
						ErrorConstants.SOMETHING_WENT_WRONG.getMessage());
			}
		} else {
			throw new ConsultationServiceException(ErrorConstants.NO_PATIENT_REPORT_DETAILS_FOUND.getCode(),
					ErrorConstants.NO_PATIENT_REPORT_DETAILS_FOUND.getMessage());
		}
		logger.info("Returning from getPatientReportDetails() of service class");
		return responseWrapper;
	
	}

	@Override
	public MainResponseDTO<List<HistoricalDTO>> fetchHistoricalData() {
		MainResponseDTO<List<HistoricalDTO>> response = new MainResponseDTO<List<HistoricalDTO>>();
		int i,a;
		List<HistoricalDTO> historicalList = new ArrayList<>();

		List<PriscriptionDtlsEntity> entities = priscriptionRepository.findAll();
		i= entities.size();a=0;
		for (PriscriptionDtlsEntity prescriptionEntity : entities) {

			PriscriptionReportResponse reportResponse = getPrescriptionReport(prescriptionEntity);

			if(reportResponse != null) {
				historicalList.add(HistoricalDTO.builder()
						.date(CommonUtils.getCurrentTimePlusDays(a-i))
						.symptoms(prescriptionEntity.getSymptoms())
						.advices(prescriptionEntity.getAdvice())
						.bloodPressureMin(prescriptionEntity.getBloodPressureMin())
						.bloodPressureMax(prescriptionEntity.getBloodPressureMax())
						.daignosis(prescriptionEntity.getDiagnosis())
						.medicines(prescriptionEntity.getMedicines())
						.temperature(prescriptionEntity.getTemperature())
						.respiratoryRate(prescriptionEntity.getRespiratoryRate())
						.heartRate(prescriptionEntity.getHeartRate())
						.pdfPath(reportResponse.getPdfPath())
						.pdfData(reportResponse.getPdfData())
						.jsonPath("")
						.jsonData("")
						.build());
			}
			a++;
		}
		response.setResponse(historicalList);
		response.setStatus(true);
		return response;
	}

	private PriscriptionReportResponse getPrescriptionReport(PriscriptionDtlsEntity priscriptionEntity) {

		PriscriptionReportResponse report = new PriscriptionReportResponse();
		String pdfFilePath = null;
		byte[] pdfData = null;

		PatientDtlsEntity patientEntity = patientDetailsRepo.findByptName(priscriptionEntity.getPtName());

		String medicationList = priscriptionEntity.getMedicines();
		String symptomsList = priscriptionEntity.getSymptoms();
		String diagnosisList = priscriptionEntity.getDiagnosis();
		String adviceList = priscriptionEntity.getAdvice();
		Map<String, String> details = new HashMap<String, String>();

		details.put(ConsultationConstants.APPTID.getValue(), patientEntity.getApptId().toString());

		details.put(ConsultationConstants.DRNAME.getValue(), patientEntity.getDrName());

		details.put(ConsultationConstants.PTNAME.getValue(), patientEntity.getPtName());

		details.put(ConsultationConstants.PTMOBILENO.getValue(), patientEntity.getMobileNo());
		details.put(ConsultationConstants.GENDER.getValue(), patientEntity.getGender());
		details.put(ConsultationConstants.PTEMAILID.getValue(), patientEntity.getEmail());
		details.put(ConsultationConstants.ABHAID.getValue(),
				(patientEntity.getAbhaId() == null) ? "NA" : patientEntity.getAbhaId());
		details.put(ConsultationConstants.ABHANUMBER.getValue(),
				(patientEntity.getAbhaNo() == null) ? "NA" : patientEntity.getAbhaNo());

		details.put(ConsultationConstants.SYMPTOMS.getValue(), symptomsList);
		details.put(ConsultationConstants.DIAGNOSIS.getValue(), diagnosisList);
		details.put(ConsultationConstants.ADVICE.getValue(), adviceList);
		details.put(ConsultationConstants.MEDICATION.getValue(), medicationList);

		logger.info("Prepared data to generate pdf");

		try {
			pdfFilePath = pdfGenerator.generatePrescriptionPDF(details);

			if (pdfFilePath != null) {
				logger.info("Pdf generated successfully");
				File file = new File(pdfFilePath);
				FileInputStream fis = new FileInputStream(file);
				pdfData = new byte[(int) file.length()];
				fis.read(pdfData);
				logger.info("Converted pdf to byte array");
				logger.info("Return response with pdf path");
				fis.close();
			} else {
				logger.error("error while generation pdf");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		report.setPdfPath(pdfFilePath);
		report.setPdfData(pdfData);
		return report;
	}

}
