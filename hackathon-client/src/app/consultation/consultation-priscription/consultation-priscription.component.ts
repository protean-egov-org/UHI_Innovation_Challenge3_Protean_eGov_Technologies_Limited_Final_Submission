import { Component, Input, OnInit, Sanitizer } from '@angular/core';
import { MatStepper } from '@angular/material/stepper';
import { DomSanitizer } from '@angular/platform-browser';
import { RightViewEnum } from 'src/app/models/right-view.enum';
import { SavePrescription } from 'src/app/models/save-prescription.model';
import { ConsulationService } from 'src/app/services/consulation.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-consultation-priscription',
  templateUrl: './consultation-priscription.component.html',
  styleUrls: ['./consultation-priscription.component.scss'],
})
export class ConsultationPriscriptionComponent implements OnInit {
  pdfURL: any;
  @Input() stepper!: MatStepper;

  constructor(private sanitizer: DomSanitizer, private consultationService: ConsulationService) { }

  ngOnInit(): void {
    this.consultationService.rightView.next(RightViewEnum.summary);

    this.pdfURL = this.sanitizer.bypassSecurityTrustResourceUrl('https://vadimdez.github.io/ng2-pdf-viewer/assets/pdf-test.pdf');
    this.getPrescriptionMedicationDetails();
  }

  private getPrescriptionMedicationDetails() {
    this.consultationService.getPriscriptionReport(this.consultationService.uniqueId).subscribe(
      (result) => {
        if (result) {
          const urlOfPDF = result?.pdfPath?.replace('/var/telemedicine/', `${environment['baseUrl']}`);
          this.pdfURL = this.sanitizer.bypassSecurityTrustResourceUrl(urlOfPDF);
        }
      }
    );
  }


  goForward() {
    this.stepper.next();
  }

  goBack() {
    this.stepper.previous();
  }
}
