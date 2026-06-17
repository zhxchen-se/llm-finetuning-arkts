@Entry
@Component
struct Index {
  @State activeIndex: number = 0

  private tabs: Array<{
    label: string
    icon: string
    color: string
    glow: string
    bgStart: string
    bgEnd: string
  }> = [
    {
      label: 'Home',
      icon: '⌂',
      color: '#4F8DFF',
      glow: '#4F8DFF',
      bgStart: '#EAF2FF',
      bgEnd: '#FFFFFF'
    },
    {
      label: 'Explore',
      icon: '✦',
      color: '#8B5CF6',
      glow: '#8B5CF6',
      bgStart: '#F4ECFF',
      bgEnd: '#FFFFFF'
    },
    {
      label: 'Stats',
      icon: '▥',
      color: '#10B981',
      glow: '#10B981',
      bgStart: '#EAFBF5',
      bgEnd: '#FFFFFF'
    },
    {
      label: 'Profile',
      icon: '●',
      color: '#F97316',
      glow: '#F97316',
      bgStart: '#FFF4E8',
      bgEnd: '#FFFFFF'
    }
  ]

  build() {
    Column() {
      Stack() {
        Column() {
          Text(this.tabs[this.activeIndex].label)
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tabs[this.activeIndex].color)
            .margin({ top: 52, bottom: 16 })

          Text('Content updated for ' + this.tabs[this.activeIndex].label)
            .fontSize(18)
            .fontColor('#334155')
            .margin({ bottom: 18 })

          Text(this.tabs[this.activeIndex].icon)
            .fontSize(72)
            .fontColor(this.tabs[this.activeIndex].color)
            .width(120)
            .height(120)
            .textAlign(TextAlign.Center)
            .backgroundColor('#FFFFFF')
            .borderRadius(32)
            .shadow({
              radius: 18,
              color: '#10182818',
              offsetX: 0,
              offsetY: 10
            })

          Column() {
            Text('Active Tab')
              .fontSize(14)
              .fontColor('#64748B')
              .margin({ bottom: 8 })

            Text(this.tabs[this.activeIndex].label)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.tabs[this.activeIndex].color)
          }
          .padding(24)
          .width('90%')
          .borderRadius(24)
          .backgroundColor('#FFFFFF')
          .shadow({
            radius: 20,
            color: '#10182812',
            offsetX: 0,
            offsetY: 12
          })
          .margin({ top: 36 })
        }
        .width('100%')
        .height('100%')
        .alignContent(VerticalAlign.Top)
        .padding({ left: 24, right: 24, top: 24, bottom: 110 })
        .background(
          LinearGradient({
            angle: 135,
            colors: [[this.tabs[this.activeIndex].bgStart, 0], [this.tabs[this.activeIndex].bgEnd, 1]]
          })
        )
      }

      Row() {
        ForEach(this.tabs, (item, index) => {
          this.TabButton(item, index)
        }, (item) => item.label)
      }
      .width('100%')
      .height(92)
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ left: 12, right: 12, top: 14, bottom: 18 })
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 28, topRight: 28 })
      .shadow({
        radius: 24,
        color: '#10182822',
        offsetX: 0,
        offsetY: -8
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  TabButton(item: {
    label: string
    icon: string
    color: string
    glow: string
  }, index: number) {
    Button() {
      Stack() {
        Circle()
          .width(58)
          .height(58)
          .fill(item.glow)
          .opacity(this.activeIndex === index ? 0.32 : 0)
          .blur(16)
          .animation({
            duration: 260,
            curve: Curve.Ease
          })

        Circle()
          .width(this.activeIndex === index ? 54 : 46)
          .height(this.activeIndex === index ? 54 : 46)
          .fill(this.activeIndex === index ? item.color : '#F1F5F9')
          .shadow(this.activeIndex === index ? {
            radius: 18,
            color: item.glow + '66',
            offsetX: 0,
            offsetY: 8
          } : {
            radius: 8,
            color: '#1018280A',
            offsetX: 0,
            offsetY: 4
          })
          .animation({
            duration: 260,
            curve: Curve.Ease
          })

        Text(item.icon)
          .fontSize(this.activeIndex === index ? 24 : 21)
          .fontColor(this.activeIndex === index ? '#FFFFFF' : '#64748B')
          .fontWeight(FontWeight.Bold)
      }
      .width(64)
      .height(64)
    }
    .width(68)
    .height(68)
    .backgroundColor(Color.Transparent)
    .borderRadius(34)
    .onClick(() => {
      this.activeIndex = index
    })

    Column() {
      Text(item.label)
        .fontSize(this.activeIndex === index ? 13 : 12)
        .fontColor(this.activeIndex === index ? item.color : '#94A3B8')
        .fontWeight(this.activeIndex === index ? FontWeight.Bold : FontWeight.Normal)
        .margin({ top: 4 })
    }
    .width(72)
    .height(68)
    .justifyContent(FlexAlign.End)
  }
}