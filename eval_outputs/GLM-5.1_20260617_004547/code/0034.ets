import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State currentTemp: number = 24
  @State currentCondition: string = 'Partly Cloudy'
  @State currentLocation: string = 'San Francisco'
  @State currentHumidity: number = 65
  @State currentWind: number = 12
  @State currentUV: number = 5
  @State currentFeelsLike: number = 22
  @State cloudOffset: number = 0
  @State sunRotation: number = 0
  @State rainDropOffset: number = 0
  @State fadeIn: number = 0
  @State slideUp: number = 100
  @State detailSlide: number = 200
  @State forecastItems: Array<ForecastItem> = [
    { day: 'Mon', high: 26, low: 18, condition: 'sunny', icon: '☀️' },
    { day: 'Tue', high: 24, low: 17, condition: 'partly_cloudy', icon: '⛅' },
    { day: 'Wed', high: 22, low: 15, condition: 'rainy', icon: '🌧️' },
    { day: 'Thu', high: 20, low: 14, condition: 'rainy', icon: '🌧️' },
    { day: 'Fri', high: 25, low: 16, condition: 'cloudy', icon: '☁️' }
  ]
  @State hourlyTemps: Array<HourlyTemp> = [
    { hour: 'Now', temp: 24, icon: '⛅' },
    { hour: '1PM', temp: 25, icon: '☀️' },
    { hour: '2PM', temp: 26, icon: '☀️' },
    { hour: '3PM', temp: 25, icon: '⛅' },
    { hour: '4PM', temp: 24, icon: '⛅' },
    { hour: '5PM', temp: 22, icon: '☁️' },
    { hour: '6PM', temp: 20, icon: '🌙' }
  ]

  aboutToAppear() {
    this.startAnimations()
  }

  startAnimations() {
    this.fadeIn = 0
    this.slideUp = 100
    this.detailSlide = 200

    animateTo({ duration: 800, curve: Curve.EaseOut }, () => {
      this.fadeIn = 1
      this.slideUp = 0
    })

    animateTo({ duration: 1000, delay: 300, curve: Curve.EaseOut }, () => {
      this.detailSlide = 0
    })

    this.animateClouds()
    this.animateSun()
    this.animateRain()
  }

  animateClouds() {
    animateTo({ duration: 6000, iterations: -1, curve: Curve.Linear }, () => {
      this.cloudOffset = 30
    })
  }

  animateSun() {
    animateTo({ duration: 20000, iterations: -1, curve: Curve.Linear }, () => {
      this.sunRotation = 360
    })
  }

  animateRain() {
    animateTo({ duration: 1500, iterations: -1, curve: Curve.Linear }, () => {
      this.rainDropOffset = 60
    })
  }

  build() {
    Column() {
      // Scrollable content
      Scroll() {
        Column() {
          // Header with location
          Row() {
            Text('📍 ')
              .fontSize(16)
              .fontColor('#ffffff')
            Text(this.currentLocation)
              .fontSize(18)
              .fontColor('#ffffff')
              .fontWeight(FontWeight.Bold)
          }
          .margin({ top: 10, bottom: 8 })
          .opacity(this.fadeIn)

          // Weather animation area
          Stack() {
            // Sun
            if (this.currentCondition === 'Sunny' || this.currentCondition === 'Partly Cloudy') {
              Stack() {
                // Sun glow
                Circle()
                  .width(120)
                  .height(120)
                  .fill('rgba(255, 200, 50, 0.15)')
                Circle()
                  .width(90)
                  .height(90)
                  .fill('rgba(255, 200, 50, 0.25)')
                // Sun body
                Circle()
                  .width(60)
                  .height(60)
                  .fill('#FFD93D')
                  .shadow({ radius: 30, color: 'rgba(255, 217, 61, 0.5)', offsetX: 0, offsetY: 0 })
              }
              .rotate({ angle: this.sunRotation })
              .position({ x: '60%', y: '10%' })
            }

            // Clouds
            Stack() {
              // Cloud 1
              Stack() {
                Ellipse()
                  .width(80)
                  .height(40)
                  .fill('rgba(255,255,255,0.9)')
                  .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetX: 2, offsetY: 4 })
                Ellipse()
                  .width(50)
                  .height(35)
                  .fill('rgba(255,255,255,0.95)')
                  .position({ x: 10, y: -15 })
                Ellipse()
                  .width(40)
                  .height(30)
                  .fill('rgba(255,255,255,0.9)')
                  .position({ x: 40, y: -10 })
              }
              .offset({ x: this.cloudOffset - 15, y: 0 })

              // Cloud 2
              Stack() {
                Ellipse()
                  .width(60)
                  .height(30)
                  .fill('rgba(255,255,255,0.7)')
                  .shadow({ radius: 5, color: 'rgba(0,0,0,0.08)', offsetX: 1, offsetY: 3 })
                Ellipse()
                  .width(35)
                  .height(25)
                  .fill('rgba(255,255,255,0.75)')
                  .position({ x: 8, y: -12 })
              }
              .offset({ x: -this.cloudOffset + 10, y: 30 })
              .position({ x: -20, y: 20 })
            }
            .position({ x: '15%', y: '30%' })

            // Rain drops
            if (this.currentCondition === 'Rainy') {
              ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
                Column()
                  .width(2)
                  .height(12)
                  .borderRadius(1)
                  .linearGradient({
                    direction: GradientDirection.Down,
                    colors: [['rgba(150,200,255,0.8)', 0], ['rgba(150,200,255,0.2)', 1]]
                  })
                  .offset({ y: this.rainDropOffset + (item % 3) * 10 })
                  .position({ x: `${20 + item * 12}%`, y: `${55 + (item % 2) * 8}%` })
              })
            }
          }
          .width('100%')
          .height(160)
          .opacity(this.fadeIn)

          // Temperature display
          Column() {
            Row() {
              Text(`${this.currentTemp}`)
                .fontSize(80)
                .fontColor('#ffffff')
                .fontWeight(FontWeight.Bold)
                .margin({ right: 4 })
              Text('°C')
                .fontSize(32)
                .fontColor('rgba(255,255,255,0.7)')
                .fontWeight(FontWeight.Light)
                .margin({ top: 20 })
            }
            .alignItems(VerticalAlign.Top)

            Text(this.currentCondition)
              .fontSize(20)
              .fontColor('rgba(255,255,255,0.85)')
              .margin({ top: 4 })

            Text(`Feels like ${this.currentFeelsLike}°C`)
              .fontSize(14)
              .fontColor('rgba(255,255,255,0.6)')
              .margin({ top: 4 })
          }
          .offset({ y: this.slideUp })
          .opacity(this.fadeIn)

          // Weather details cards
          Row() {
            this.DetailCard('💧', 'Humidity', `${this.currentHumidity}%`)
            this.DetailCard('💨', 'Wind', `${this.currentWind} km/h`)
            this.DetailCard('☀️', 'UV Index', `${this.currentUV}`)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ top: 24 })
          .offset({ y: this.detailSlide })
          .opacity(this.fadeIn)

          // Hourly forecast
          Column() {
            Text('Hourly Forecast')
              .fontSize(16)
              .fontColor('rgba(255,255,255,0.9)')
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 12 })
              .width('100%')
              .padding({ left: 8 })

            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.hourlyTemps, (item: HourlyTemp) => {
                  Column() {
                    Text(item.hour)
                      .fontSize(12)
                      .fontColor('rgba(255,255,255,0.7)')
                    Text(item.icon)
                      .fontSize(24)
                      .margin({ top: 6, bottom: 6 })
                    Text(`${item.temp}°`)
                      .fontSize(14)
                      .fontColor('#ffffff')
                      .fontWeight(FontWeight.Medium)
                  }
                  .width(60)
                  .height(90)
                  .borderRadius(16)
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                  .backgroundColor('rgba(255,255,255,0.1)')
                  .backdropBlur(20)
                })
              }
              .padding({ left: 8, right: 8 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
          }
          .margin({ top: 24 })
          .offset({ y: this.detailSlide })
          .opacity(this.fadeIn)

          // 5-Day Forecast
          Column() {
            Text('5-Day Forecast')
              .fontSize(16)
              .fontColor('rgba(255,255,255,0.9)')
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 12 })
              .width('100%')
              .padding({ left: 8 })

            Column({ space: 8 }) {
              ForEach(this.forecastItems, (item: ForecastItem, index: number) => {
                this.ForecastRow(item, index)
              })
            }
            .width('100%')
            .padding({ left: 8, right: 8 })
          }
          .margin({ top: 24 })
          .offset({ y: this.detailSlide })
          .opacity(this.fadeIn)

          // Refresh button
          Button() {
            Row() {
              Text('🔄 Refresh')
                .fontSize(14)
                .fontColor('#ffffff')
            }
          }
          .width(160)
          .height(44)
          .borderRadius(22)
          .backgroundColor('rgba(255,255,255,0.15)')
          .backdropBlur(20)
          .margin({ top: 32, bottom: 40 })
          .onClick(() => {
            this.refreshWeather()
          })
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#1a73e8', 0],
        ['#4a90d9', 0.3],
        ['#6ba3e0', 0.6],
        ['#87b5e0', 1]
      ]
    })
  }

  @Builder
  DetailCard(icon: string, title: string, value: string) {
    Column() {
      Text(icon)
        .fontSize(24)
        .margin({ bottom: 6 })
      Text(title)
        .fontSize(11)
        .fontColor('rgba(255,255,255,0.6)')
        .margin({ bottom: 4 })
      Text(value)
        .fontSize(16)
        .fontColor('#ffffff')
        .fontWeight(FontWeight.Bold)
    }
    .width('30%')
    .height(100)
    .borderRadius(20)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('rgba(255,255,255,0.1)')
    .backdropBlur(20)
  }

  @Builder
  ForecastRow(item: ForecastItem, index: number) {
    Row() {
      Text(item.day)
        .fontSize(14)
        .fontColor('rgba(255,255,255,0.8)')
        .width(50)

      Text(item.icon)
        .fontSize(22)
        .margin({ left: 8, right: 8 })

      // Low temp bar
      Row() {
        // Temperature range bar
        Row()
          .width(`${(item.high - item.low) * 4}%`)
          .height(4)
          .borderRadius(2)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [
              ['#5bb8ff', 0],
              ['#ffd93d', 1]
            ]
          })
          .margin({ left: `${(item.low - 10) * 2}%` })
      }
      .width('40%')
      .height(4)
      .borderRadius(2)
      .backgroundColor('rgba(255,255,255,0.15)')
      .margin({ left: 8, right: 8 })

      Text(`${item.low}°`)
        .fontSize(13)
        .fontColor('rgba(255,255,255,0.5)')
        .width(30)
        .textAlign(TextAlign.End)

      Text(`${item.high}°`)
        .fontSize(14)
        .fontColor('#ffffff')
        .fontWeight(FontWeight.Medium)
        .width(30)
        .textAlign(TextAlign.End)
        .margin({ left: 8 })
    }
    .width('100%')
    .height(50)
    .borderRadius(14)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('rgba(255,255,255,0.08)')
  }

  refreshWeather() {
    const conditions = ['Sunny', 'Partly Cloudy', 'Rainy', 'Cloudy']
    const icons = ['☀️', '⛅', '🌧️', '☁️']
    const idx = Math.floor(Math.random() * conditions.length)
    this.currentTemp = Math.floor(Math.random() * 20) + 15
    this.currentCondition = conditions[idx]
    this.currentHumidity = Math.floor(Math.random() * 50) + 30
    this.currentWind = Math.floor(Math.random() * 25) + 5
    this.currentUV = Math.floor(Math.random() * 10) + 1
    this.currentFeelsLike = this.currentTemp + Math.floor(Math.random() * 5) - 2

    this.forecastItems = this.forecastItems.map((item: ForecastItem) => {
      const cIdx = Math.floor(Math.random() * conditions.length)
      const high = Math.floor(Math.random() * 15) + 18
      return {
        day: item.day,
        high: high,
        low: high - Math.floor(Math.random() * 8) - 3,
        condition: conditions[cIdx],
        icon: icons[cIdx]
      }
    })

    this.hourlyTemps = this.hourlyTemps.map((item: HourlyTemp, i: number) => {
      const cIdx = Math.floor(Math.random() * conditions.length)
      return {
        hour: item.hour,
        temp: this.currentTemp + Math.floor(Math.random() * 6) - 3,
        icon: icons[cIdx]
      }
    })

    this.startAnimations()
  }
}

interface ForecastItem {
  day: string
  high: number
  low: number
  condition: string
  icon: string
}

interface HourlyTemp {
  hour: string
  temp: number
  icon: string
}