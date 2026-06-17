import { promptAction } from '@ohos.base';

@Entry
@Component
struct Index {
  @State currentYear: number = new Date().getFullYear();
  @State currentMonth: number = new Date().getMonth();
  @State selectedDay: number = new Date().getDate();
  @State today: number = new Date().getDate();
  @State todayMonth: number = new Date().getMonth();
  @State todayYear: number = new Date().getFullYear();

  private weekdays: string[] = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  private monthNames: string[] = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  aboutToAppear() {
  }

  getDaysInMonth(year: number, month: number): number {
    return new Date(year, month + 1, 0).getDate();
  }

  getFirstDayOfMonth(year: number, month: number): number {
    return new Date(year, month, 1).getDay();
  }

  prevMonth() {
    if (this.currentMonth === 0) {
      this.currentMonth = 11;
      this.currentYear--;
    } else {
      this.currentMonth--;
    }
    this.selectedDay = 1;
  }

  nextMonth() {
    if (this.currentMonth === 11) {
      this.currentMonth = 0;
      this.currentYear++;
    } else {
      this.currentMonth++;
    }
    this.selectedDay = 1;
  }

  isToday(year: number, month: number, day: number): boolean {
    return year === this.todayYear && month === this.todayMonth && day === this.today;
  }

  isSelected(day: number): boolean {
    return day === this.selectedDay;
  }

  @Builder
  WeekdayHeader() {
    Row() {
      ForEach(this.weekdays, (item: string) => {
        Text(item)
          .fontSize(14)
          .fontColor('#666666')
          .width('14.28%')
          .textAlign(TextAlign.Center)
          .padding({ top: 10, bottom: 10 })
      })
    }
    .width('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  DayGrid() {
    Grid() {
      let daysInMonth = this.getDaysInMonth(this.currentYear, this.currentMonth);
      let firstDayIndex = this.getFirstDayOfMonth(this.currentYear, this.currentMonth);

      ForEach(Array.from({ length: firstDayIndex }), (_: unknown, index: number) => {
        GridItem() {
          Text('')
        }
      })

      ForEach(Array.from({ length: daysInMonth }), (_: unknown, index: number) => {
        let day = index + 1;
        GridItem() {
          Column() {
            Text(day.toString())
              .fontSize(16)
              .fontColor(this.isToday(this.currentYear, this.currentMonth, day) ? '#FFFFFF' : '#333333')
              .fontWeight(this.isSelected(day) ? 'bold' : 'normal')
          }
          .width('100%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(this.isSelected(day) ? '#007DFF' : (this.isToday(this.currentYear, this.currentMonth, day) ? '#007DFF' : 'transparent'))
          .borderRadius(this.isSelected(day) || this.isToday(this.currentYear, this.currentMonth, day) ? 25 : 0)
          .onClick(() => {
            this.selectedDay = day;
          })
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
    .width('100%')
    .padding({ left: 5, right: 5 })
  }

  build() {
    Column() {
      // Header
      Row() {
        Button() {
          Text('<')
            .fontSize(20)
            .fontColor('#333333')
        }
        .backgroundColor('transparent')
        .borderRadius(20)
        .onClick(() => {
          this.prevMonth();
        })

        Text(`${this.monthNames[this.currentMonth]} ${this.currentYear}`)
          .fontSize(20)
          .fontWeight('bold')
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button() {
          Text('>')
            .fontSize(20)
            .fontColor('#333333')
        }
        .backgroundColor('transparent')
        .borderRadius(20)
        .onClick(() => {
          this.nextMonth();
        })
      }
      .width('100%')
      .padding({ top: 20, bottom: 20, left: 20, right: 20 })
      .justifyContent(FlexAlign.SpaceBetween)

      // Weekdays
      this.WeekdayHeader()

      // Days
      this.DayGrid()

      // Selected Date Display
      Column() {
        Text('Selected Date')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ bottom: 5 })
        Text(`${this.monthNames[this.currentMonth]} ${this.selectedDay}, ${this.currentYear}`)
          .fontSize(18)
          .fontWeight('bold')
          .fontColor('#007DFF')
      }
      .padding({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}