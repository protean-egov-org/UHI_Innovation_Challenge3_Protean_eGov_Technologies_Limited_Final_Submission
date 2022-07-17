import { Component, OnInit } from '@angular/core';
import { Vital } from 'src/app/models/vital.model';
import { ConsulationService } from 'src/app/services/consulation.service';

@Component({
  selector: 'app-summary',
  templateUrl: './summary.component.html',
  styleUrls: ['./summary.component.scss'],
})
export class SummaryComponent implements OnInit {
  symptomDetails: string[] = [];
  diagnosisDetails: string[] = [];
  medicineDetails: string[] = [];
  adviceDetails: string[] = [];
  vital: Vital = {} as Vital;

  constructor(private consulationService: ConsulationService) { }

  ngOnInit(): void {
    this.consulationService.symptomDetails.subscribe((res) => (this.symptomDetails = res));
    this.consulationService.adviceDetails.subscribe((res) => (this.adviceDetails = res));
    this.consulationService.diagnosisDetails.subscribe((res) => (this.diagnosisDetails = res));
    this.consulationService.medicineDetails.subscribe((res) => (this.medicineDetails = res));
    this.consulationService.vitalDetails.subscribe((res) => (this.vital = res));
  }
}
