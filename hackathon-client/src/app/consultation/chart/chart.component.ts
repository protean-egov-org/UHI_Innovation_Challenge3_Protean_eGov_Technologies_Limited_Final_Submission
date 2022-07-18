import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import * as Highcharts from 'highcharts/highstock';
import { Options, SeriesOptionsType } from 'highcharts/highstock';
import { HistoricalRecord } from 'src/app/models/historical-record.model';
import { mockHistoricalRecords } from 'src/app/models/mock-temperature';
import { ConsulationService } from 'src/app/services/consulation.service';

@Component({
  selector: 'app-chart',
  templateUrl: './chart.component.html',
  styleUrls: ['./chart.component.scss'],
})
export class ChartComponent implements OnInit {
  highcharts: typeof Highcharts = Highcharts;

  tempChartOptions: Options = { ...chartConfig };
  resChartOptions: Options = { ...chartConfigOne };
  heartChartOptions: Options = { ...chartConfigTwo };
  bloodChartOptions: Options = { ...chartConfigThree };

  historicalRecords: HistoricalRecord[] = [];
  updateFlag = false;

  // tempChartOptions ={
  //   title: {
  //     text: "Monthly Average Temperature"
  //  },
  // }


  constructor(private datePipe: DatePipe, private consultationService: ConsulationService) { }

  ngOnInit(): void {
    this.consultationService.viewHistoricalAppointments().subscribe(res => {
      this.historicalRecords = res?.slice(Math.max(res.length - 3, 0));
      this.setTemperatureChart();
      this.setRespiratoryChart();
      this.setHeartChart();
      this.setBloodChart();
      this.updateFlag = true;
    })

  }
  /*
    selectionChange(event: MatSelectChange) {
      this.tranformData(event.value);
    }

    private tranformData(stockData: any) {
      const currentDate = new Date().getTime();
      const oneMonthAgo = new Date(new Date().setMonth(new Date().getMonth() - 1)).getTime();
      const sixMonthAgo = new Date(new Date().setMonth(new Date().getMonth() - 6)).getTime();
      const oneYearAgo = new Date(new Date().setMonth(new Date().getMonth() - 12)).getTime();
      const fiveYearAgo = new Date(new Date().setMonth(new Date().getMonth() - 60)).getTime();
      const seriesOptions: Array<SeriesOptionsType> = [];
      stockData.forEach((market: any) => {
        const arr = [];
        const convertPrice = (price: string): number => +price.replace(/(^\$|,)/g, '');
        arr.push(
          [fiveYearAgo, convertPrice(market.price5YearsAgo)],
          [oneYearAgo, convertPrice(market.price1YearAgo)],
          [sixMonthAgo, convertPrice(market.price6MonthsAgo)],
          [oneMonthAgo, convertPrice(market.price1MonthAgo)],
          [currentDate, convertPrice(market.currentPrice)],
        );
        seriesOptions.push({
          name: market.company,
          data: arr,
          type: 'line',
        });
      });
      this.chartOptions.series = seriesOptions;
      this.updateFlag = true;
    } */

  /* private createChart() {
    this.tempChartOptions = chartConfig;
    const seriesOptions: Array<SeriesOptionsType> = [];
    const data: any[] = [];

    this.historicalRecords.forEach(h => {
      const date = <string>this.datePipe.transform(h.date, 'M/d/yy, h:mm a');
      data.push([date, this.getRandomNumber(0, 1000)]);
    })

     for (let i = 0; i < 10; i++) {
       date.setDate(new Date().getDate() + i);
       data.push([`${date.getDate()}/${date.getMonth() + 1}`, this.getRandomNumber(0, 1000)]);
     }
     const arr = [];
     const convertPrice = (price: string): number => +price.replace(/(^\$|,)/g, '');
     arr.push(
       [fiveYearAgo, convertPrice(market.price5YearsAgo)],
       [oneYearAgo, convertPrice(market.price1YearAgo)],
       [sixMonthAgo, convertPrice(market.price6MonthsAgo)],
       [oneMonthAgo, convertPrice(market.price1MonthAgo)],
       [currentDate, convertPrice(market.currentPrice)],
     );
    seriesOptions.push({
      name: 'market.company',
      data: data,
      type: 'line',
    });
    this.tempChartOptions.series = seriesOptions;
  } */


  private setBloodChart() {
    const seriesOptions: Array<SeriesOptionsType> = [];
    const minData: any[] = [];
    const maxData: any[] = [];
    const dates: string[] = [];
    const min = 60;
    const max = 100;
    const minRecords: any = [];
    const maxRecords: any = [];
    this.historicalRecords.forEach(h => {
      const date = <string>this.datePipe.transform(h.date, 'M/d/yy, h:mm a');
      dates.push(date);
      minData.push([date, h.bloodPressureMin]);
    })
    this.historicalRecords.forEach(h => {
      const date = <string>this.datePipe.transform(h.date, 'M/d/yy, h:mm a');
      dates.push(date);
      maxData.push([date, h.bloodPressureMax]);
    })

    seriesOptions.push({
      name: 'Patient BP(sys)',
      data: minData,
      type: 'line',
    });

    seriesOptions.push({
      name: 'Patient BP(Dis)',
      data: maxData,
      type: 'line',
    });

    dates.forEach(d => {
      minRecords.push([d, min]);
    });
    dates.forEach(d => {
      maxRecords.push([d, max]);
    })
    seriesOptions.push({
      name: 'Normal BP(Sys)',
      data: minRecords,
      type: 'line',
    })
    seriesOptions.push({
      name: 'Normal BP(Dis)',
      data: maxRecords,
      type: 'line',
    })

    this.bloodChartOptions.series = seriesOptions;
  }

