import { console } from '@ohos.base';

@Entry
@Component
struct Index {
  @State viewDate: Date = new Date();
  @State selectedDate: Date = new Date();
  @State isLunar: boolean = false;
  @State daysArray: Array<{ day: number, isCurrentMonth: boolean, date: Date }> = [];

  private lunarInfo: Array<number> = [
    0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2,
    0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0, 0x0ada2, 0x095b0, 0x14977,
    0x04970, 0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970,
    0x06566, 0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0, 0x1c8d7, 0x0c950,
    0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557,
    0x06ca0, 0x0b550, 0x15355, 0x04da0, 0x0a5b0, 0x14573, 0x052b0, 0x0a9a8, 0x0e950, 0x06aa0,
    0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260, 0x0f263, 0x0d950, 0x05b57, 0x056a0,
    0x096d0, 0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b6a0, 0x195a6,
    0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40, 0x0af46, 0x0ab60, 0x09570,
    0x04af5, 0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0,
    0x0c960, 0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0, 0x092d0, 0x0cab5,
    0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930,
    0x07954, 0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65, 0x0d530,
    0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0, 0x1d0b6, 0x0d250, 0x0d520, 0x0dd45,
    0x0b5a0, 0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0
  ];

  private Gan = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"];
  private Zhi = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"];
  private Animals = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"];
  private lunarMonths = ["正", "二", "三", "四", "五", "六", "七", "八", "九", "十", "冬", "腊"];
  private lunarDays = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
    "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
    "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"];

  aboutToAppear() {
    this.generateDays();
  }

  generateDays() {
    this.daysArray = [];
    const year = this.viewDate.getFullYear();
    const month = this.viewDate.getMonth();
    
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const startDayOfWeek = firstDay.getDay(); 
    const totalDays = lastDay.getDate();

    const prevMonthLastDay = new Date(year, month, 0).getDate();

    for (let i = startDayOfWeek - 1; i >= 0; i--) {
      const d = new Date(year, month - 1, prevMonthLastDay - i);
      this.daysArray.push({ day: prevMonthLastDay - i, isCurrentMonth: false, date: d });
    }

    for (let i = 1; i <= totalDays; i++) {
      const d = new Date(year, month, i);
      this.daysArray.push({ day: i, isCurrentMonth: true, date: d });
    }

    const remaining = 42 - this.daysArray.length; 
    for (let i = 1; i <= remaining; i++) {
      const d = new Date(year, month + 1, i);
      this.daysArray.push({ day: i, isCurrentMonth: false, date: d });
    }
  }

  getLunarDate(date: Date): string {
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();
    
    let offset = (Date.UTC(year, month - 1, day) - Date.UTC(1900, 0, 31)) / 86400000;
    if (offset < 0) return "日期超出范围";

    let iYear, iMonth, iDay;
    let isLeap = false;
    let leapMonth = 0;

    for (iYear = 1900; iYear < 2101 && offset > 0; iYear++) {
      let l = this.lunarInfo[iYear - 1900];
      let leap = (l & 0xf);
      let leapDays = 0;
      let daysInYear = 0;

      for (let k = 0; k < 12; k++) {
        daysInYear += ((l >> k) & 1) ? 30 : 29;
      }

      if (leap > 0) {
        let leapBit = (l >> 16) & 1;
        let leapMonthDays = ((l >> (leap + 16)) & 1) ? 30 : 29;
        daysInYear += leapMonthDays;
        leapMonth = leap;
      }

      offset -= daysInYear;
    }
    
    if (offset < 0) {
      offset += daysInYear;
      iYear--;
    }

    let l = this.lunarInfo[iYear - 1900];
    let leap = (l & 0xf);
    let isLeapMonth = false;

    for (iMonth = 1; iMonth < 13 && offset > 0; iMonth++) {
      if (leap > 0 && iMonth === (leap + 1) && !isLeapMonth) {
        iMonth--;
        isLeapMonth = true;
        let leapBit = (l >> 16) & 1;
        let leapMonthDays = ((l >> (leap + 16)) & 1) ? 30 : 29;
        offset -= leapMonthDays;
      } else {
        let days = ((l >> (iMonth - 1)) & 1) ? 30 : 29;
        offset -= days;
      }
    }

    if (offset === 0 && isLeapMonth) {
      isLeapMonth = false;
      iMonth++;
    }
    
    if (offset < 0) {
      offset += ((l >> (iMonth - 1)) & 1) ? 30 : 29;
      iMonth--;
    }

    iDay = Math.floor(offset) + 1;
    
    let ganIndex = (iYear - 4) % 10;
    let zhiIndex = (iYear - 4) % 12;
    let animal = this.Animals[zhiIndex];
    
    let mStr = isLeapMonth ? "闰" + this.lunarMonths[iMonth - 1] : this.lunarMonths[iMonth - 1];
    let dStr = this.lunarDays[iDay - 1];

    return `${this.Gan[ganIndex]}${this.Zhi[zhiIndex]}年 (${animal}) ${mStr}月${dStr}`;
  }

  formatDate(date: Date): string {
    const y = date.getFullYear();
    const m = date.getMonth() + 1;
    const d = date.getDate();
    return `${y}年${m}月${d}日`;
  }

  onDayClick(date: Date) {
    this.selectedDate = date;
    this.viewDate = new Date(date.getFullYear(), date.getMonth(), 1);
    this.generateDays();
    this.logSelectedDate();
  }

  toggleCalendar() {
    this.isLunar = !this.isLunar;
    this.logSelectedDate();
  }

  logSelectedDate() {
    const type = this.isLunar ? "Lunar" : "Solar";
    const dateStr = this.isLunar ? this.getLunarDate(this.selectedDate) : this.formatDate(this.selectedDate);
    console.info(`Selected Date (${type}): ${dateStr}`);
  }

  prevMonth() {
    this.viewDate = new Date(this.viewDate.getFullYear(), this.viewDate.getMonth() - 1, 1);
    this.generateDays();
  }

  nextMonth() {
    this.viewDate = new Date(this.viewDate.getFullYear(), this.viewDate.getMonth() + 1, 1);
    this.generateDays();
  }

  build() {
    Column() {
      Text('HarmonyOS Calendar')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      Row() {
        Button('<')
          .onClick(() => this.prevMonth())
          .width(40)
          .height(40)
          .backgroundColor('#007DFF')
        
        Text(`${this.viewDate.getFullYear()}年 ${this.viewDate.getMonth() + 1}月`)
          .fontSize(20)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('>')
          .onClick(() => this.nextMonth())
          .width(40)
          .height(40)
          .backgroundColor('#007DFF')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 10 })

      Button(this.isLunar ? 'Switch to Solar' : 'Switch to Lunar')
        .onClick(() => this.toggleCalendar())
        .backgroundColor(this.isLunar ? '#E6A23C' : '#67C23A')
        .width('200')
        .height(40)
        .margin({ bottom: 20 })

      Grid() {
        ForEach(['日', '一', '二', '三', '四', '五', '六'], (item) => {
          GridItem() {
            Text(item)
              .fontWeight(FontWeight.Bold)
              .fontSize(16)
          }
        })

        ForEach(this.daysArray, (item) => {
          GridItem() {
            Column() {
              Text(item.day.toString())
                .fontSize(item.isCurrentMonth ? 18 : 14)
                .fontColor(item.isCurrentMonth ? '#000000' : '#CCCCCC')
              
              if (item.isCurrentMonth && this.isLunar) {
                Text(this.getLunarDate(item.date).split(' ')[2] || '')
                  .fontSize(10)
                  .fontColor('#666666')
              }
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .onClick(() => this.onDayClick(item.date))
            .backgroundColor(
              item.date.toDateString() === this.selectedDate.toDateString() 
                ? '#007DFF' 
                : 'transparent'
            )
            .borderRadius(8)
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsGap(10)
      .columnsGap(10)
      .width('90%')
      .height(400)

      Text('Selected: ' + (this.isLunar ? this.getLunarDate(this.selectedDate) : this.formatDate(this.selectedDate)))
        .fontSize(16)
        .margin({ top: 20 })
        .fontColor('#333333')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
}