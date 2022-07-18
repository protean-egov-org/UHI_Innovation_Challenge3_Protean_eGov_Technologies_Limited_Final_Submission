package com.example.controller;

import com.example.dto.DataRequestDTO;
import com.example.dto.DataTransferDTO;
import com.example.dto.LabNameDTO;
import com.example.dto.TransactionIdRespDTO;
import com.example.service.DataViewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin
@RequestMapping("/hiu")
public class DataViewController {
    private static final Logger logger = LoggerFactory.getLogger(DataViewController.class);

    @Autowired
    DataViewService dataViewService;

    @PostMapping("/request")
    public ResponseEntity<TransactionIdRespDTO> dataInfoRequest(@RequestHeader Map<String, String> headers,
                                                                @RequestBody DataRequestDTO dataRequestDTO) {

        logger.info("Request Received For DataInfo Request Starts");
        TransactionIdRespDTO requestIdRespDTO = dataViewService.dataRequest(headers, dataRequestDTO);
        logger.info("Request Received For DataInfo Request Ends");

        return ResponseEntity.status(HttpStatus.OK).body(requestIdRespDTO);
    }

    @PostMapping("/fetch-data")
    public ResponseEntity<String> callRequest(@RequestBody LabNameDTO labNameDTO) {

        logger.info("Request Received For callRequest Request Starts");
        dataViewService.fetchRequest(labNameDTO);
        logger.info("Request Received For callRequest Request Ends");

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping( "/health-information/transfer")
    public ResponseEntity<Boolean> healthInfoTransfer(@RequestHeader Map<String, String> headers,
                                                      @RequestBody DataTransferDTO dataTransferDTO) {

        logger.info("Request Received For Health Info Transfer Starts");
        boolean status = dataViewService.hiInfoTransfer(dataTransferDTO);
        logger.info("Request Received For Health Info Transfer Ends");

        return (status) ?  ResponseEntity.status(HttpStatus.OK).body(status) :
                ResponseEntity.status(HttpStatus.BAD_REQUEST).body(status);
    }

    @PostMapping( "/get-recordby-labname")
    public ResponseEntity<List<String>> getRecordByLabName(@RequestHeader Map<String, String> headers,
                                                               @RequestBody LabNameDTO labNameDTO) {

        logger.info("Request Received for getRecordByPatientName Starts");
        List<String> stringList = dataViewService.findReportByLabName(labNameDTO.getLabName());
        logger.info("Request Received For getRecordByPatientName Ends");

        return ResponseEntity.status(HttpStatus.OK).body(stringList);
    }

}
