import { Component, Input, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatStepper } from '@angular/material/stepper';
import { LabRecord } from 'src/app/models/lab-records.model';
import { RightViewEnum } from 'src/app/models/right-view.enum';
import { ConsulationService } from 'src/app/services/consulation.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-consultation-fetch-record',
  templateUrl: './consultation-fetch-record.component.html',
  styleUrls: ['./consultation-fetch-record.component.scss'],
})
export class ConsultationFetchRecordComponent implements OnInit {
  selectLab = new FormControl();
  sources: LabRecord[] = [];
  @Input() stepper!: MatStepper;
  constructor(private fb: FormBuilder, private consultationService: ConsulationService) { }

  ngOnInit(): void {
    this.consultationService.records.next([]);
    this.consultationService.rightView.next(RightViewEnum.records);
    this.consultationService.fetchRecords().subscribe((res: LabRecord[]) => {
      this.sources = res.map(r => {
        return {
          ...r,
          recordsPath: (r.recordsPath || []).map(p => p?.replace('/var/telemedicine/', `${environment.fileUrl}`))
        }
      });
    })
    this.getRecords();

  }

  /*  private getRecords() {
     this.selectLab.valueChanges.subscribe((lab: string) => {
       this.consultationService.hiuRequest(lab).subscribe(() => {
         this.consultationService.hiuFetchData(lab).subscribe(() => {
           this.consultationService.getRecordByLabName(lab).subscribe(res => {
             this.consultationService.records.next(res);
           })
         })
       })

     })
   } */

  private getRecords() {
    this.selectLab.valueChanges.subscribe((lab: LabRecord) => {
      /* lab.recordsPath.forEach(r => {
        r.replace('/var/telemedicine/', `${environment.fileUrl}`);
      }) */
      this.consultationService.records.next(lab.recordsPath);
    })
  }

  goForward() {
    this.stepper.next();
  }

  goBack() {
    this.stepper.previous();
  }
}
