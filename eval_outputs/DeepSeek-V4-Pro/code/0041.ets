import { TimePickerResult } from '@ohos.arkui.advanced.TimePicker';

@Entry
@Component
struct Index {
  @State is24Hour: boolean = false;
  @State selectedHour: number = 0;
  @State selectedMinute: number = 0;

  aboutToAppear() {
    const now = new Date();
    this.selectedHour = now.getHours();
    this.selectedMinute = now.getMinutes();
  }

  build() {
    Column() {
      TimePicker({
        selected: this.selectedHour * 60 + this.selectedMinute,
        useMilitaryTime: this.is24Hour
      })
        .onChange((value: TimePickerResult) => {
          this.selectedHour = value.hour;
          this.selectedMinute = value.minute;
        })
        .margin({ bottom: 20 });

      Button(this.is24Hour ? 'Switch to 12-hour' : 'Switch to 24-hour')
        .onClick(() => {
          this.is24Hour = !this.is24Hour;
        })
        .margin({ bottom: 20 });

      Text(this.formatTime())
        .fontSize(30)
        .fontWeight(FontWeight.Bold);
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20);
  }

  formatTime(): string {
    if (this.is24Hour) {
      return `${this.pad(this.selectedHour)}:${this.pad(this.selectedMinute)}`;
    } else {
      let hour12 = this.selectedHour % 12;
      if (hour12 === 0) {
        hour12 = 12;
      }
      const ampm = this.selectedHour < 12 ? 'AM' : 'PM';
      return `${this.pad(hour12)}:${this.pad(this.selectedMinute)} ${ampm}`;
    }
  }

  pad(num: number): string {
    return num < 10 ? '0' + num : num.toString();
  }
}