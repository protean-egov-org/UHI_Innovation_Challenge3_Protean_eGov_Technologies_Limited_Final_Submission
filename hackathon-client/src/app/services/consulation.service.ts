import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { HistoricalRecord } from '../models/historical-record.model';
import { BehaviorSubject, catchError, map, Observable, of } from 'rxjs';
import { Patient } from '../models/patient.model';
import { ResponseWrapper } from '../models/response-wrapper.interface';
import { RightViewEnum } from '../models/right-view.enum';
import { SavePrescription } from '../models/save-prescription.model';
import { Snomad, SnomadItem } from '../models/snomad.model';
import { Vital } from '../models/vital.model';
import { mockHistoricalRecords } from '../models/mock-temperature';
import { PrescriptionReport } from '../models/prescription-report.model';
import { mockLabRecord } from '../models/mock-lab-records';
import { LabRecord } from '../models/lab-records.model';
import { MasterData, RuleEngine } from '../models/rule-engine.model';
import { mockRule } from '../models/mock-rule.const';
import { Report } from '../models/report.model';

@Injectable({
  providedIn: 'root',
})
export class ConsulationService {
  rightView = new BehaviorSubject<keyof typeof RightViewEnum>(RightViewEnum.summary);

  symptomDetails = new BehaviorSubject<string[]>([]);
  diagnosisDetails = new BehaviorSubject<string[]>([]);
  medicineDetails = new BehaviorSubject<string[]>([]);
  adviceDetails = new BehaviorSubject<string[]>([]);
  vitalDetails = new BehaviorSubject<Vital>({} as Vital);

  records = new BehaviorSubject<any>([]);

  uniqueId: number = 0;

  patient = new BehaviorSubject<Patient>({} as Patient);

  constructor(private http: HttpClient) { }

  private baseUrl = '';

  getAllPatients(): Observable<Patient[]> {
    return this.http
      .get<ResponseWrapper<Patient[]>>(`${this.baseUrl}/symptoms/getPatientDetailsList`)
      .pipe(map((res: any) => res.response));
  }

  savePrescription(data: SavePrescription): Observable<ResponseWrapper<string>> {
    const payload = { request: data };
    return this.http.post<ResponseWrapper<string>>(`${this.baseUrl}/priscription/savePriscriptionDtls`, payload);
  }

  submitPrescription(data: SavePrescription): Observable<ResponseWrapper<string>> {
    return this.http
      .post<ResponseWrapper<string>>(`${this.baseUrl}/getPatientDetailsList`, data)
      .pipe(catchError(() => of({} as any)));
  }

  searchSymptoms(text: string): Observable<SnomadItem[]> {
    return this.http
      .get<ResponseWrapper<Snomad>>(`${this.baseUrl}/symptoms/getSymptomDetailsList?query=${text}`)
      .pipe(map((res) => res.response.items));
  }

  viewDocumentReports(name: string): Observable<Report[]> {
    return this.http.get<ResponseWrapper<Report[]>>(`${this.baseUrl}/priscription/downloadPatientReport/${name}`).pipe(map(res => res.response));
  }

  viewHistoricalAppointments(): Observable<HistoricalRecord[]> {
    return this.http
      .get<ResponseWrapper<HistoricalRecord[]>>(`${this.baseUrl}/priscription/view-historical-data`)
      .pipe(map((res) => res.response));
  }

  getPriscriptionReport(id: number): Observable<PrescriptionReport> {
    return this.http
      .get<ResponseWrapper<PrescriptionReport>>(`${this.baseUrl}/getPriscriptionReport/${id}`)
      .pipe(map((res) => res.response));
  }

  searchDiagnosis(text: string): Observable<SnomadItem[]> {
    return this.http
      .get<ResponseWrapper<Snomad>>(`${this.baseUrl}/symptoms/getDiagnosisDetailsList?query=${text}`)
      .pipe(map((res) => res.response.items));
  }

  searchMedicine(): Observable<MasterData[]> {
    return this.http
      .get<ResponseWrapper<MasterData[]>>(`${this.baseUrl}/symptoms/medicines`)
      .pipe(map((res) => res.response));
  }

  searchAdvice(): Observable<MasterData[]> {
    return this.http
      .get<ResponseWrapper<MasterData[]>>(`${this.baseUrl}/symptoms/advice`)
      .pipe(map((res) => res.response));
  }

  fetchRecords(): Observable<LabRecord[]> {
    return this.http.get<ResponseWrapper<LabRecord[]>>(`${this.baseUrl}/priscription/getFetchRecords`).pipe(
      map((res) => res.response),
      catchError(() => of(mockLabRecord)),
    );
  }

  getSearchEngineDetailsBySymtpoms(id: string): Observable<RuleEngine> {
    return this.http
      .get<ResponseWrapper<RuleEngine>>(`${this.baseUrl}/symptoms/getSearchEngineDetailsBySymtpoms?id=${id}`)
      .pipe(
        map((res) => res.response),
        catchError(() => of(mockRule)),
      );
  }
  /*
    labnames(): Observable<string[]> {
      return this.http
        .get<string[]>(`${this.baseUrl}/transfer/labnames`)
        .pipe(catchError(() => of(['DR LAL PATH LABS', 'SRL DIAGNOSTICS', 'METROPOLIS'])));
    } */
  /*
    hiuRequest(lab: string): Observable<any> {
      const data = {
        labName: lab,
      };
      return this.http.post<any>(`${this.baseUrl}/hiu/request`, data).pipe(catchError(() => of()));
    }

    hiuFetchData(lab: string): Observable<any> {
      const data = {
        labName: lab,
      };
      return this.http.post<any>(`${this.baseUrl}/hiu/fetch-data`, data).pipe(catchError(() => of()));
    }

    getRecordByLabName(lab: string): Observable<string[]> {
      const data = {
        labName: lab,
      };
      return this.http.post<string[]>(`${this.baseUrl}/hiu/get-recordby-labname`, data).pipe(catchError(() => of()));
    } */
}

//Observable<ResponseWrapper<any>
