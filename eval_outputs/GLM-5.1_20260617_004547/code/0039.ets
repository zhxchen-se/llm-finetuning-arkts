@Entry
@Component
struct Index {
  @State selectedDate: Date = new Date()

  build() {
    Column({ space: 20 }) {
      Text('Calendar Picker Example')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Text(`Selected Date: ${this.selectedDate.toDateString()}`)
        .fontSize(20)
        .fontColor('#333333')
        .margin({ bottom: 20 })

      CalendarPicker({
        selected: this.selectedDate
      })
      .onDateChange((value: Date) => {
        this.selectedDate = value
        console.info('Selected Date: ' + value.toDateString())
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}