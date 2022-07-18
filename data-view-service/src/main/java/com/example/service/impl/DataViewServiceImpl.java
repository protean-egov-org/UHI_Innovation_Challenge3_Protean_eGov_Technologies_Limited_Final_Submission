package com.example.service.impl;

import com.example.dto.*;
import com.example.entity.DataRequestEntity;
import com.example.entity.DataTransferEntity;
import com.example.repository.DataRequestRepository;
import com.example.repository.DataTransferRepository;
import com.example.service.DataViewService;
import com.example.utility.CommonUtils;
import com.example.utility.decrypt.Decryption;
import com.example.utility.decrypt.DecryptionRequest;
import com.example.utility.keys.KeyMaterial;
import com.example.utility.keys.KeysGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class DataViewServiceImpl implements DataViewService {

    private static final Logger logger = LoggerFactory.getLogger(DataViewServiceImpl.class);

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    public ObjectMapper mapper;

    @Autowired
    KeysGenerator keysGenerator;

    @Autowired
    Decryption decryption;

    @Autowired
    DataRequestRepository dataRequestRepository;

    @Autowired
    DataTransferRepository dataTransferRepository;

    @Value("${data.info.request}")
    String dataInfoRequest;

    @Value("${data.fetch.request}")
    String fetchRequest;

    @Value("${setdatapushurl}")
    String setHiuDataPushUrl;


    @Override
    public TransactionIdRespDTO dataRequest(Map<String, String> headers, DataRequestDTO dataRequestDTO) {
        logger.info("Request Receives for Data Request Starts");
        String url = dataInfoRequest;
        URI uri;
        ResponseEntity<String> result = null;

        dataRequestDTO.setTransactionId(UUID.randomUUID().toString());
        dataRequestDTO.setTimestamp(CommonUtils.getTime());
        dataRequestDTO.setAppointmentId("");
        KeygenMaterialDTO keygenMaterialDTO = createKeyMaterialDTO();
        dataRequestDTO.setKeyMaterial(keygenMaterialDTO.getKeyMaterialDTO());
        dataRequestDTO.setDataPushUrl(setHiuDataPushUrl);
        dataRequestDTO.setDateRange(DataRangeDTO.builder().from(CommonUtils.getTime())
                .to(CommonUtils.getCurrentTimePlusDays(15)).build());

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set("Content-Type", "application/json");

        try {
            uri = new URI(url);
            String encryptedString = new Gson().toJson(dataRequestDTO);
            HttpEntity<String> requestEntity = new HttpEntity<>(encryptedString, httpHeaders);
            logger.info("{}", requestEntity);
            result = restTemplate.exchange(uri, HttpMethod.POST, requestEntity, String.class);

            logger.info("{}", result.getStatusCode());
            if (result.getStatusCode().is2xxSuccessful()) {
                KeyMaterialDTO keyMaterialDTO = dataRequestDTO.getKeyMaterial();
                DhPublicKeyDTO dhPublicKeyDTO = keyMaterialDTO.getDhPublicKey();

                DataRequestEntity dataRequestEntity = DataRequestEntity.builder()
                        .transactionId(dataRequestDTO.getTransactionId()).timestamp(dataRequestDTO.getTimestamp())
                        .appointmentId(dataRequestDTO.getAppointmentId())
                        .dateRangeFrom(dataRequestDTO.getDateRange().getFrom())
                        .dateRangeTo(dataRequestDTO.getDateRange().getTo()).dataPushUrl(dataRequestDTO.getDataPushUrl())
                        .keyCryptoAlg(keyMaterialDTO.getCryptoAlg())
                        .keyCurve(keyMaterialDTO.getCurve()).keyExpiry(dhPublicKeyDTO.getExpiry())
                        .keyParameters(dhPublicKeyDTO.getParameters()).receiverPublicKey(dhPublicKeyDTO.getKeyValue())
                        .receiverPrivateKey(keygenMaterialDTO.getKeygen().getPrivateKey())
                        .receiverNonce(keyMaterialDTO.getNonce()).status(true).build();

                dataRequestRepository.save(dataRequestEntity);

                logger.info("Request Receives for Data Request SUCCESS Ends");
                return TransactionIdRespDTO.builder().transactionId(dataRequestDTO.getTransactionId()).build();

            } else {
                return TransactionIdRespDTO.builder().transactionId("").build();
            }
        } catch (HttpClientErrorException | HttpServerErrorException e) {

            if (e.getStatusCode() == HttpStatus.UNPROCESSABLE_ENTITY) {
                logger.error("{}", HttpStatus.UNPROCESSABLE_ENTITY);
            }
        } catch (Exception ed) {
            logger.error("Exception occurs {}",ed);
        }

        logger.info("Request Receives for Data Request Ends {}");
        return TransactionIdRespDTO.builder().transactionId(dataRequestDTO.getTransactionId()).build();
    }


    @Override
    public boolean hiInfoTransfer(DataTransferDTO dataTransferDTO) {
        if(dataTransferDTO != null) {
            if(dataTransferDTO.getTransactionId() != null && dataTransferDTO.getEntries() != null
                    && !dataTransferDTO.getEntries().isEmpty()) {

                DataRequestEntity dataRequestEntity = dataRequestRepository
                        .findByTransactionId(dataTransferDTO.getTransactionId());

                if(dataRequestEntity != null) {

                    List<FhirStringDTO> fhirString = decryptionFhir(dataTransferDTO.getEntries(),
                            new DecryptionRequest(dataRequestEntity.getReceiverPrivateKey(),
                                    dataRequestEntity.getReceiverNonce(),
                                    dataTransferDTO.getKeyMaterial().getDhPublicKey().getKeyValue(),
                                    dataTransferDTO.getKeyMaterial().getNonce(), ""));

                    if(fhirString != null && !fhirString.isEmpty()) {
                        List<DataTransferEntity> dataTransferEntityList = fhirString.stream()
                                .map(data -> DataTransferEntity.builder()
                                        .labName(dataTransferDTO.getLabName())
                                        .transactionId(dataTransferDTO.getTransactionId())
                                        .appointmentId(data.getAppointmentId()).timestamp(data.getTimestamp())
                                        .fhirString(data.getFhirString()).status(true).build())
                                .collect(Collectors.toList());

                        try {
                            dataTransferRepository.saveAll(dataTransferEntityList);
                        } catch (Exception e) {
                            logger.error("Error in saving FHIR String data: {}",e);
                        }
                        return true;

                    } else {
                        logger.error("FHIR string null or empty, error in hiInfoTransfer");
                    }
                } else {
                    logger.error("No TransactionId found for data, error in hiInfoTransfer");
                }
            } else {
                logger.error("TransactionId is null data, error in hiInfoTransfer");
            }
        } else {
            logger.error("DataTransferDTO is null, error in hiInfoTransfer");
        }
        return false;
    }

    @Override
    public void fetchRequest(LabNameDTO labNameDTO) {

        logger.info("Request Receives for fetch Request Starts");
        String url = fetchRequest;
        URI uri;
        ResponseEntity<String> result = null;
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set("Content-Type", "application/json");

        try {
            uri = new URI(url);
            String encryptedString = new Gson().toJson(labNameDTO);
            HttpEntity<String> requestEntity = new HttpEntity<>(encryptedString, httpHeaders);
            logger.info("fetch Request Status {}",requestEntity);
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

    @Override
    public List<String> findReportByLabName(String labName) {

        if (labName.equals(null) || labName.equals("")) {
            return new ArrayList<>();
        }

        List<DataTransferEntity> dataEntityList = null;
        try {
            dataEntityList = dataTransferRepository.findAllByLabName(labName);
        } catch (Exception e) {
            logger.error("Error In get all ConsentInitReqByAbhaId {}", e);
        }

        List<String> fhirStringList = dataEntityList.stream().map(data -> data.getFhirString())
                .collect(Collectors.toList());

        if (fhirStringList != null) {
            return fhirStringList;
        }
        return new ArrayList<>();
    }

    private KeygenMaterialDTO createKeyMaterialDTO() {
        try {

            KeyMaterial receiverKeyMaterial = keysGenerator.generate();
            return KeygenMaterialDTO.builder()
                    .keyMaterialDTO(KeyMaterialDTO.builder().cryptoAlg("ECDH").curve("curve25519")
                            .dhPublicKey(DhPublicKeyDTO.builder().expiry(CommonUtils.getCurrentTimePlusDays(30))
                                    .parameters("Curve25519/32byte random key")
                                    .keyValue(receiverKeyMaterial.getPublicKey()).build())
                            .nonce(receiverKeyMaterial.getNonce()).build())
                    .keygen(receiverKeyMaterial).build();

        } catch (Exception e) {
            logger.error("Error in Create Receiver Key Material", e);
        }
        return KeygenMaterialDTO.builder().build();
    }

    private List<FhirStringDTO> decryptionFhir(List<EntryDTO> entryDTOS, DecryptionRequest decryptionRequest) {
        List<FhirStringDTO> fhirString = new ArrayList<>();
        try{
            for (EntryDTO entryDTO : entryDTOS) {

                if(entryDTO != null) {
                    if(entryDTO.getTimestamp() != null && entryDTO.getAppointmentId() != null
                            && entryDTO.getContent() != null && entryDTO.getMedia() != null) {
                        decryptionRequest.setEncryptedData(entryDTO.getContent());
                        fhirString.add(FhirStringDTO.builder()
                                .timestamp(entryDTO.getTimestamp())
                                .appointmentId(entryDTO.getAppointmentId())
                                .fhirString(decryption.decrypt(decryptionRequest).getDecryptedData()).build());
                    }
                }
            }
            return fhirString;
        } catch (Exception e) {
            logger.error("Error in decryptionFhir: {}",e);
        }
        return fhirString;
    }
}
