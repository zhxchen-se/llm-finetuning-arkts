import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State currentYear: number = new Date().getFullYear();
  @State currentMonth: number = new Date().getMonth(); // 0-11
  @State today: Date = new Date();

  // Days of week header
  private weekDays: string[] = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  // Get number of days in month
  private getDaysInMonth(year: number, month: number): number {
    return new Date(year, month + 1, 0).getDate();
  }

  // Get the day of week for the 1st of month (0 = Sunday)
  private getFirstDayOfWeek(year: number, month: number): number {
    return new Date(year, month, 1).getDay();
  }

  // Generate calendar grid data: array of numbers (0 for empty, day number otherwise)
  private generateCalendarGrid(): number[] {
    const daysInMonth = this.getDaysInMonth(this.currentYear, this.currentMonth);
    const startDay = this.getFirstDayOfWeek(this.currentYear, this.currentMonth);
    const totalCells = 42; // 6 rows * 7 columns
    const grid: number[] = new Array(totalCells).fill(0);

    for (let i = 0; i < daysInMonth; i++) {
      grid[startDay + i] = i + 1;
    }
    return grid;
  }

  // Check if a day is today
  private isToday(day: number): boolean {
    if (day === 0) return false;
    const todayDate = this.today;
    return (
      todayDate.getFullYear() === this.currentYear &&
      todayDate.getMonth() === this.currentMonth &&
      todayDate.getDate() === day
    );
  }

  // Navigate to previous month
  private previousMonth(): void {
    if (this.currentMonth === 0) {
      this.currentMonth = 11;
      this.currentYear--;
    } else {
      this.currentMonth--;
    }
  }

  // Navigate to next month
  private nextMonth(): void {
    if (this.currentMonth === 11) {
      this.currentMonth = 0;
      this.currentYear++;
    } else {
      this.currentMonth++;
    }
  }

  build() {
    Column() {
      // Header with month/year and navigation
      Row() {
        Button('<')
          .width(40)
          .height(40)
          .fontSize(20)
          .backgroundColor('#00000000')
          .onClick(() => this.previousMonth())

        Text(`${this.currentYear} - ${this.currentMonth + 1}`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('>')
          .width(40)
          .height(40)
          .fontSize(20)
          .backgroundColor('#00000000')
          .onClick(() => this.nextMonth())
      }
      .width('100%')
      .padding(10)
      .justifyContent(FlexAlign.SpaceBetween)

      // Weekday headers
      Row() {
        ForEach(this.weekDays, (day: string) => {
          Text(day)
            .width('14.28%')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .padding({ top: 5, bottom: 5 })
        })
      }
      .width('100%')

      // Calendar grid
      Grid() {
        ForEach(this.generateCalendarGrid(), (day: number, index: number) => {
          GridItem() {
            if (day !== 0) {
              Text(day.toString())
                .fontSize(18)
                .textAlign(TextAlign.Center)
                .width('100%')
                .height('100%')
                .borderRadius(20)
                .backgroundColor(this.isToday(day) ? '#007AFF' : '#00000000')
                .fontColor(this.isToday(day) ? Color.White : Color.Black)
            } else {
              // Empty cell
              Text('')
                .width('100%')
                .height('100%')
            }
          }
          .width('14.28%')
          .aspectRatio(1)
          .border({ width: 0.5, color: '#E0E0E0' })
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .width('100%')
      .padding(5)
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#F5F5F5')
  }
}