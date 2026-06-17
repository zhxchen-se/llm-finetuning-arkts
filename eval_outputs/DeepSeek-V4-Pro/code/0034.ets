import { animateTo } from '@kit.ArkUI';

interface DayForecast {
  day: string;
  high: number;
  low: number;
  icon: string;
}

@Entry
@Component
struct Index {
  @State currentTemp: number = 24;
  @State currentCondition: string = 'Sunny';
  @State currentIcon: string = '☀️';
  @State forecast: DayForecast[] = [
    { day: 'Mon', high: 26, low: 18, icon: '⛅' },
    { day: 'Tue', high: 28, low: 20, icon: '☀️' },
    { day: 'Wed', high: 22, low: 16, icon: '🌧️' },
    { day: 'Thu', high: 19, low: 14, icon: '☁️' },
    { day: 'Fri', high: 25, low: 17, icon: '⛅' }
  ];
  @State showContent: boolean = false;

  aboutToAppear() {
    // Trigger entrance animation after a short delay
    setTimeout(() => {
      animateTo({ duration: 800, curve: Curve.EaseOut }, () => {
        this.showContent = true;
      });
    }, 100);
  }

  build() {
    Column() {
      // Current weather section
      Column() {
        Text(this.currentIcon)
          .fontSize(80)
          .opacity(this.showContent ? 1 : 0)
          .scale({ x: this.showContent ? 1 : 0, y: this.showContent ? 1 : 0 })
          .animation({ duration: 600, curve: Curve.EaseOut })

        Text(`${this.currentTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .margin({ top: 10 })
          .opacity(this.showContent ? 1 : 0)
          .animation({ duration: 800, curve: Curve.EaseOut })

        Text(this.currentCondition)
          .fontSize(24)
          .fontColor('#FFFFFF')
          .opacity(0.8)
          .margin({ top: 5 })
          .opacity(this.showContent ? 1 : 0)
          .animation({ duration: 1000, curve: Curve.EaseOut })
      }
      .width('100%')
      .padding({ top: 60, bottom: 30 })
      .justifyContent(FlexAlign.Center)

      // 5-day forecast
      List() {
        ForEach(this.forecast, (item: DayForecast, index: number) => {
          ListItem() {
            Row() {
              Text(item.day)
                .fontSize(18)
                .fontColor('#FFFFFF')
                .width(60)
                .textAlign(TextAlign.Start)

              Text(item.icon)
                .fontSize(30)
                .layoutWeight(1)
                .textAlign(TextAlign.Center)

              Row() {
                Text(`${item.low}°`)
                  .fontSize(16)
                  .fontColor('#FFFFFF')
                  .opacity(0.7)
                Text(' / ')
                  .fontSize(16)
                  .fontColor('#FFFFFF')
                  .opacity(0.7)
                Text(`${item.high}°`)
                  .fontSize(16)
                  .fontColor('#FFFFFF')
              }
              .width(80)
              .justifyContent(FlexAlign.End)
            }
            .width('100%')
            .padding({ left: 20, right: 20, top: 12, bottom: 12 })
            .alignItems(VerticalAlign.Center)
            .backgroundColor('rgba(255, 255, 255, 0.15)')
            .borderRadius(12)
            .margin({ bottom: 8 })
            .opacity(this.showContent ? 1 : 0)
            .translate({ y: this.showContent ? 0 : 20 })
            .animation({ duration: 600, curve: Curve.EaseOut, delay: 200 + index * 100 })
          }
        }, (item: DayForecast, index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 20, right: 20, top: 10 })
      .divider({ strokeWidth: 0 }) // remove default divider
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#4A90E2', 0], ['#1E3C72', 1]]
    })
    .padding({ top: 40 })
  }
}