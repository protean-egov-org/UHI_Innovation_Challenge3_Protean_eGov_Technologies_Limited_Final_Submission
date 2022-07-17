import { Component, OnInit } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { ConsulationService } from 'src/app/services/consulation.service';

@Component({
  selector: 'app-records',
  templateUrl: './records.component.html',
  styleUrls: ['./records.component.scss']
})
export class RecordsComponent implements OnInit {

  records: SafeResourceUrl[] = [];

  constructor(private sanitizer: DomSanitizer, private consulationService: ConsulationService) { }

  ngOnInit(): void {
    this.consulationService.records.subscribe(res => {
      this.records = res.map((r: any) => this.sanitizer.bypassSecurityTrustResourceUrl(r));
    })
  }

}
