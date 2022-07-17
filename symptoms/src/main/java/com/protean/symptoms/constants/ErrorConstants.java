package com.protean.symptoms.constants;

public enum ErrorConstants {

	ERROR_FETCHING_PATIENT_DATA("ERR-CON-001", "Error Fetching Patient Data"),
	NO_APPOINTMENT_DATA_FOUND("ERR-CON-002", "No Appointment Data Found"),
	PATIENT_DATA_NOT_FOUND("ERR-CON-003", "Patient Data Not Found"),
	DOCTOR_DATA_NOT_FOUND("ERR-CON-004", "No Data Found For Provided Doctor User-Id"),
	NO_DOCTOR_DATA_FOUND_FOR_CURRENT_APPOINTMENT_ID("ERR-CON-005", "No Doctor Data Found For Current Appointment Id"),
	APPOINTMENT_ID_NOT_FOUND("ERR-CON-006", "Appointment Id Cannot Be Null Or Empty"),
	NO_PATIENT_DATA_FOUND_FOR_CURRENT_APPOINTMENT_ID("ERR-CON-007", "No Patient Data Found For Current Appointment Id"),
	NO_DIAGNOSIS_DATA_FOUND_FOR_CURRENT_APPOINTMENT_ID("ERR-CON-008", "No Diagnosis Data Found For Current Appointment Id"),
	INVALID_INPUT_DATA("ERR-CON-009", "Invalid Input Data"),
	NO_INVESTIGATION_DETAILS_FOUND("ERR-CON-010", "No Investigation Data Found For Current Appointment Id"),
	NO_PATIENT_REPORT_DETAILS_FOUND("ERR-CON-016", "Patient Report Data Not Found For Current Appointment Id"),
	ERROR_GENERATING_PDF("ERR-CON-011", "Error Generating Pdf"),
	FILE_DOES_NOT_EXIST_IN_GIVEN_PATH("ERR-CON-012", "File does not exist in given file path"),
	NO_MEDICATION_DATA_FOUND_FOR_APPTID("ERR-CON-013","No patient medication data found."),
	NO_CONSULTATION_DATA_FOUND("ERR-CON-014","No cousulation data found."),
	NO_APPOINTMENT_MAPPED_WITH_PROVIDED_APPOINTMENTID("ERR-CON-015", "No appointment mapped with provided appointmentId"),
	NO_APPOINTMENT_ID_FOUND("ERR-CON-0021", "Appointment ID can not be null"),
	SOMETHING_WENT_WRONG("ERR-CON-020","Something went wrong, Please contact admin."),
	NO_CONSULT_PRESCRIPTION_DETAILS_FOUND("ERR-CON-0050","No Consult prescription details found for given Appointment id"),
	PDF_GENERATE_ERROR("ERR-CON-0023", "Something went wrong while genrating pdf"),
	File_WRITE("ERR-CON-0041", "Something went wrong while writing to file"),
	SIZE_LIMIT("ERR-CON-0042", "File size limit exceeds, select files up to 2 MB!!"),
	SCRIBE_DATA_NOT_FOUND("ERR-CON-0040", "Scribe Data Not Found"),
	WRONG_APPOINTMENT_DATE_FORMAT("ERR-CON-0041", "Invalid appointment date format.Date should be yyy-MM-dd format."),
	ERROR_UPLOADING_HANDWRITTEN_PRESCRIPTION("ERR-CON-0024", "Error uploading handwritten prescription."),
	NO_FILE_PRESENT("ERR-CON-0051","No reports present..."),
	ERROR_UPLOADING_PRESCRIPTION_TEMPLATE("ERR-CON-0025", "Error uploading prescription template."),
	SIZE_PRESCRIPTION("ERR-CON-020","Prescription upload limit is excced"),
	PRESCRIPTION_UPLOAD_ISSUE("ERR-CON-0026", "Please complete consultation first then only you can upload prescription.");
	//PAST_DATE_TIME_CANNOT_CHOOSE("ERR-CON-0026","past date time can't be choose");
	
	private String code;
	private String message;
	private ErrorConstants(String code, String message) {
		this.code = code;
		this.message = message;
	}

	public String getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}
	
}
