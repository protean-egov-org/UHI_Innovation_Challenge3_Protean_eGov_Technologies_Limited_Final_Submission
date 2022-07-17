import { HistoricalRecord } from './historical-record.model';

export const mockHistoricalRecords = [
  {
    date: '2022-07-16T11:10:49.578Z',
    symptoms: 'R factor,Factitious psychosis',
    advices: 'asdfsafs, asdfsaf',
    bloodPressureMax: 12,
    daignosis: 'Viral hepatitis E,Viral hepatitis, type G',
    medicines: 'sadf, asdfa',
    temperature: 98,
    respiratoryRate: 20,
    heartRate: 60,
  },
  {
    date: '2022-07-15T11:10:49.578Z',
    symptoms: 'R factor,Factitious psychosis',
    advices: 'asdfsafs, asdfsaf',
    bloodPressureMax: 34435,
    daignosis: 'Viral hepatitis E,Viral hepatitis, type G',
    medicines: 'sadf, asdfa',
    temperature: 100,
    respiratoryRate: 18,
    heartRate: 100,
  },
  {
    date: '2022-07-14T11:10:49.578Z',
    symptoms: 'R factor,Factitious psychosis',
    advices: '',
    bloodPressureMax: '3245325',
    daignosis: 'Viral hepatitis E,Viral hepatitis, type G',
    medicines: 'sadf, asdfa',
    temperature: 96.5,
    respiratoryRate: 13,
    heartRate: 80,
  },
] as HistoricalRecord[];
