@Entry
@Component
struct Index {
  @State is24Hour: boolean = false
  @State selectedHour: number = new Date().getHours()
  @State selectedMinute: number = new Date().getMinutes()

  private formatTime(): string {
    const hour = this.selectedHour
    const minute = this.selectedMinute

    if (this.is24Hour) {
      return `${hour.toString().padStart(2, '0')}:${minute.toString().padStart(2, '0')}`
    } else {
      const period = hour >= 12 ? 'PM' : 'AM'
      let displayHour = hour % 12
      if (displayHour === 0) {
        displayHour = 12
      }
      return `${displayHour.toString().padStart(2, '0')}:${minute.toString().padStart(2, '0')} ${period}`
    }
  }

  build() {
    Column({ space: 20 }) {
      Text('Time Selector')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Text(this.formatTime())
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#007DFF')
        .margin({ top: 10, bottom: 10 })

      Button(this.is24Hour ? 'Switch to 12-Hour' : 'Switch to 24-Hour')
        .width('60%')
        .height(50)
        .fontSize(18)
        .backgroundColor('#007DFF')
        .borderRadius(25)
        .onClick(() => {
          this.is24Hour = !this.is24Hour
        })

      TimePicker({
        selected: new Date(),
        useMilitaryTime: this.is24Hour
      })
      .onChange((value: TimePickerResult) => {
        this.selectedHour = value.hour ?? this.selectedHour
        this.selectedMinute = value.minute ?? this.selectedMinute
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F5F5')
    .padding({ left: 20, right: 20 })
  }
}