package com.protean.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.protean.dto.*;
import com.protean.entity.*;
import com.protean.repository.*;
import com.protean.service.DataCommService;
import com.protean.utility.CommonUtils;
import com.protean.utility.encrypt.Encryption;
import com.protean.utility.encrypt.EncryptionRequest;
import com.protean.utility.encrypt.EncryptionResponse;
import com.protean.utility.fhir.OPConsultNote;
import com.protean.utility.keys.KeyMaterial;
import com.protean.utility.keys.KeysGenerator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DataCommServiceImpl implements DataCommService {
    private static final Logger logger = LoggerFactory.getLogger(DataCommServiceImpl.class);

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    public ObjectMapper mapper;

    @Autowired
    PatientDetailsRepo patientDetailsRepo;

    @Autowired
    HipRequestRepository hipRequestRepository;

    @Autowired
    ReportRepository reportRepository;

    @Autowired
    HipDataRepository hipDataRepository;

    @Autowired
    PriscriptionRepository priscriptionRepository;

    @Autowired
    OPConsultNote opConsultNote;

    @Autowired
    Encryption encryption;

    @Autowired
    KeysGenerator keysGenerator;

    @Value("${hip.data.transfer}")
    String hipDataTransfer;

    @Override
    public List<String> docNameList() {
        return reportRepository.findAll().stream().map(ReportEntity::getLabName).collect(Collectors.toList());
    }

    @Override
    public void requestData(DataRequestDTO dataRequestDTO) {

        if(dataRequestDTO != null) {

            if(!dataRequestDTO.getLabName().equals(null)) {
                KeyMaterialDTO keyMaterialDTO = dataRequestDTO.getKeyMaterial();
                DhPublicKeyDTO dhPublicKeyDTO = keyMaterialDTO.getDhPublicKey();

                HipRequestEntity hipRequestEntity =
                        HipRequestEntity.builder().transactionId(dataRequestDTO.getTransactionId())
                                .labName(dataRequestDTO.getLabName()).timestamp(dataRequestDTO.getTimestamp())
                                .appointmentId(dataRequestDTO.getAppointmentId())
                                .dateRangeFrom(dataRequestDTO.getDateRange().getFrom())
                                .dateRangeTo(dataRequestDTO.getDateRange().getTo()).dataPushUrl(dataRequestDTO.getDataPushUrl())
                                .keyCryptoAlg(keyMaterialDTO.getCryptoAlg()).keyCurve(keyMaterialDTO.getCurve())
                                .keyExpiry(dhPublicKeyDTO.getExpiry()).keyParameters(dhPublicKeyDTO.getParameters())
                                .receiverPublicKey(dhPublicKeyDTO.getKeyValue()).receiverNonce(keyMaterialDTO.getNonce()).build();

                try {
                    hipRequestRepository.save(hipRequestEntity);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }

        ReportEntity reportEntity = reportRepository.findByLabName(dataRequestDTO.getLabName());

        if(reportEntity != null) {
            ReportDTO reportDTO = ReportDTO.builder().build();
            BeanUtils.copyProperties(reportEntity, reportDTO);
            logger.info("reportDTO: {}",reportDTO);

            String fhirString = fhirString(reportDTO);

            DataTransferDTO dataTransferDTO = null;
            try {
                dataTransferDTO = prepareDataNewDTO(dataRequestDTO, fhirString,reportEntity.getAppointmentId(),
                        reportEntity.getLabName());
            } catch (Exception e) {
                e.printStackTrace();
            }

            String json = "";
            try {
                json = mapper.writeValueAsString(dataTransferDTO);
            } catch (JsonProcessingException e) {
                logger.error("Error in conversion hiInfo OnRequest {}", e);
            }

            HipDataEntity hiuDataRequestEntity = hipDataRepository.findByLabname(reportEntity.getLabName());

            if(hiuDataRequestEntity == null ) {
                hiuDataRequestEntity = HipDataEntity.builder()
                        .labname(reportEntity.getLabName())
                        .fhirString(json)
                        .build();
            }

            try {
                hipDataRepository.save(hiuDataRequestEntity);
            } catch (Exception e) {
                logger.error("Error in update HIU hiInfo OnRequest {}", e);
                hiuDataRequestEntity = null;
            }
        }

    }

    @Override
    public void getByLabName(LabNameDTO labNameDTO) {
        HipDataEntity hipDataEntity = hipDataRepository.findByLabname(labNameDTO.getLabName());

        if(hipDataEntity != null) {

            DataTransferDTO dataTransferDTO = new Gson().fromJson(hipDataEntity.getFhirString(), DataTransferDTO.class);
            logger.info("Request Receives for fetch getByLabName Starts");
            String url = hipDataTransfer;
            URI uri;
            ResponseEntity<String> result = null;
            HttpHeaders httpHeaders = new HttpHeaders();
            httpHeaders.set("Content-Type", "application/json");

            try {
                uri = new URI(url);
                String dataString = new Gson().toJson(dataTransferDTO);
                HttpEntity<String> requestEntity = new HttpEntity<>(dataString, httpHeaders);
                result = restTemplate.exchange(uri, HttpMethod.POST, requestEntity, String.class);

                logger.info("fetch Request Status {}",result.getStatusCode());
            } catch (HttpClientErrorException | HttpServerErrorException e) {

                if (e.getStatusCode() == HttpStatus.UNPROCESSABLE_ENTITY) {
                    logger.error("{}", HttpStatus.UNPROCESSABLE_ENTITY);
                }
            } catch (Exception ed) {
                logger.error("Exception occurs");
            }
        }
    }

    private String fhirString(ReportDTO reportDTO) {

        String appointmentId = reportDTO.getAppointmentId();
        String localDateTimeString = CommonUtils.getTime();
        PatientRegDetailsDTO patientRegDetailsDTO = PatientRegDetailsDTO.builder()
                .id(reportDTO.getAbhaNo())
                .name(reportDTO.getPatientName())
                .abhaId(reportDTO.getAbhaId())
                .abhaNo(reportDTO.getAbhaNo())
                .gender(reportDTO.getPatientGender())
                .dob(reportDTO.getPatientDob())
                .mob(reportDTO.getPatientMob())
                .build();

        DoctorDetailsDTO doctorDetailsDTO = DoctorDetailsDTO.builder()
                .drId(reportDTO.getDrMciNo())
                .drName(reportDTO.getDrName())
                .email(reportDTO.getDrEmail())
                .mob(reportDTO.getPatientMob())
                .mciNo(reportDTO.getDrMciNo())
                .smcNo(reportDTO.getDrSmcNo())
                .speciality(reportDTO.getDrspeciality())
                .build();

        ReportResponseDtls reportResponseDtls = ReportResponseDtls.builder()
                .docCreationTimestamp(CommonUtils.getTime())
                .reportDoc(CommonUtils.getReportData())
                .build();

        String fhirString = "";
        try {
            fhirString = opConsultNote.getFhirString(appointmentId, localDateTimeString, patientRegDetailsDTO,
                    doctorDetailsDTO, reportResponseDtls);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fhirString;
    }

    private DataTransferDTO prepareDataNewDTO(DataRequestDTO dataRequestDTO, String fhirString, String appointmentId,
                                              String labName) throws Exception {
        logger.info("prepareDataNewDTO starts");
        String expiryDate = CommonUtils.getCurrentTimePlusDays(30);

        KeyMaterialDTO receiverKeyMaterial = dataRequestDTO.getKeyMaterial();
        KeyMaterial senderKeyMaterial = keysGenerator.generate();

        List<EntryDTO> entryDTOS = new ArrayList<>();
        EncryptionResponse encryptionResponse = null;

        EncryptionRequest encryptionRequest = new EncryptionRequest(
                receiverKeyMaterial.getDhPublicKey().getKeyValue(), receiverKeyMaterial.getNonce(),
                senderKeyMaterial.getPrivateKey(), senderKeyMaterial.getPublicKey(),
                senderKeyMaterial.getNonce(), fhirString);

        encryptionResponse = encryption.encrypt(encryptionRequest);
        entryDTOS.add(EntryDTO.builder().content(encryptionResponse.getEncryptedData())
                .media("application/fhir+json").build());

        KeyMaterialDTO keyMaterialDTO = KeyMaterialDTO.builder().cryptoAlg(receiverKeyMaterial.getCryptoAlg())
                .curve(receiverKeyMaterial.getCurve())
                .dhPublicKey(DhPublicKeyDTO.builder().expiry(expiryDate)
                        .parameters(receiverKeyMaterial.getDhPublicKey().getParameters())
                        .keyValue(encryptionResponse.getKeyToShare()).build())
                .nonce(senderKeyMaterial.getNonce()).build();

        logger.info("prepareDataNewDTO ends");

        return DataTransferDTO.builder().labName(labName).transactionId(dataRequestDTO.getTransactionId())
                .entries(entryDTOS).keyMaterial(keyMaterialDTO).build();
    }

    @Override
    public void saveJson(DocPatientDTO docPatientDTO) {
        PriscriptionDtlsEntity priscriptionEntity = priscriptionRepository.findByuniqueId(docPatientDTO.getUniqueId());
        if (priscriptionEntity != null) {
            PatientDtlsEntity patientEntity = patientDetailsRepo.findByptName(priscriptionEntity.getPtName());

            ReportDTO reportDTO = ReportDTO.builder()
                    .labName("DR LAL PATH LABS").appointmentId(patientEntity.getApptId().toString())
                    .patientId(patientEntity.getId().toString()).patientName(patientEntity.getPtName())
                    .abhaId(patientEntity.getAbhaId()).abhaNo(patientEntity.getAbhaNo())
                    .patientGender(patientEntity.getGender()).patientDob(patientEntity.getDob())
                    .patientMob(patientEntity.getMobileNo()).drId("DOC1").drName(patientEntity.getDrName())
                    .drEmail("dr1@gmail.com")
                    .drMob("9876567890")
                    .drMciNo("MCI1").drSmcNo("SMC1").drspeciality("Specialist").build();

            String fhirString = fhirString(reportDTO);
            String filePath = "/var/telemedicine/documents/prescription/OPConsultNote_"+CommonUtils.randomNumber()+".json";
            try {
                // Write serialized bundle in json file
                File file = new File(filePath);
                file.createNewFile();
                FileWriter writer = new FileWriter(file);
                writer.write(fhirString);
                writer.flush();
                writer.close();

                priscriptionEntity.setJsonPath(filePath);
                priscriptionRepository.save(priscriptionEntity);

            } catch (IOException e) {
                logger.error("Error in file save {}",e);
            }
        }
    }

}
