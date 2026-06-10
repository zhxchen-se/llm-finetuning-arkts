import { CalendarType } from '@ohos.arkui.UIContext';

@Entry
@Component
struct Index {
  @State calendarType: CalendarType = CalendarType.SOLAR;

  build() {
    Column() {
      CalendarPicker({
        type: this.calendarType,
        onChange: (date: Date) => {
          console.log('Selected date: ' + date.toString());
        }
      })
      Button('Switch Calendar')
        .onClick(() => {
          this.calendarType = this.calendarType === CalendarType.SOLAR ? CalendarType.LUNAR : CalendarType.SOLAR;
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}