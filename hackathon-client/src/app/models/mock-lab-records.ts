import { LabRecord } from './lab-records.model';

export const mockLabRecord = [
  {
    name: 'Lab1',
    recordsPath: ['https://vadimdez.github.io/ng2-pdf-viewer/assets/pdf-test.pdf'],
  },
  {
    name: 'Lab2',
    recordsPath: [
      'https://vadimdez.github.io/ng2-pdf-viewer/assets/pdf-test.pdf',
      'https://vadimdez.github.io/ng2-pdf-viewer/assets/pdf-test.pdf',
    ],
  },
] as LabRecord[];
