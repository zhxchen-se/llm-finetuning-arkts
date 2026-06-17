@Entry
@Component
struct Index {
  @State selectedDate: Date = new Date()
  @State calendarType: CalendarType = CalendarType.SOLAR

  build() {
    Column({ space: 20 }) {
      Button('Switch Calendar')
        .fontSize(18)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .onClick(() => {
          this.calendarType = this.calendarType === CalendarType.SOLAR ? CalendarType.LUNAR : CalendarType.SOLAR
        })

      Calendar({ selected: this.selectedDate })
        .calendarType(this.calendarType)
        .onDateChange((value: Date) => {
          console.log('Selected date changed: ' + value.toDateString())
          this.selectedDate = value
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}