  private setHeartChart() {
    const seriesOptions: Array<SeriesOptionsType> = [];
    const data: any[] = [];
    const dates: string[] = [];
    const min = 60;
    const max = 100;
    const minRecords: any = [];
    const maxRecords: any = [];
    this.historicalRecords.forEach(h => {
      const date = <string>this.datePipe.transform(h.date, 'M/d/yy, h:mm a');
      dates.push(date);
      data.push([date, h.heartRate]);
    })
    seriesOptions.push({
      name: 'Patient Heart rate',
      data: data,
      type: 'line',
    });

    dates.forEach(d => {
      minRecords.push([d, min]);
    });
    dates.forEach(d => {
      maxRecords.push([d, max]);
    })
    seriesOptions.push({
      name: 'Min Heart rate',
      data: minRecords,
      type: 'line',
    })
    seriesOptions.push({
      name: 'Max Heart rate',
      data: maxRecords,
      type: 'line',
    })

    this.heartChartOptions.series = seriesOptions;
  }

  private setRespiratoryChart() {
    const seriesOptions: Array<SeriesOptionsType> = [];
    const data: any[] = [];
    const dates: string[] = [];
    const minRes = 12;
    const maxRes = 20;
    const minRecords: any = [];
    const maxRecords: any = [];
    this.historicalRecords.forEach(h => {
      const date = <string>this.datePipe.transform(h.date, 'M/d/yy, h:mm a');
      dates.push(date);
      data.push([date, h.respiratoryRate]);
    })
    seriesOptions.push({
      name: 'Patient Resp rate',
      data: data,
      type: 'line',
    });

    dates.forEach(d => {
      minRecords.push([d, minRes]);
    });
    dates.forEach(d => {
      maxRecords.push([d, maxRes]);
    })
    seriesOptions.push({
      name: 'Min Resp rate',
      data: minRecords,
      type: 'line',
    })
    seriesOptions.push({
      name: 'Max Resp rate',
      data: maxRecords,
      type: 'line',
    })

    this.resChartOptions.series = seriesOptions;
  }

  private setTemperatureChart() {
    const seriesOptions: Array<SeriesOptionsType> = [];
    const data: any[] = [];
    const dates: string[] = [];
    const normalTemp = 98.4;
    const minRecords: any = [];
    this.historicalRecords.forEach(h => {
      const date = <string>this.datePipe.transform(h.date, 'M/d/yy, h:mm a');
      dates.push(date);
      data.push([date, h.temperature]);
    })
    seriesOptions.push({
      name: 'Patient Temp',
      data: data,
      type: 'line',
    });

    dates.forEach(d => {
      minRecords.push([d, normalTemp]);
    });

    seriesOptions.push({
      name: 'Normal Temp',
      data: minRecords,
      type: 'line',
    })

    this.tempChartOptions.series = seriesOptions;
  }
}


const chartConfig = {
    title:{
      text: 'Temperature'
    },
  rangeSelector: {
    selected: 5,
  },
  yAxis: {          
    title:{
       text:"Temperature °C"
    } 
 },
  xAxis: {
    type: 'category',
  },
  tooltip: {
    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
    valueDecimals: 2,
    split: true,
  },
  series: [],
} as Options;

const chartConfigOne = {
  title:{
    text: 'Respiratory Rate'
  },

  yAxis: {          
    title:{
       text:"Breaths/Min"
    } 
 },
  rangeSelector: {
    selected: 5,
  },
  xAxis: {
    type: 'category',
  },
  tooltip: {
    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
    valueDecimals: 2,
    split: true,
  },
  series: [],
} as Options;



const chartConfigTwo = {
  title:{
    text: 'Heart Rate'
  },
  rangeSelector: {
    selected: 5,
  },
  yAxis: {          
    title:{
       text:"Beats/Min"
    } 
 },
  xAxis: {
    type: 'category',
  },
  tooltip: {
    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
    valueDecimals: 2,
    split: true,
  },
  series: [],
} as Options;

const chartConfigThree = {
  title:{
    text: 'Blood Pressure'
  },
  rangeSelector: {
    selected: 5,
  },
  yAxis: {          
    title:{
       text:"Sys/Dis"
    } 
 },
  xAxis: {
    type: 'category',
  },
  tooltip: {
    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
    valueDecimals: 2,
    split: true,
  },
  series: [],
} as Options;
