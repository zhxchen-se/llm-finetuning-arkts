@Entry
@Component
struct Index {
  @State selectedIndex: number = 0
  @State iconScale: number = 1
  @State tempPulse: number = 1
  @State isRefreshing: boolean = false

  private currentWeather: WeatherInfo = {
    city: "San Francisco",
    temperature: 22,
    condition: "Sunny",
    icon: "☀️",
    humidity: 58,
    wind: 12,
    feelsLike: 24
  }

  private forecast: WeatherForecast[] = [
    { day: "Mon", icon: "☀️", condition: "Sunny", high: 24, low: 16, rain: 5 },
    { day: "Tue", icon: "🌤️", condition: "Partly Cloudy", high: 23, low: 15, rain: 12 },
    { day: "Wed", icon: "☁️", condition: "Cloudy", high: 20, low: 14, rain: 30 },
    { day: "Thu", icon: "🌧️", condition: "Rain", high: 18, low: 13, rain: 70 },
    { day: "Fri", icon: "⛅", condition: "Clearing", high: 21, low: 14, rain: 18 }
  ]

  aboutToAppear() {
    animateTo({ duration: 1600, curve: Curve.EaseInOut, iterations: -1 }, () => {
      this.iconScale = 1.18
    })

    animateTo({ duration: 1000, curve: Curve.EaseInOut, iterations: -1 }, () => {
      this.tempPulse = 1.08
    })
  }

  refreshWeather() {
    if (this.isRefreshing) {
      return
    }

    this.isRefreshing = true

    animateTo({ duration: 500, curve: Curve.EaseOut }, () => {
      this.tempPulse = 1.25
    })

    setTimeout(() => {
      this.currentWeather = {
        city: "San Francisco",
        temperature: 23,
        condition: "Mostly Sunny",
        icon: "🌤️",
        humidity: 55,
        wind: 10,
        feelsLike: 25
      }

      this.forecast = [
        { day: "Mon", icon: "🌤️", condition: "Mostly Sunny", high: 25, low: 16, rain: 4 },
        { day: "Tue", icon: "☀️", condition: "Sunny", high: 26, low: 17, rain: 3 },
        { day: "Wed", icon: "⛅", condition: "Partly Cloudy", high: 22, low: 15, rain: 20 },
        { day: "Thu", icon: "🌧️", condition: "Showers", high: 19, low: 13, rain: 65 },
        { day: "Fri", icon: "☁️", condition: "Cloudy", high: 20, low: 14, rain: 35 }
      ]

      this.isRefreshing = false
      this.tempPulse = 1
    }, 900)
  }

  build() {
    Scroll() {
      Column() {
        this.HeaderView()
        this.CurrentWeatherView()
        this.DetailView()
        this.ForecastView()
      }
      .width("100%")
      .padding({ left: 24, right: 24, top: 16, bottom: 32 })
    }
    .width("100%")
    .height("100%")
    .scrollBar(BarState.Off)
    .backgroundColor("#E8F4FF")
  }

  @Builder HeaderView() {
    Row() {
      Column() {
        Text("Weather")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor("#17324D")

        Text(this.currentWeather.city)
          .fontSize(16)
          .fontColor("#5A7189")
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Row() {
          Text(this.isRefreshing ? "Updating..." : "Refresh")
            .fontSize(14)
            .fontColor(Color.White)
        }
        .width("100%")
        .height("100%")
        .justifyContent(FlexAlign.Center)
      }
      .width(108)
      .height(42)
      .borderRadius(21)
      .backgroundColor("#3B82F6")
      .onClick(() => {
        this.refreshWeather()
      })
    }
    .width("100%")
  }

