interface TabItem {
  name: string
  icon: string
  title: string
  description: string
  color: string
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0

  tabs: TabItem[] = [
    {
      name: 'Home',
      icon: '⌂',
      title: 'Home',
      description: 'Swipe horizontally or tap a tab below to move between content areas.',
      color: '#2563EB'
    },
    {
      name: 'Explore',
      icon: '⌕',
      title: 'Explore',
      description: 'The selected tab uses its own background color inside the capsule bar.',
      color: '#7C3AED'
    },
    {
      name: 'Messages',
      icon: '✉',
      title: 'Messages',
      description: 'Swiping the content updates the active tab automatically.',
      color: '#059669'
    },
    {
      name: 'Profile',
      icon: '☺',
      title: 'Profile',
      description: 'Tapping a tab animates the Swiper to the matching page.',
      color: '#EA580C'
    }
  ]

  build() {
    Column() {
      Text('Capsule Tab Bar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .margin({ bottom: 6 })

      Text('Tap a tab or swipe the content area')
        .fontSize(14)
        .fontColor('#64748B')
        .margin({ bottom: 16 })

      Swiper() {
        ForEach(this.tabs, (tab: TabItem, index: number) => {
          this.ContentArea(tab, index)
        }, (tab: TabItem) => tab.name)
      }
        .index(this.currentIndex)
        .onChange((index: number) => {
          this.currentIndex = index
        })
        .layoutWeight(1)
        .width('100%')
        .margin({ bottom: 12 })

      this.TabBar()
    }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 24, bottom: 12 })
      .backgroundColor('#F8FAFC')
  }

  @Builder
  TabBar() {
    Column() {
      Spacer()

      Row() {
        ForEach(this.tabs, (tab: TabItem, index: number) => {
          this.TabButton(tab, index)
        }, (tab: TabItem) => tab.name)
      }
        .width('100%')
        .height(54)
        .padding({ left: 6, right: 6 })
        .backgroundColor('#E2E8F0')
        .borderRadius(30)
    }
      .width('100%')
      .height(74)
  }

  @Builder
  TabButton(tab: TabItem, index: number) {
    const selected: boolean = this.currentIndex === index

    Button() {
      Column() {
        Text(tab.icon)
          .fontSize(22)
          .margin({ bottom: 2 })
          .fontColor(selected ? '#FFFFFF' : '#64748B')

        Text(tab.name)
          .fontSize(12)
          .fontWeight(selected ? FontWeight.Bold : FontWeight.Normal)
          .fontColor(selected ? '#FFFFFF' : '#64748B')
      }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
    }
      .layoutWeight(1)
      .height(52)
      .borderRadius(26)
      .backgroundColor(selected ? tab.color : '#FFFFFF')
      .shadow(selected
        ? { radius: 10, color: '#20000000', offsetX: 0, offsetY: 6 }
        : { radius: 0, color: '#00000000', offsetX: 0, offsetY: 0 })
      .onClick(() => {
        this.currentIndex = index
      })
  }

  @Builder
  ContentArea(tab: TabItem, index: number) {
    Column() {
      Column() {
        Text(tab.icon)
          .fontSize(56)
          .fontColor(tab.color)
          .margin({ bottom: 14 })

        Text(tab.title)
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .margin({ bottom: 8 })

        Text(tab.description)
          .fontSize(15)
          .fontColor('#64748B')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 8, bottom: 22 })
      }
        .width('100%')
        .padding(24)
        .borderRadius(28)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 18, color: '#10000000', offsetX: 0, offsetY: 10 })

      Row() {
        Text('Page ' + (index + 1))
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(tab.color)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .borderRadius(16)
          .backgroundColor('#F1F5F9')
      }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 12 })
    }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding(8)
  }
}