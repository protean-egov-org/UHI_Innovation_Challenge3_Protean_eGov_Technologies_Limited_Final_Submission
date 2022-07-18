package com.protean.symptoms.dto;

import java.io.Serializable;
import java.util.List;

public class SymptomDetailsDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	List<DiagnosisDetails> diagnosisDetails;
	List<MedicinesDetails> medicinesDetails;
	List<AdviceDetails> advicesDetails;
	
	public List<DiagnosisDetails> getDiagnosisDetails() {
		return diagnosisDetails;
	}
	public void setDiagnosisDetails(List<DiagnosisDetails> diagnosisDetails) {
		this.diagnosisDetails = diagnosisDetails;
	}
	public List<AdviceDetails> getAdvicesDetails() {
		return advicesDetails;
	}
	public void setAdvicesDetails(List<AdviceDetails> advicesDetails) {
		this.advicesDetails = advicesDetails;
	}
	public List<MedicinesDetails> getMedicinesDetails() {
		return medicinesDetails;
	}
	public void setMedicinesDetails(List<MedicinesDetails> medicinesDetails) {
		this.medicinesDetails = medicinesDetails;
	}
	
	
}
