import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConsultationUploadDocumentsComponent } from './consultation-upload-documents.component';

describe('ConsultationUploadDocumentsComponent', () => {
  let component: ConsultationUploadDocumentsComponent;
  let fixture: ComponentFixture<ConsultationUploadDocumentsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ConsultationUploadDocumentsComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ConsultationUploadDocumentsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
