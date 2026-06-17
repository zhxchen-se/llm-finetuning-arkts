@Entry
@Component
struct Index {
  @State selectedDate: string = 'Please select a date';

  build() {
    Column() {
      Text(this.selectedDate)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50, bottom: 30 })
        .textAlign(TextAlign.Center)

      Calendar({
        startDate: new Date('2020-01-01').getTime(),
        endDate: new Date('2030-12-31').getTime(),
        selected: new Date().getTime()
      })
      .onChange((date: number) => {
        this.selectedDate = this.formatDate(date);
        console.info('Selected date timestamp:', date);
        console.info('Selected date formatted:', this.selectedDate);
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }

  formatDate(timestamp: number): string {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
}