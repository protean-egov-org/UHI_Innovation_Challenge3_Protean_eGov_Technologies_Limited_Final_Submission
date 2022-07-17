import { Component, OnInit, ViewChild } from '@angular/core';
import { FormControl, } from '@angular/forms';
import { MatStepper } from '@angular/material/stepper';
import { Patient } from 'src/app/models/patient.model';
import { RightViewEnum } from 'src/app/models/right-view.enum';
import { ConsulationService } from 'src/app/services/consulation.service';

@Component({
  selector: 'app-consultation',
  templateUrl: './consultation.component.html',
  styleUrls: ['./consultation.component.scss'],
})
export class ConsultationComponent implements OnInit {
  isExpanded = false;
  plusMinus = this.isExpanded ? '-' : '+';

  patients: Patient[] = [];

  patientControl = new FormControl();

  patient: Patient | undefined;

  rightView: keyof typeof RightViewEnum | undefined;

  @ViewChild('stepper')
  private myStepper!: MatStepper;
  constructor(
    private consulationService: ConsulationService
  ) { }

  ngOnInit(): void {

    this.consulationService.getAllPatients().subscribe(res => {
      this.patients = res;
      this.patient = res[0];
      this.consulationService.patient.next(this.patient);
    })

    this.consulationService.rightView.subscribe(res => {
      this.rightView = res;
    })

    this.patientControl.valueChanges.subscribe(res => {
      this.patient = res;
      this.consulationService.patient = res;
    });
  }

  setPlusMinus(): void {
    this.plusMinus = this.isExpanded ? '-' : '+';
  }

}
