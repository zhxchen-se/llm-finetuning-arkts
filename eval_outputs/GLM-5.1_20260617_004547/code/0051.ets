import router from '@ohos.router'

@Entry
@Component
struct Index {
  build() {
    Column() {
      // Title
      Text('VerticalAlign Comparison')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1a1a2e')
        .margin({ top: 30, bottom: 8 })

      Text('Observe how child elements align vertically within each container')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ bottom: 24 })

      // Three containers side by side
      Row({ space: 16 }) {

        // Container 1: VerticalAlign.Top
        Column() {
          Text('VerticalAlign.Top')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#ffffff')
            .padding(6)
            .borderRadius(6)
            .backgroundColor('#e94560')
            .margin({ bottom: 12 })

          this.ChildElements('#e94560')

          Text('Top')
            .fontSize(13)
            .fontColor('#e94560')
            .fontWeight(FontWeight.Medium)
            .margin({ top: 12 })
        }
        .width('30%')
        .height(420)
        .verticalAlign(VerticalAlign.Top)
        .padding(16)
        .borderRadius(16)
        .backgroundColor('#fff5f5')
        .border({ width: 2, color: '#e94560', radius: 16 })

        // Container 2: VerticalAlign.Center
        Column() {
          Text('VerticalAlign.Center')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#ffffff')
            .padding(6)
            .borderRadius(6)
            .backgroundColor('#0f3460')
            .margin({ bottom: 12 })

          this.ChildElements('#0f3460')

          Text('Center')
            .fontSize(13)
            .fontColor('#0f3460')
            .fontWeight(FontWeight.Medium)
            .margin({ top: 12 })
        }
        .width('30%')
        .height(420)
        .verticalAlign(VerticalAlign.Center)
        .padding(16)
        .borderRadius(16)
        .backgroundColor('#f0f4ff')
        .border({ width: 2, color: '#0f3460', radius: 16 })

        // Container 3: VerticalAlign.Bottom
        Column() {
          Text('VerticalAlign.Bottom')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#ffffff')
            .padding(6)
            .borderRadius(6)
            .backgroundColor('#1a936f')
            .margin({ bottom: 12 })

          this.ChildElements('#1a936f')

          Text('Bottom')
            .fontSize(13)
            .fontColor('#1a936f')
            .fontWeight(FontWeight.Medium)
            .margin({ top: 12 })
        }
        .width('30%')
        .height(420)
        .verticalAlign(VerticalAlign.Bottom)
        .padding(16)
        .borderRadius(16)
        .backgroundColor('#f0fff4')
        .border({ width: 2, color: '#1a936f', radius: 16 })

      }
      .width('100%')
      .padding({ left: 16, right: 16 })

      // Description section
      Column() {
        Text('How it works')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1a1a2e')
          .margin({ bottom: 12 })

        this.DescriptionItem('VerticalAlign.Top', 'Children are aligned to the top of the container. Extra space appears below.', '#e94560')
        this.DescriptionItem('VerticalAlign.Center', 'Children are centered vertically. Extra space is split above and below.', '#0f3460')
        this.DescriptionItem('VerticalAlign.Bottom', 'Children are aligned to the bottom of the container. Extra space appears above.', '#1a936f')
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 24, bottom: 30 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5fa')
  }

  @Builder
  ChildElements(accentColor: string) {
    // Icon-like box
    Row() {
      Text('★')
        .fontSize(28)
        .fontColor(accentColor)
    }
    .width(56)
    .height(56)
    .borderRadius(12)
    .backgroundColor('#ffffff')
    .justifyContent(FlexAlign.Center)
    .shadow({ radius: 4, color: '#22000000', offsetY: 2 })
    .margin({ bottom: 10 })

    // Text block
    Column() {
      Text('Item A')
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
      Text('Item B')
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
      Text('Item C')
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
    }
    .padding(12)
    .borderRadius(10)
    .backgroundColor('#ffffff')
    .shadow({ radius: 3, color: '#22000000', offsetY: 1 })
    .margin({ bottom: 10 })

    // Small indicator
    Row() {
      Circle()
        .width(10)
        .height(10)
        .fill(accentColor)
      Text('Active')
        .fontSize(12)
        .fontColor('#888888')
        .margin({ left: 6 })
    }
    .padding({ left: 10, right: 10, top: 6, bottom: 6 })
    .borderRadius(8)
    .backgroundColor('#ffffff')
    .shadow({ radius: 2, color: '#22000000', offsetY: 1 })
  }

  @Builder
  DescriptionItem(title: string, desc: string, color: string) {
    Row() {
      Column() {
        Circle()
          .width(10)
          .height(10)
          .fill(color)
      }
      .width(20)
      .margin({ right: 10 })

      Column() {
        Text(title)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor(color)
        Text(desc)
          .fontSize(13)
          .fontColor('#555555')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .margin({ bottom: 10 })
  }
}