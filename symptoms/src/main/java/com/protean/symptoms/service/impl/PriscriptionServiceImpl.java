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
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

@Service
public class PriscriptionServiceImpl implements PriscriptionService {
	
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
		
		response.setResponse("Prescription Saved Successfully");
		response.setStatus(true);
		return response;
	}

	@Override
	public MainResponseDTO<PriscriptionReportResponse> fetchPriscriptionReport(BigInteger uniqueId) {

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
			String jsonPath = (prescriptionEntity.getJsonPath() != null) ? prescriptionEntity.getJsonPath()
					: "/var/telemedicine/documents/prescription/OPConsultNoteSample.json";

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
						.jsonPath(jsonPath)
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


	@Override
	public MainResponseDTO<List<ExternalDTO>> fetchExternalData() {
		MainResponseDTO<List<ExternalDTO>> response = new MainResponseDTO<List<ExternalDTO>>();
		List<ExternalDTO> list = new ArrayList<>();
		String data1 = "JVBERi0xLjcKJeLjz9MKNSAwIG9iago8PC9GaWx0ZXIvRmxhdGVEZWNvZGUvTGVuZ3RoIDYwMT4+c3RyZWFtCnicpZTBc6IwGMXv/BXfkc5oJCEJ0NOyaq0ddbuF6czOeKGattlBYgPa+t9vAnZlqe1l4QST33uPl3y8ON9TZ3CFgXiQPjqEYMQjCEKMQh/SteOONILbeDaL76dwE4+u4/uL9LczTp2fzkvDEghrlIWIGpSHKAhq9Ig1FCbfJvN4OkPDH/Ougn9UoARFFALGEMa1wnw4hYWCS4hnA+LhMBlmAMl8+M/LwU2fBC1JD+x9N3EIvDo+h4BGiGHYOIxF7w+5k5zsKeD64yk1i/0A+Y35KKuEcfGivuf3iUdINzYDzC1nPbCHOLUYgVQ7HmK+uYy/e5tVUhQVLLKNVVuMruemz3Q6XqRdPX7S42F0jNHVi5+sDPHhVxcPANN3nIUtlnLOA8smh822UpsSLrtsCJi8s9QcgaaBK7EXugdJLsQWtlo95GJTdtGoZYsJ8qJzzrda7WUpVZHlMJLZU6FKeSaG2Ye/OVjEUHOORqJ42oke3Ett8AetitWzrGTZg0lWVlqZeoW2Lz7I4VM2xinCZ7PNxVquzC6p4kwg0gpEAxTUCm5cZTp7g+Zaul6/vpcX8GaeYJ0dBuXywmq58KWi76Fmyr5eZmoNG9+yes5yWcCdKLe7XPx3AmpK/iyBfyqPcnL89G558XovV+JMcbRlQjmqZ8OdyL2AbW427ADqEZTdz8d8J9cl6kEqNluhs2qnBWixUnoN9vwdoJRv8Kx2ukQfXNjRxY4u9UIUtX88n/yvzJA1885oaIfsxH3sgLd+DX7kI0rqhUs3XoyT9HqcTOOm5pr6Ayb0REEKZW5kc3RyZWFtCmVuZG9iago0IDAgb2JqCjw8L0NvbnRlbnRzIDUgMCBSL01lZGlhQm94WzAgMCA1OTUgODQyXS9QYXJlbnQgMiAwIFIvUmVzb3VyY2VzPDwvRm9udDw8L0YxIDYgMCBSL0YxMCAxNSAwIFIvRjExIDE2IDAgUi9GMTIgMTcgMCBSL0YxMyAxOCAwIFIvRjE0IDE5IDAgUi9GMTUgMjAgMCBSL0YxNiAyMSAwIFIvRjIgNyAwIFIvRjMgOCAwIFIvRjQgOSAwIFIvRjUgMTAgMCBSL0Y2IDExIDAgUi9GNyAxMiAwIFIvRjggMTMgMCBSL0Y5IDE0IDAgUj4+Pj4vVHJpbUJveFswIDAgNTk1IDg0Ml0vVHlwZS9QYWdlPj4KZW5kb2JqCjEgMCBvYmoKPDwvUGFnZXMgMiAwIFIvVHlwZS9DYXRhbG9nPj4KZW5kb2JqCjMgMCBvYmoKPDwvQ3JlYXRpb25EYXRlKEQ6MjAyMjAzMDkxNTI4NTArMDUnMzAnKS9Nb2REYXRlKEQ6MjAyMjAzMDkxNTI4NTArMDUnMzAnKS9Qcm9kdWNlcihpVGV4dK4gNy4wLjQgqTIwMDAtMjAxNyBpVGV4dCBHcm91cCBOViBcKEFHUEwtdmVyc2lvblwpKT4+CmVuZG9iagoyMSAwIG9iago8PC9CYXNlRm9udC9UaW1lcy1Sb21hbi9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvU3VidHlwZS9UeXBlMS9UeXBlL0ZvbnQ+PgplbmRvYmoKMjAgMCBvYmoKPDwvQmFzZUZvbnQvVGltZXMtUm9tYW4vRW5jb2RpbmcvV2luQW5zaUVuY29kaW5nL1N1YnR5cGUvVHlwZTEvVHlwZS9Gb250Pj4KZW5kb2JqCjE5IDAgb2JqCjw8L0Jhc2VGb250L1RpbWVzLVJvbWFuL0VuY29kaW5nL1dpbkFuc2lFbmNvZGluZy9TdWJ0eXBlL1R5cGUxL1R5cGUvRm9udD4+CmVuZG9iagoxOCAwIG9iago8PC9CYXNlRm9udC9UaW1lcy1Sb21hbi9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvU3VidHlwZS9UeXBlMS9UeXBlL0ZvbnQ+PgplbmRvYmoKMTcgMCBvYmoKPDwvQmFzZUZvbnQvVGltZXMtUm9tYW4vRW5jb2RpbmcvV2luQW5zaUVuY29kaW5nL1N1YnR5cGUvVHlwZTEvVHlwZS9Gb250Pj4KZW5kb2JqCjE2IDAgb2JqCjw8L0Jhc2VGb250L1RpbWVzLVJvbWFuL0VuY29kaW5nL1dpbkFuc2lFbmNvZGluZy9TdWJ0eXBlL1R5cGUxL1R5cGUvRm9udD4+CmVuZG9iagoxNSAwIG9iago8PC9CYXNlRm9udC9UaW1lcy1Sb21hbi9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvU3VidHlwZS9UeXBlMS9UeXBlL0ZvbnQ+PgplbmRvYmoKMTQgMCBvYmoKPDwvQmFzZUZvbnQvVGltZXMtUm9tYW4vRW5jb2RpbmcvV2luQW5zaUVuY29kaW5nL1N1YnR5cGUvVHlwZTEvVHlwZS9Gb250Pj4KZW5kb2JqCjEzIDAgb2JqCjw8L0Jhc2VGb250L1RpbWVzLVJvbWFuL0VuY29kaW5nL1dpbkFuc2lFbmNvZGluZy9TdWJ0eXBlL1R5cGUxL1R5cGUvRm9udD4+CmVuZG9iagoxMiAwIG9iago8PC9CYXNlRm9udC9UaW1lcy1Sb21hbi9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvU3VidHlwZS9UeXBlMS9UeXBlL0ZvbnQ+PgplbmRvYmoKMTEgMCBvYmoKPDwvQmFzZUZvbnQvVGltZXMtUm9tYW4vRW5jb2RpbmcvV2luQW5zaUVuY29kaW5nL1N1YnR5cGUvVHlwZTEvVHlwZS9Gb250Pj4KZW5kb2JqCjEwIDAgb2JqCjw8L0Jhc2VGb250L1RpbWVzLVJvbWFuL0VuY29kaW5nL1dpbkFuc2lFbmNvZGluZy9TdWJ0eXBlL1R5cGUxL1R5cGUvRm9udD4+CmVuZG9iago5IDAgb2JqCjw8L0Jhc2VGb250L0NvdXJpZXItQm9sZC9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvU3VidHlwZS9UeXBlMS9UeXBlL0ZvbnQ+PgplbmRvYmoKOCAwIG9iago8PC9CYXNlRm9udC9UaW1lcy1Sb21hbi9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvU3VidHlwZS9UeXBlMS9UeXBlL0ZvbnQ+PgplbmRvYmoKNyAwIG9iago8PC9CYXNlRm9udC9UaW1lcy1Sb21hbi9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvU3VidHlwZS9UeXBlMS9UeXBlL0ZvbnQ+PgplbmRvYmoKNiAwIG9iago8PC9CYXNlRm9udC9UaW1lcy1Sb21hbi9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvU3VidHlwZS9UeXBlMS9UeXBlL0ZvbnQ+PgplbmRvYmoKMiAwIG9iago8PC9Db3VudCAxL0tpZHNbNCAwIFJdL1R5cGUvUGFnZXM+PgplbmRvYmoKeHJlZgowIDIyCjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDk3MCAwMDAwMCBuIAowMDAwMDAyNjI1IDAwMDAwIG4gCjAwMDAwMDEwMTUgMDAwMDAgbiAKMDAwMDAwMDY4MyAwMDAwMCBuIAowMDAwMDAwMDE1IDAwMDAwIG4gCjAwMDAwMDI1MzUgMDAwMDAgbiAKMDAwMDAwMjQ0NSAwMDAwMCBuIAowMDAwMDAyMzU1IDAwMDAwIG4gCjAwMDAwMDIyNjQgMDAwMDAgbiAKMDAwMDAwMjE3MyAwMDAwMCBuIAowMDAwMDAyMDgyIDAwMDAwIG4gCjAwMDAwMDE5OTEgMDAwMDAgbiAKMDAwMDAwMTkwMCAwMDAwMCBuIAowMDAwMDAxODA5IDAwMDAwIG4gCjAwMDAwMDE3MTggMDAwMDAgbiAKMDAwMDAwMTYyNyAwMDAwMCBuIAowMDAwMDAxNTM2IDAwMDAwIG4gCjAwMDAwMDE0NDUgMDAwMDAgbiAKMDAwMDAwMTM1NCAwMDAwMCBuIAowMDAwMDAxMjYzIDAwMDAwIG4gCjAwMDAwMDExNzIgMDAwMDAgbiAKdHJhaWxlcgo8PC9JRCBbPDFlMTYyMDM2MGZiZTVhZTZkNmY0MjkwNmIxYTQyOTAwPjwxZTE2MjAzNjBmYmU1YWU2ZDZmNDI5MDZiMWE0MjkwMD5dL0luZm8gMyAwIFIvUm9vdCAxIDAgUi9TaXplIDIyPj4KJWlUZXh0LTcuMC40CnN0YXJ0eHJlZgoyNjc2CiUlRU9GCg==";

		ExternalDTO externalDTO1 = ExternalDTO.builder().labName("DR LAL PATH LABS").pdfData(data1).build();
		ExternalDTO externalDTO2 = ExternalDTO.builder().labName("SRL DIAGNOSTICS").pdfData(data1).build();
		ExternalDTO externalDTO3 = ExternalDTO.builder().labName("METROPOLIS").pdfData(data1).build();

		list.add(externalDTO1);
		list.add(externalDTO2);
		list.add(externalDTO3);

		response.setResponse(list);
		return response;
	}

	@Override
	public MainResponseDTO<List<ReportRespDTO>> getFetch() {
		MainResponseDTO<List<ReportRespDTO>> response = new MainResponseDTO<List<ReportRespDTO>>();
		List<ReportRespDTO> list = new ArrayList<>();

		List<String> recordpath1 = Arrays.asList("/var/telemedicine/documents/prescription/Blood_Report.png");
		List<String> recordpath2 = Arrays.asList("/var/telemedicine/documents/prescription/Diagnostic_Report.pdf");
		List<String> recordpath3 = Arrays.asList("/var/telemedicine/documents/prescription/ECG_Report.pdf");

		ReportRespDTO report1 = ReportRespDTO.builder().name("DR LAL PATH LABS").recordsPath(recordpath1).build();
		ReportRespDTO report2 = ReportRespDTO.builder().name("SRL DIAGNOSTICS").recordsPath(recordpath2).build();
		ReportRespDTO report3 = ReportRespDTO.builder().name("METROPOLIS").recordsPath(recordpath3).build();

		list.add(report1);
		list.add(report2);
		list.add(report3);

		response.setResponse(list);
		return response;
	}

}
