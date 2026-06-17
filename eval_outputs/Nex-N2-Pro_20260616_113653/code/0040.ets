@Entry
@Component
struct Index {
  @State selectedDate: Date = new Date()
  @State isLunar: boolean = false

  private parseDatePickerValue(value: string): Date {
    const parts: Array<string> = value.split('-')
    if (parts.length === 3) {
      return new Date(Number(parts[0]), Number(parts[1]) - 1, Number(parts[2]))
    }
    return new Date(value)
  }

  private logSelectedDate(value: string): void {
    console.info(`Selected date (${this.isLunar ? 'Lunar' : 'Solar'}): ${value}`)
  }

  build() {
    Column() {
      Text('Calendar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 24 })

      Button('Switch Calendar')
        .width('90%')
        .height(48)
        .onClick(() => {
          this.isLunar = !this.isLunar
        })
        .margin({ bottom: 24 })

      Text(`Calendar Type: ${this.isLunar ? 'Lunar' : 'Solar'}`)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Text(`Selected Date: ${this.selectedDate.toLocaleDateString()}`)
        .fontSize(16)
        .margin({ bottom: 20 })

      DatePicker({ selected: this.selectedDate })
        .lunar(this.isLunar)
        .width('90%')
        .onChange((value: string) => {
          this.selectedDate = this.parseDatePickerValue(value)
          this.logSelectedDate(value)
        })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#F5F7FA')
    .alignItems(HorizontalAlign.Center)
  }
}