  @Builder CurrentWeatherView() {
    Column() {
      Row() {
        Column() {
          Text(this.currentWeather.icon)
            .fontSize(76)
            .scale({ x: this.iconScale, y: this.iconScale })
            .animation({ duration: 1200, curve: Curve.EaseInOut })
        }
        .width(120)
        .height(120)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .borderRadius(36)
        .backgroundColor("rgba(255,255,255,0.42)")
        .shadow({ radius: 18, color: "rgba(59,130,246,0.18)", offsetX: 0, offsetY: 12 })

        Column() {
          Text(`${this.currentWeather.temperature}°`)
            .fontSize(72)
            .fontWeight(FontWeight.Bold)
            .fontColor("#12314F")
            .scale({ x: this.tempPulse, y: this.tempPulse })
            .animation({ duration: 900, curve: Curve.EaseInOut })

          Text(this.currentWeather.condition)
            .fontSize(22)
            .fontColor("#4A647D")
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: 10 })
      }
      .width("100%")
      .padding(24)
      .borderRadius(32)
      .backgroundColor("#FFFFFF")
      .shadow({ radius: 24, color: "rgba(59,130,246,0.16)", offsetX: 0, offsetY: 18 })
    }
    .width("100%")
    .margin({ top: 18 })
  }

  @Builder DetailView() {
    Row() {
      this.DetailCard("💧", "Humidity", `${this.currentWeather.humidity}%`)
      this.DetailCard("🌬️", "Wind", `${this.currentWeather.wind} km/h`)
      this.DetailCard("🌡️", "Feels Like", `${this.currentWeather.feelsLike}°`)
    }
    .width("100%")
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ top: 18 })
  }

  @Builder DetailCard(icon: string, label: string, value: string) {
    Column() {
      Text(icon)
        .fontSize(28)

      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor("#17324D")
        .margin({ top: 8 })

      Text(label)
        .fontSize(13)
        .fontColor("#6B8299")
        .margin({ top: 4 })
    }
    .width("31%")
    .padding(16)
    .borderRadius(22)
    .backgroundColor("#FFFFFF")
    .shadow({ radius: 14, color: "rgba(59,130,246,0.10)", offsetX: 0, offsetY: 8 })
  }

  @Builder ForecastView() {
    Column() {
      Row() {
        Text("5-Day Forecast")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor("#17324D")
      }
      .width("100%")
      .margin({ top: 24, bottom: 14 })

      ForEach(this.forecast, (item: WeatherForecast, index: number) => {
        this.ForecastCard(item, index)
      }, (item: WeatherForecast, index: number) => `${item.day}_${index}`)
    }
    .width("100%")
  }

  @Builder ForecastCard(item: WeatherForecast, index: number) {
    Row() {
      Column() {
        Text(item.day)
          .fontSize(16)
          .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Medium)
          .fontColor(this.selectedIndex === index ? "#2563EB" : "#4A647D")

        Text(item.condition)
          .fontSize(12)
          .fontColor("#6B8299")
          .margin({ top: 4 })
      }
      .width("26%")
      .alignItems(HorizontalAlign.Start)

      Text(item.icon)
        .fontSize(30)
        .scale({ x: this.selectedIndex === index ? 1.15 : 1, y: this.selectedIndex === index ? 1.15 : 1 })
        .animation({ duration: 300, curve: Curve.EaseOut })

      Column() {
        Text(`${item.high}°`)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor("#17324D")

        Text(`${item.low}°`)
          .fontSize(14)
          .fontColor("#7A90A6")
          .margin({ top: 2 })
      }
      .width("24%")
      .alignItems(HorizontalAlign.End)

      Row() {
        Text("💧")
          .fontSize(16)
        Text(`${item.rain}%`)
          .fontSize(13)
          .fontColor("#4B7CB8")
          .margin({ left: 4 })
      }
      .width("24%")
      .justifyContent(FlexAlign.End)
    }
    .width("100%")
    .padding(16)
    .margin({ bottom: 10 })
    .borderRadius(24)
    .backgroundColor(this.selectedIndex === index ? "#EAF4FF" : "#FFFFFF")
    .shadow({ radius: 14, color: "rgba(59,130,246,0.10)", offsetX: 0, offsetY: 8 })
    .onClick(() => {
      this.selectedIndex = index
    })
  }
}

interface WeatherInfo {
  city: string
  temperature: number
  condition: string
  icon: string
  humidity: number
  wind: number
  feelsLike: number
}

interface WeatherForecast {
  day: string
  icon: string
  condition: string
  high: number
  low: number
  rain: number
}