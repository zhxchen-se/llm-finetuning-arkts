import { LineChart, LineData, LineDataSet, EntryOhos, XAxis, YAxis, Legend, Description } from '@ohos/mpchart';

@Entry
@Component
struct Index {
  private lineData: LineData = new LineData();
  private chart: LineChart | null = null;

  aboutToAppear() {
    // Create sample entries
    let values: EntryOhos[] = [];
    for (let i = 0; i < 12; i++) {
      values.push(new EntryOhos(i, Math.random() * 100));
    }

    // Create a dataset and give it a type
    let dataSet = new LineDataSet(values, 'Sample Data');
    dataSet.setColor(0xFF007AFF); // Blue color
    dataSet.setCircleColor(0xFF007AFF);
    dataSet.setLineWidth(2);
    dataSet.setCircleRadius(4);
    dataSet.setDrawValues(false);
    dataSet.setMode(LineDataSet.Mode.CUBIC_BEZIER);

    // Add dataset to data
    this.lineData.addDataSet(dataSet);

    // Configure axes
    let xAxis: XAxis = this.chart?.getXAxis();
    if (xAxis) {
      xAxis.setPosition(XAxis.XAxisPosition.BOTTOM);
      xAxis.setDrawGridLines(false);
      xAxis.setGranularity(1);
    }

    let leftAxis: YAxis = this.chart?.getAxisLeft();
    if (leftAxis) {
      leftAxis.setDrawGridLines(true);
      leftAxis.setAxisMinimum(0);
    }

    let rightAxis: YAxis = this.chart?.getAxisRight();
    if (rightAxis) {
      rightAxis.setEnabled(false);
    }

    // Description and legend
    let desc: Description = new Description();
    desc.setText('Line Chart Example');
    this.chart?.setDescription(desc);

    let legend: Legend = this.chart?.getLegend();
    if (legend) {
      legend.setForm(Legend.LegendForm.LINE);
    }
  }

  build() {
    Column() {
      LineChart({
        data: this.lineData
      })
        .width('100%')
        .height('60%')
        .margin({ top: 20 })
        .onAppear(() => {
          // Reference to chart for further configuration
          this.chart = this.$component as LineChart;
          // Re-run configuration after chart is ready
          this.aboutToAppear();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}