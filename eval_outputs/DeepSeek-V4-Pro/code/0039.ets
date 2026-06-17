import { CalendarPicker } from '@ohos.arkui.advanced.CalendarPicker';

@Entry
@Component
struct Index {
  @State selectedDate: Date = new Date();

  build() {
    Column() {
      CalendarPicker({
        selectedDate: this.selectedDate,
        onChange: (value: Date) => {
          this.selectedDate = value;
          console.log('Selected date: ' + value.toString());
        }
      })
        .width('100%')
        .height(300)

      Text(`Selected Date: ${this.selectedDate.toDateString()}`)
        .fontSize(20)
        .margin({ top: 20 })
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}