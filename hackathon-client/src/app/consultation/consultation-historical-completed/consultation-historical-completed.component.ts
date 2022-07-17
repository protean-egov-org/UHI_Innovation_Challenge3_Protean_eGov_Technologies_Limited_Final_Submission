import { DatePipe } from '@angular/common';
import { Component, Input, OnInit } from '@angular/core';
import { MatStepper } from '@angular/material/stepper';
import { HistoricalRecord } from 'src/app/models/historical-record.model';
import { RightViewEnum } from 'src/app/models/right-view.enum';
import { ConsulationService } from 'src/app/services/consulation.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-consultation-historical-completed',
  templateUrl: './consultation-historical-completed.component.html',
  styleUrls: ['./consultation-historical-completed.component.scss'],
  providers: [DatePipe],
})
export class ConsultationHistoricalCompletedComponent implements OnInit {
  displayedColumns: string[] = ['name'];
  dataSource: any = [
    { name: 'Symptons', img: 'symptoms' },
    { name: 'Provisional Diagnosis', img: 'diagnosis' },
    { name: 'Medicines', img: 'medicine' },
    { name: 'Advice', img: 'advice' },
    { name: 'Vitals', img: 'symptoms' },
    { name: 'Document', img: 'Document-upload-icon' },
    { name: 'Json', img: 'Document-upload-icon' },
  ];
  date: Date = new Date();
  nxtDate: Date = new Date();

  @Input() stepper!: MatStepper;

  historicalRecords: HistoricalRecord[] = [];

  constructor(private datePipe: DatePipe, private consulationService: ConsulationService) { }

  ngOnInit(): void {
    this.consulationService.rightView.next(RightViewEnum.chart);
    this.consulationService.viewHistoricalAppointments().subscribe((res) => {
      this.historicalRecords = res;
      this.buildTable();
    });
  }

  goBack() {
    this.stepper.previous();
  }

  goForward() {
    this.stepper.next();
  }

  private buildTable() {
    (this.historicalRecords?.slice(Math.max(this.historicalRecords.length - 3, 0)) || []).forEach((h) => {
      const date = <string>this.datePipe.transform(h.date, 'M/d/yy, h:mm a');
      h.formatedDate = date;
      this.displayedColumns.push(date);
    });

    this.dataSource.forEach((row: any) => {
      this.displayedColumns.forEach((column) => {
        if (column !== 'name') {
          row[column] = this.getRowData(column, row.name);
        }
      });
    });
  }

  private getRowData(date: string, key: string) {
    const data = this.historicalRecords.find((h) => h.formatedDate === date);
    switch (key) {
      case 'Symptons':
        return data?.symptoms;
      case 'Provisional Diagnosis':
        return data?.daignosis;
      case 'Medicines':
        return data?.medicines;
      case 'Advice':
        return data?.advices;
      case 'Vitals':
        return `Tempertature ${data?.temperature}, Respiratory rate ${data?.respiratoryRate}, Heart rate ${data?.heartRate}, Blood pressure ${data?.bloodPressureMin}/${data?.bloodPressureMax}`;
      case 'Document':
        return `<img
        src="assets/img/download.svg"
        (click)="download(data.pdfPath)"
        role="button"
        class="w-auto ms-2"
      />`;
      case 'Json':
        return `<img
        src="assets/img/download.svg"
        (click)="download(data.jsonPath)"
        role="button"
        class="w-auto ms-2"
      />`;
      default:
        return '';
    }
  }

  download(path: string) {
    const url = path?.replace('/var/telemedicine/', `${environment.fileUrl}`);
    window.open(url);
  }
}
