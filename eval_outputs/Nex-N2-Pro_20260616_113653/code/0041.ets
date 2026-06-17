@Entry
@Component
struct Index {
  @State selectedTime: Date = new Date();
  @State use24Hour: boolean = true;

  formatSelectedTime(): string {
    const hour = this.selectedTime.getHours();
    const minute = this.selectedTime.getMinutes();
    const minuteText = minute < 10 ? `0${minute}` : `${minute}`;

    if (this.use24Hour) {
      const hourText = hour < 10 ? `0${hour}` : `${hour}`;
      return `${hourText}:${minuteText}`;
    }

    const period = hour >= 12 ? 'PM' : 'AM';
    const displayHour = hour % 12 === 0 ? 12 : hour % 12;
    return `${displayHour}:${minuteText} ${period}`;
  }

  build() {
    Column() {
      Text('Time Selector')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 24 })

      if (this.use24Hour) {
        DatePicker({
          type: TimePickerType.HOUR_24,
          selected: this.selectedTime
        })
          .width('90%')
          .height(220)
          .onChange((value: Date) => {
            this.selectedTime = new Date(value.getTime());
          })
      } else {
        DatePicker({
          type: TimePickerType.HOUR_12,
          selected: this.selectedTime
        })
          .width('90%')
          .height(220)
          .onChange((value: Date) => {
            this.selectedTime = new Date(value.getTime());
          })
      }

      Text(`Selected time: ${this.formatSelectedTime()}`)
        .fontSize(22)
        .margin({ top: 24, bottom: 24 })

      Button() {
        Text(this.use24Hour ? 'Switch to 12-hour format' : 'Switch to 24-hour format')
          .fontSize(16)
          .fontColor('#FFFFFF')
      }
        .width('70%')
        .height(48)
        .backgroundColor('#007DFF')
        .borderRadius(24)
        .onClick(() => {
          this.use24Hour = !this.use24Hour;
        })
    }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding(24)
  }
}