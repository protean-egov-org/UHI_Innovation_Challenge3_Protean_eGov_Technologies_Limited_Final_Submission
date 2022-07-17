import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConsultationHistoricalCompletedComponent } from './consultation-historical-completed.component';

describe('ConsultationHistoricalCompletedComponent', () => {
  let component: ConsultationHistoricalCompletedComponent;
  let fixture: ComponentFixture<ConsultationHistoricalCompletedComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ConsultationHistoricalCompletedComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ConsultationHistoricalCompletedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
