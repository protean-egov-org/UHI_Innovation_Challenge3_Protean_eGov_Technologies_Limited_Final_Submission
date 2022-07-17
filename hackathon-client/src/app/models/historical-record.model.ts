export interface HistoricalRecord {
  date: string;
  symptoms: string;
  daignosis: string;
  medicines: string;
  advices: string;
  temperature: number;
  respiratoryRate: number;
  bloodPressureMin: number;
  bloodPressureMax: number;
  heartRate: number;
  pdfPath: string;
  pdfData: string;
  jsonPath: string;
  jsonDate: string;

  formatedDate: string;
}
