@Entry
@Component
struct Index {
  @State selectedHour: number = 12
  @State selectedMinute: number = 0
  @State is24HourFormat: boolean = false

  formatTime(): string {
    const minuteStr = this.selectedMinute.toString().padStart(2, '0')
    if (this.is24HourFormat) {
      const hourStr = this.selectedHour.toString().padStart(2, '0')
      return `${hourStr}:${minuteStr}`
    } else {
      const period = this.selectedHour >= 12 ? 'PM' : 'AM'
      let displayHour = this.selectedHour % 12
      if (displayHour === 0) {
        displayHour = 12
      }
      return `${displayHour}:${minuteStr} ${period}`
    }
  }

  build() {
    Column() {
      Text('Selected Time:')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })

      Text(this.formatTime())
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      TimePicker({
        hour: this.selectedHour,
        minute: this.selectedMinute
      })
        .is24Hour(this.is24HourFormat)
        .onChange((hour: number, minute: number) => {
          this.selectedHour = hour
          this.selectedMinute = minute
        })
        .margin({ bottom: 30 })

      Button(this.is24HourFormat ? 'Switch to 12-Hour' : 'Switch to 24-Hour')
        .onClick(() => {
          this.is24HourFormat = !this.is24HourFormat
        })
        .width('60%')
        .height(50)
        .backgroundColor('#007DFF')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}