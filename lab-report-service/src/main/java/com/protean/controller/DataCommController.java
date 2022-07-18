package com.protean.controller;

import com.protean.dto.DataRequestDTO;
import com.protean.dto.DocPatientDTO;
import com.protean.dto.LabNameDTO;
import com.protean.dto.MainRequestDTO;
import com.protean.service.DataCommService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(value="/transfer")
public class DataCommController {
    private static final Logger logger = LoggerFactory.getLogger(DataCommController.class);

    @Autowired
    DataCommService dataCommService;


    @GetMapping("/labnames")
    public ResponseEntity<List<String>> getDocName() {
        List<String> mainResponse = null;
        try {
            mainResponse = dataCommService.docNameList();
        } catch (Exception e) {
            mainResponse = null;
            logger.error("Error in getAllDocName {}", e);
        }
        return ResponseEntity.status(HttpStatus.OK).body(mainResponse);
    }


    @PostMapping(value = "/request", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<String> callbackRequest(@RequestHeader Map<String, String> headers,
                                                  @RequestBody DataRequestDTO dataRequestDTO) {
        logger.info("Request Received For request Starts");
        dataCommService.requestData(dataRequestDTO);
        logger.info("Request Received For request ends");

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping(value = "/bylabname", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<String> findByLabname(@RequestHeader Map<String, String> headers,
                                                @RequestBody LabNameDTO labNameDTO) {
        logger.info("Request Received For request Starts");
        dataCommService.getByLabName(labNameDTO);
        logger.info("Request Received For request ends");

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping( "/savejson")
    public ResponseEntity<String> saveUserJson(@RequestHeader Map<String, String> headers,
                                               @RequestBody MainRequestDTO<DocPatientDTO> docPatientDTO) {

        logger.info("Request Received for SaveUserJson Starts");
        dataCommService.saveJson(docPatientDTO.getRequest());
        logger.info("Request Received For SaveUserJson Ends");

        return new ResponseEntity<>(HttpStatus.OK);
    }

}
