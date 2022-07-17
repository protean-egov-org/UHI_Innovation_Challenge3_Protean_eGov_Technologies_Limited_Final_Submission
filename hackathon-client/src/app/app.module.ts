import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms'
import { ReactiveFormsModule } from '@angular/forms'
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
//import { NgxSpinnerModule } from 'ngx-spinner';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatBadgeModule } from '@angular/material/badge';
import { MatButtonModule } from '@angular/material/button';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatChipsModule } from '@angular/material/chips';
import { MatNativeDateModule, MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatDialogModule } from '@angular/material/dialog';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatMenuModule } from '@angular/material/menu';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatSliderModule } from '@angular/material/slider';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { MatSortModule } from '@angular/material/sort';
import { MatStepperModule } from '@angular/material/stepper';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatTreeModule } from '@angular/material/tree';
import { ConsultationDetailsComponent } from './consultation/consultation-details/consultation-details.component';
import { ConsultationPriscriptionComponent } from './consultation/consultation-priscription/consultation-priscription.component';
import { ConsultationComponent } from './consultation/consultation/consultation.component';
import { DatePipe } from '@angular/common';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { ApiInterceptor } from './api.interceptor';
import { ConsultationUploadDocumentsComponent } from './consultation/consultation-upload-documents/consultation-upload-documents.component';
import { ConsultationHistoricalCompletedComponent } from './consultation/consultation-historical-completed/consultation-historical-completed.component';
import { PdfViewerModule } from 'ng2-pdf-viewer';
import { HighchartsChartModule } from 'highcharts-angular';
import { SummaryComponent } from './consultation/summary/summary.component';
import { ChartComponent } from './consultation/chart/chart.component';
import { ToastrModule } from 'ngx-toastr';
import { ConsultationFetchRecordComponent } from './consultation/consultation-fetch-record/consultation-fetch-record.component';
import { RecordsComponent } from './consultation/records/records.component';
import { NgxSpinnerModule } from 'ngx-spinner';

@NgModule({
  declarations: [
    AppComponent,
    ConsultationComponent,
    ConsultationPriscriptionComponent,
    ConsultationDetailsComponent,
    ConsultationUploadDocumentsComponent,
    ConsultationHistoricalCompletedComponent,
    SummaryComponent,
    ChartComponent,
    ConsultationFetchRecordComponent,
    RecordsComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    ToastrModule.forRoot(), // ToastrModule added
    PdfViewerModule,
    HighchartsChartModule,
    NgxSpinnerModule.forRoot({ type: 'ball-scale-multiple' }),
    MatTableModule,
    MatButtonModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
    MatAutocompleteModule,
    MatSelectModule,
    MatPaginatorModule,
    MatSortModule,
    MatCheckboxModule,
    MatMenuModule,
    MatIconModule,
    MatSnackBarModule,
    MatSlideToggleModule,
    MatButtonToggleModule,
    MatCardModule,
    MatListModule,
    MatTabsModule,
    MatRadioModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatExpansionModule,
    FormsModule,
    ReactiveFormsModule,
    MatTooltipModule,
    MatProgressSpinnerModule,
    MatStepperModule,
    MatProgressBarModule,
    MatGridListModule,
    MatBadgeModule,
    MatRippleModule,
    MatSidenavModule,
    MatSliderModule,
    MatChipsModule,
    MatToolbarModule,
    MatTreeModule,
  ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
  providers: [DatePipe, { provide: HTTP_INTERCEPTORS, useClass: ApiInterceptor, multi: true },],
  bootstrap: [AppComponent]
})
export class AppModule { }
