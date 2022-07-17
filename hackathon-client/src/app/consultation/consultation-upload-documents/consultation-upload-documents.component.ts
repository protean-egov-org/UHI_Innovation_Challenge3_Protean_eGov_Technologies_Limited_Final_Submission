import { Component, Input, OnInit } from '@angular/core';
import { MatStepper } from '@angular/material/stepper';
import { MatTableDataSource } from '@angular/material/table';
import { Report } from 'src/app/models/report.model';
import { RightViewEnum } from 'src/app/models/right-view.enum';
import { ConsulationService } from 'src/app/services/consulation.service';
import { DocumentService } from 'src/app/services/document.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-consultation-upload-documents',
  templateUrl: './consultation-upload-documents.component.html',
  styleUrls: ['./consultation-upload-documents.component.scss']
})
export class ConsultationUploadDocumentsComponent implements OnInit {
  displayedColumns: string[] = ['reportname', 'view', 'download'];
  dataSource = new MatTableDataSource<Report>([]);
  @Input() stepper!: MatStepper;


  constructor(private consultationService: ConsulationService, private documentService: DocumentService) { }

  ngOnInit(): void {
    this.consultationService.records.next([]);
    this.consultationService.rightView.next(RightViewEnum.records);

    this.consultationService.patient.subscribe(res => {
      this.consultationService.viewDocumentReports(res.ptName).subscribe((res: Report[]) => {
        this.dataSource.data = (res || []).map(r => {
          return {
            ...r,
            reportpath: r.reportpath.replace('/var/telemedicine/', `${environment.fileUrl}`)
          }
        });
      })
    })

  }

  goBack() {
    this.stepper.previous();
  }

  goForward() {
    this.stepper.next();
  }


  view(element: Report) {
    this.consultationService.records.next([element.reportpath]);
  }

  download(element: Report) {
    window.open(element.reportpath);
  }
}

