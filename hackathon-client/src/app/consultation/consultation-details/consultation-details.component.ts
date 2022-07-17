import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormControl } from '@angular/forms';
import { MatStepper } from '@angular/material/stepper';
import { DomSanitizer } from '@angular/platform-browser';
import { NgxSpinnerService } from 'ngx-spinner';
import { debounceTime, switchMap, tap } from 'rxjs';
import { ResponseWrapper } from 'src/app/models/response-wrapper.interface';
import { RightViewEnum } from 'src/app/models/right-view.enum';
import { MasterData } from 'src/app/models/rule-engine.model';
import { SavePrescription } from 'src/app/models/save-prescription.model';
import { SnomadItem } from 'src/app/models/snomad.model';
import { Vital } from 'src/app/models/vital.model';
import { ConsulationService } from 'src/app/services/consulation.service';
import { ToastMessageService } from 'src/app/services/toast-message.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-consultation-details',
  templateUrl: './consultation-details.component.html',
  styleUrls: ['./consultation-details.component.scss'],
})
export class ConsultationDetailsComponent implements OnInit {
  /*  symptoms  */

  searchSymptomsCtrl = new FormControl();
  filteredSymptoms: SnomadItem[] = [];
  isSymptomLoading = true;
  selectedSymptoms: SnomadItem[] = [];
  vitalFormGroup = this.fb.group({
    temperature: [],
    respiratoryRate: [],
    heartRate: [],
    bloodPressureMin: [],
    bloodPressureMax: [],
  });

  pdfURL: any;

  /*  Diagnosis */
  searchDiagnosisCtrl = new FormControl();
  allDiagnosis: SnomadItem[] = [];
  filteredDiagnosis: SnomadItem[] = [];
  selectedDiagnosis: SnomadItem[] = [];

  /* Medicine  */
  searchMedicineCtrl = new FormControl();
  filteredMedicine: MasterData[] = [];
  allMedicine: MasterData[] = [];
  selectedMedicine: MasterData[] = [];

  /* Advice  */
  searchAdviceCtrl = new FormControl();
  filteredAdvice: MasterData[] = [];
  allAdvice: MasterData[] = [];
  selectedAdvice: MasterData[] = [];

  @Input() stepper!: MatStepper;

  constructor(
    private consulationService: ConsulationService,
    private fb: FormBuilder,
    private spinner: NgxSpinnerService,
    private toastMessageService: ToastMessageService,
    private sanitizer: DomSanitizer,
  ) { }

  ngOnInit(): void {
    this.consulationService.rightView.next(RightViewEnum.summary);
    this.searchSymptoms();
    this.setVitals();
    this.searchDiagnosis();
    this.searchMedicine();
    this.searchAdvice();

    this.consulationService.searchAdvice().subscribe(res => {
      this.allAdvice = res;
      this.filteredAdvice = [...this.allAdvice];
    })

    this.consulationService.searchMedicine().subscribe(res => {
      this.allMedicine = res;
      this.filteredMedicine = [...this.allMedicine];
    })
  }

  private setVitals() {
    this.vitalFormGroup.valueChanges.subscribe((res: any) => {
      const vital = {
        ...res,
      } as Vital;
      this.consulationService.vitalDetails.next(vital);
    });
  }

  private searchSymptoms() {
    this.searchSymptomsCtrl.valueChanges
      .pipe(
        debounceTime(500),
        tap(() => {
          this.filteredSymptoms = [];
          this.isSymptomLoading = true;
        }),
        switchMap((value: string) => this.consulationService.searchSymptoms(value)),
      )
      .subscribe((data: any) => {
        this.isSymptomLoading = false;
        this.filteredSymptoms = data;
      });
  }

  selectSymptom(symptom: SnomadItem) {
    if (!this.selectedSymptoms.includes(symptom)) {
      this.selectedSymptoms.push(symptom);
    }
    this.getDiagnosis(symptom.name);
    this.getSearchEngineDetailsBySymtpoms(symptom.code);

    this.searchSymptomsCtrl.setValue('');
    this.consulationService.symptomDetails.next(this.selectedSymptoms.map((s) => s.name));
  }

  private getSearchEngineDetailsBySymtpoms(id: string) {
    this.consulationService.getSearchEngineDetailsBySymtpoms(id).subscribe((res) => {
      this.allAdvice = res.advicesDetails;
      this.filteredAdvice = [...this.allAdvice];

      this.allMedicine = res.medicinesDetails;
      this.filteredMedicine = [...res.medicinesDetails];
    });
  }

