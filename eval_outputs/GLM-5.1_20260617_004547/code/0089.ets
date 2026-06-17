@Entry
@Component
struct Index {
  @State currentYear: number = new Date().getFullYear()
  @State currentMonth: number = new Date().getMonth() + 1
  @State days: number[] = []
  private weekDays: string[] = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

  aboutToAppear() {
    this.updateDays()
  }

  private updateDays() {
    let tempDays: number[] = []
    let firstDayOfWeek = new Date(this.currentYear, this.currentMonth - 1, 1).getDay()
    let daysInMonth = new Date(this.currentYear, this.currentMonth, 0).getDate()

    for (let i = 0; i < firstDayOfWeek; i++) {
      tempDays.push(0)
    }
    for (let i = 1; i <= daysInMonth; i++) {
      tempDays.push(i)
    }
    this.days = tempDays
  }

  private prevMonth() {
    if (this.currentMonth === 1) {
      this.currentMonth = 12
      this.currentYear--
    } else {
      this.currentMonth--
    }
    this.updateDays()
  }

  private nextMonth() {
    if (this.currentMonth === 12) {
      this.currentMonth = 1
      this.currentYear++
    } else {
      this.currentMonth++
    }
    this.updateDays()
  }

  private isToday(day: number): boolean {
    let now = new Date()
    return day === now.getDate() && this.currentMonth === now.getMonth() + 1 && this.currentYear === now.getFullYear()
  }

  build() {
    Column() {
      // Header
      Row() {
        Button('<')
          .onClick(() => this.prevMonth())
          .backgroundColor(Color.Transparent)
          .fontColor(Color.Black)
          .fontSize(20)

        Text(`${this.currentYear} - ${this.currentMonth.toString().padStart(2, '0')}`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 20, right: 20 })
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('>')
          .onClick(() => this.nextMonth())
          .backgroundColor(Color.Transparent)
          .fontColor(Color.Black)
          .fontSize(20)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .margin({ bottom: 20 })

      // Weekdays Header
      Row() {
        ForEach(this.weekDays, (day: string) => {
          Text(day)
            .width('14.28%')
            .textAlign(TextAlign.Center)
            .fontSize(16)
            .fontColor('#888888')
            .fontWeight(FontWeight.Medium)
        })
      }
      .width('100%')
      .padding({ left: 10, right: 10 })
      .margin({ bottom: 10 })

      // Days Grid
      Grid() {
        ForEach(this.days, (day: number) => {
          GridItem() {
            if (day > 0) {
              Text(day.toString())
                .width(40)
                .height(40)
                .textAlign(TextAlign.Center)
                .borderRadius(20)
                .fontSize(18)
                .fontColor(this.isToday(day) ? Color.White : Color.Black)
                .backgroundColor(this.isToday(day) ? '#007DFF' : Color.Transparent)
                .fontWeight(this.isToday(day) ? FontWeight.Bold : FontWeight.Normal)
            } else {
              Text('')
                .width(40)
                .height(40)
            }
          }
          .padding(5)
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsGap(5)
      .columnsGap(5)
      .width('100%')
      .padding({ left: 10, right: 10 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F5F5F5')
  }
}