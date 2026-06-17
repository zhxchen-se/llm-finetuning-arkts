import { router } from '@kit.ArkUI';

interface ForecastItem {
  day: string;
  temp: number;
  condition: string;
  icon: string;
}

@Entry
@Component
struct Index {
  @State currentTemp: number = 0;
  @State condition: string = 'Sunny';
  @State location: string = 'San Francisco';
  @State forecastData: Array<ForecastItem> = [];
  @State isLoading: boolean = true;

  aboutToAppear() {
    this.loadWeatherData();
  }

  loadWeatherData() {
    // Simulate API fetch
    setTimeout(() => {
      this.forecastData = [
        { day: 'Mon', temp: 22, condition: 'Sunny', icon: '☀️' },
        { day: 'Tue', temp: 19, condition: 'Cloudy', icon: '☁️' },
        { day: 'Wed', temp: 17, condition: 'Rainy', icon: '🌧️' },
        { day: 'Thu', temp: 20, condition: 'Partly Cloudy', icon: '⛅' },
        { day: 'Fri', temp: 23, condition: 'Sunny', icon: '☀️' }
      ];
      this.condition = 'Sunny';
      this.isLoading = false;
      
      // Animate temperature count up
      animateTo({
        duration: 1000,
        curve: Curve.EaseOut
      }, () => {
        this.currentTemp = 24;
      });
    }, 800);
  }

  build() {
    Column() {
      // Header
      Row() {
        Text(this.location)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
        
        Blank()
        
        Button() {
          Text('Refresh')
            .fontSize(14)
            .fontColor('#FFFFFF')
        }
        .backgroundColor('#FFFFFF30')
        .borderRadius(20)
        .padding({ left: 15, right: 15, top: 5, bottom: 5 })
        .onClick(() => {
          this.isLoading = true;
          this.loadWeatherData();
        })
      }
      .width('100%')
      .padding(20)
      .justifyContent(FlexAlign.SpaceBetween)

      // Current Weather
      Column() {
        Text(this.condition)
          .fontSize(32)
          .fontColor('#FFFFFF')
          .margin({ bottom: 10 })
        
        Text(this.isLoading ? '...' : `${this.currentTemp}°`)
          .fontSize(72)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
        
        Text(this.isLoading ? 'Loading' : 'Feels like 22°')
          .fontSize(16)
          .fontColor('#FFFFFF80')
          .margin({ top: 5 })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // Forecast
      Column() {
        Text('5-Day Forecast')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .alignSelf(ItemAlign.Start)
          .margin({ bottom: 15, left: 20 })

        Scroll() {
          Row() {
            ForEach(this.forecastData, (item: ForecastItem) => {
              Column() {
                Text(item.day)
                  .fontSize(16)
                  .fontColor('#FFFFFFCC')
                  .margin({ bottom: 10 })
                
                Text(item.icon)
                  .fontSize(32)
                  .margin({ bottom: 10 })
                
                Text(`${item.temp}°`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
              }
              .width(80)
              .height(120)
              .backgroundColor('#FFFFFF15')
              .borderRadius(15)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .margin({ right: 15 })
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('40%')
      .backgroundColor('#FFFFFF10')
      .borderRadius({ topLeft: 30, topRight: 30 })
      .padding({ top: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .background(
      LinearGradient({
        angle: 180,
        colors: [['#4A90E2', 0.0], ['#007AFF', 1.0]]
      })
    )
  }
}