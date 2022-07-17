import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConsultationFetchRecordComponent } from './consultation-fetch-record.component';

describe('ConsultationFetchRecordComponent', () => {
  let component: ConsultationFetchRecordComponent;
  let fixture: ComponentFixture<ConsultationFetchRecordComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ConsultationFetchRecordComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ConsultationFetchRecordComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
