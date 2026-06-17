import { Column, Row, Text, Button, Stack, Width, Height, Padding, Margin, Align, FontWeight, FlexAlign } from '@ohos.arkui';
import { LineChart } from '@ohos/mpchart';

interface ChartDataSet {
  label: string;
  data: number[];
  color: string;
}

interface ChartData {
  labels: string[];
  datasets: ChartDataSet[];
}

interface ChartConfig {
  showLegend: boolean;
  showGrid: boolean;
  yAxisMax: number;
}

@Entry
@Component
struct Index {
  @State chartData: ChartData = {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
    datasets: [{
      label: 'Sales',
      data: [10, 20, 15, 25, 30, 25],
      color: '#36A2EB'
    }]
  };

  @State chartConfig: ChartConfig = {
    showLegend: true,
    showGrid: true,
    yAxisMax: 50
  };

  build() {
    Column() {
      Text('MPChart Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      Stack() {
        LineChart({
          data: this.chartData,
          config: this.chartConfig
        })
        .width('90%')
        .height(300)
      }
      .margin({ bottom: 20 })
      .backgroundColor('#F5F5F5')
      .borderRadius(10)
      .padding(10)

      Row() {
        Button('Update Data')
          .onClick(() => {
            this.updateData();
          })
          .backgroundColor('#007DFF')
          .fontColor('#FFFFFF')
          .padding({ left: 20, right: 20 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .padding(20)
    .backgroundColor('#FFFFFF')
  }

  updateData() {
    const newData = this.chartData.datasets[0].data.map(() => Math.floor(Math.random() * 50));
    this.chartData = {
      ...this.chartData,
      datasets: [{
        ...this.chartData.datasets[0],
        data: newData
      }]
    };
  }
}