  private searchDiagnosis() {
    this.searchDiagnosisCtrl.valueChanges.pipe(debounceTime(500)).subscribe((res) => {
      if (res) {
        this.filteredDiagnosis = this.allDiagnosis.filter((d) => d.name.includes(res));
      } else {
        this.filteredDiagnosis = [...this.allDiagnosis];
      }
    });
  }

  private getDiagnosis(value: string) {
    this.consulationService.searchDiagnosis(value).subscribe((res: any) => {
      this.allDiagnosis = [...res];
      this.filteredDiagnosis = [...res];
    });
  }

  selectDiagnosis(diagnosis: SnomadItem) {
    if (!this.selectedDiagnosis.includes(diagnosis)) {
      this.selectedDiagnosis.push(diagnosis);
    }
    this.searchDiagnosisCtrl.setValue('');
    this.filteredDiagnosis = [...this.allDiagnosis];
    this.consulationService.diagnosisDetails.next(this.selectedDiagnosis.map((s) => s.name));
  }

  private searchMedicine() {
    this.searchMedicineCtrl.valueChanges.pipe(debounceTime(500)).subscribe((res) => {
      if (res) {
        this.filteredMedicine = this.allMedicine.filter((d) => d.name.includes(res));
      } else {
        this.filteredMedicine = [...this.allMedicine];
      }
    });
  }

  selectMedicine(medicine: MasterData) {
    if (!this.selectedMedicine.includes(medicine)) {
      this.selectedMedicine.push(medicine);
    }
    this.searchMedicineCtrl.setValue('');
    this.filteredMedicine = [...this.allMedicine];
    this.consulationService.medicineDetails.next(this.selectedMedicine.map((s) => s.name));
  }

  private searchAdvice() {
    this.searchAdviceCtrl.valueChanges.pipe(debounceTime(500)).subscribe((res) => {
      if (res) {
        this.filteredAdvice = this.allAdvice.filter((d) => d.name.includes(res));
      } else {
        this.filteredAdvice = [...this.allAdvice];
      }
    });
  }

  selectAdvice(advice: MasterData) {
    if (!this.selectedAdvice.includes(advice)) {
      this.selectedAdvice.push(advice);
    }
    this.searchAdviceCtrl.setValue('');
    this.filteredAdvice = [...this.allAdvice];
    this.consulationService.adviceDetails.next(this.selectedAdvice.map((s) => s.name));
  }

  save() {
    this.consulationService.uniqueId = new Date().getTime();
    const { temperature, respiratoryRate, bloodPressureMin, bloodPressureMax, heartRate } = this.vitalFormGroup.value;
    const data = {
      uniqueId: this.consulationService.uniqueId,
      symptoms: this.selectedSymptoms.map((s) => s.name).join(),
      daignosis: this.selectedDiagnosis.map((s) => s.name).join(),
      advice: this.selectedAdvice.map((s) => s.name).join(),
      medicines: this.selectedMedicine.map((s) => s.name).join(),
      ptName: this.consulationService.patient.value?.ptName,
      drName: this.consulationService.patient.value?.drName,
      temperature: `${temperature}`,
      respiratoryRate: `${respiratoryRate}`,
      bloodPressureMin: `${bloodPressureMin}`,
      bloodPressureMax: `${bloodPressureMax}`,
      heartRate: `${heartRate}`,
    } as SavePrescription;
    this.spinner.show();
    this.consulationService.savePrescription(data).subscribe({
      next: (res: ResponseWrapper<string>) => {
        if (res) {
          this.toastMessageService.showSuccessMsg(res.response);
          this.getPrescriptionMedicationDetails();
        }
        this.spinner.hide();
      },
      error: (err) => {
        this.spinner.hide();
        this.toastMessageService.showErrorMsg('Error');
      },
    });
  }

  close() {
    this.stepper.selectedIndex = 0;
  }

  private getPrescriptionMedicationDetails() {
    this.consulationService.getPriscriptionReport(this.consulationService.uniqueId).subscribe((result) => {
      if (result) {
        const urlOfPDF = result?.pdfPath?.replace('/var/telemedicine/', `${environment.fileUrl}`);
        this.pdfURL = this.sanitizer.bypassSecurityTrustResourceUrl(urlOfPDF);
      }
    });
  }
}
