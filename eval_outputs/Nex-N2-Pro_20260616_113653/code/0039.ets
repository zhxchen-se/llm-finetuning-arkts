interface DayCell {
  key: string;
  day: number;
  monthOffset: number;
  currentMonth: boolean;
}

@Component
struct CalendarComponent {
  @Prop selectedDate: Date = new Date();
  @State viewDate: Date = new Date();
  onDateSelected: (date: Date) => void = () => { };

  weekDays: string[] = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  aboutToAppear(): void {
    this.viewDate = new Date(this.selectedDate.getFullYear(), this.selectedDate.getMonth(), 1);
  }

  build() {
    Column() {
      this.CalendarHeader();
      this.WeekHeader();
      this.DayGrid();
    }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(16);
  }

  @Builder
  CalendarHeader() {
    Row() {
      Button('‹')
        .width(40)
        .height(40)
        .fontSize(24)
        .fontColor('#333333')
        .backgroundColor('#F1F3F5')
        .borderRadius(20)
        .padding(0)
        .onClick(() => this.changeMonth(-1));

      Text(`${this.getMonthName(this.viewDate.getMonth())} ${this.viewDate.getFullYear()}`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937');

      Button('›')
        .width(40)
        .height(40)
        .fontSize(24)
        .fontColor('#333333')
        .backgroundColor('#F1F3F5')
        .borderRadius(20)
        .padding(0)
        .onClick(() => this.changeMonth(1));
    }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);
  }

  @Builder
  WeekHeader() {
    Row() {
      ForEach(this.weekDays, (day: string) => {
        Text(day)
          .width('14.28%')
          .fontSize(12)
          .fontColor('#6B7280')
          .textAlign(TextAlign.Center);
      }, (day: string) => day);
    }
      .width('100%')
      .marginTop(12)
      .marginBottom(8);
  }

  @Builder
  DayGrid() {
    Grid() {
      ForEach(this.getCalendarDays(), (day: DayCell) => {
        GridItem() {
          Button() {
            Text(day.day === 0 ? '' : `${day.day}`)
              .fontSize(16)
              .fontColor(this.getDayTextColor(day));
          }
            .width('100%')
            .height('100%')
            .padding(0)
            .backgroundColor(this.isSelectedDay(day) ? '#007DFF' : (day.currentMonth ? '#FFFFFF' : '#F3F4F6'))
            .borderRadius(12)
            .borderWidth(1)
            .borderColor(this.isSelectedDay(day) ? '#FFFFFF' : (this.isToday(day) ? '#007DFF' : '#FFFFFF'))
            .onClick(() => {
              if (day.day > 0) {
                this.selectDate(day);
              }
            });
        }
          .padding(4);
      }, (day: DayCell) => day.key);
    }
      .width('100%')
      .height(300)
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .columnsGap(4)
      .rowsGap(4);
  }

  changeMonth(offset: number): void {
    this.viewDate = new Date(this.viewDate.getFullYear(), this.viewDate.getMonth() + offset, 1);
  }

  selectDate(day: DayCell): void {
    const year: number = this.viewDate.getFullYear();
    const month: number = this.viewDate.getMonth() + day.monthOffset;
    const date: Date = new Date(year, month, day.day);

    this.selectedDate = date;
    this.viewDate = new Date(year, month, 1);
    this.onDateSelected(date);
  }

  getCalendarDays(): DayCell[] {
    const year: number = this.viewDate.getFullYear();
    const month: number = this.viewDate.getMonth();
    const daysInMonth: number = new Date(year, month + 1, 0).getDate();
    const firstDay: number = new Date(year, month, 1).getDay();
    const previousMonthDays: number = new Date(year, month, 0).getDate();
    const cells: DayCell[] = [];

    for (let i: number = firstDay; i > 0; i--) {
      const day: number = previousMonthDays - i + 1;
      cells.push({
        key: `prev-${year}-${month}-${day}`,
        day,
        monthOffset: -1,
        currentMonth: false
      });
    }

    for (let day: number = 1; day <= daysInMonth; day++) {
      cells.push({
        key: `current-${year}-${month}-${day}`,
        day,
        monthOffset: 0,
        currentMonth: true
      });
    }

    let nextDay: number = 1;
    while (cells.length < 42) {
      cells.push({
        key: `next-${year}-${month}-${nextDay}`,
        day: nextDay,
        monthOffset: 1,
        currentMonth: false
      });
      nextDay++;
    }

    return cells;
  }

  getDateForCell(day: DayCell): Date {
    const year: number = this.viewDate.getFullYear();
    const month: number = this.viewDate.getMonth() + day.monthOffset;
    return new Date(year, month, day.day);
  }

  isSelectedDay(day: DayCell): boolean {
    if (day.day === 0) {
      return false;
    }
    return this.isSameDay(this.selectedDate, this.getDateForCell(day));
  }

  isToday(day: DayCell): boolean {
    if (day.day === 0) {
      return false;
    }
    return this.isSameDay(new Date(), this.getDateForCell(day));
  }

  isSameDay(first: Date, second: Date): boolean {
    return first.getFullYear() === second.getFullYear()
      && first.getMonth() === second.getMonth()
      && first.getDate() === second.getDate();
  }

  getDayTextColor(day: DayCell): string {
    if (this.isSelectedDay(day)) {
      return '#FFFFFF';
    }

    if (!day.currentMonth) {
      return '#9CA3AF';
    }

    return '#1F2937';
  }

  getMonthName(month: number): string {
    const monthNames: string[] = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    if (month >= 0 && month < monthNames.length) {
      return monthNames[month];
    }

    return 'Month';
  }
}

@Entry
@Component
struct Index {
  @State selectedDate: Date = new Date();

  build() {
    Column() {
      Text('Calendar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .width('100%')
        .textAlign(TextAlign.Center);

      CalendarComponent({
        selectedDate: this.selectedDate,
        onDateSelected: (date: Date): void => {
          this.selectedDate = date;
          console.info(`Selected date: ${this.formatDate(date)}`);
        }
      })
        .width('100%');

      Text(`Selected Date: ${this.formatDate(this.selectedDate)}`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#007DFF')
        .width('100%')
        .textAlign(TextAlign.Center)
        .marginTop(24);

      Text('Tap any day to select it.')
        .fontSize(14)
        .fontColor('#6B7280')
        .width('100%')
        .textAlign(TextAlign.Center)
        .marginTop(8);
    }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .backgroundColor('#F6F7FB');
  }

  formatDate(date: Date): string {
    const year: number = date.getFullYear();
    const month: string = this.pad(date.getMonth() + 1);
    const day: string = this.pad(date.getDate());
    return `${year}-${month}-${day}`;
  }

  pad(value: number): string {
    return value < 10 ? `0${value}` : `${value}`;
  }
}