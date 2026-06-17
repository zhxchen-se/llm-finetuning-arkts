import { LineChart, LineData, LineDataSet, Entry, XAxis, YAxis } from '@ohos/mpchart';

@Entry
@Component
struct Index {
  private chartModel: LineChart = new LineChart();

  aboutToAppear() {
    this.setupChart();
  }

  private setupChart() {
    const dataValues: Entry[] = [];
    for (let i = 0; i < 12; i++) {
      dataValues.push(new Entry(i, Math.random() * 100 + 20));
    }

    const lineDataSet = new LineDataSet(dataValues, 'Monthly Revenue');
    lineDataSet.setLineWidth(2);
    lineDataSet.setCircleRadius(4);
    lineDataSet.setDrawValues(true);

    const lineData = new LineData(lineDataSet);
    this.chartModel.setData(lineData);

    this.chartModel.getDescription().setEnabled(false);
    this.chartModel.setDrawGridBackground(false);
    this.chartModel.setTouchEnabled(true);
    this.chartModel.setDragEnabled(true);
    this.chartModel.setScaleEnabled(true);
    this.chartModel.setPinchZoom(true);

    const xAxis = this.chartModel.getXAxis();
    xAxis.setPosition(XAxis.XAxisPosition.BOTTOM);
    xAxis.setDrawGridLines(false);
    xAxis.setGranularity(1);

    const leftAxis = this.chartModel.getAxisLeft();
    leftAxis.setDrawGridLines(true);
    leftAxis.setAxisMinimum(0);

    const rightAxis = this.chartModel.getAxisRight();
    rightAxis.setEnabled(false);

    this.chartModel.invalidate();
  }

  build() {
    Column() {
      Text('Revenue Overview')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })
        .fontColor('#333333')

      LineChart({ chart: this.chartModel })
        .width('100%')
        .height(400)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding(10)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F5F5F5')
  }
}