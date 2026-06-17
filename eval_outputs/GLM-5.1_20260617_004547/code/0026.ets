class SwiperItem {
  id: number = 0
  title: string = ''
  description: string = ''
  bgColor: string = '#FFFFFF'

  constructor(id: number, title: string, description: string, bgColor: string) {
    this.id = id
    this.title = title
    this.description = description
    this.bgColor = bgColor
  }
}

@Entry
@Component
struct Index {
  @State swiperList: SwiperItem[] = [
    new SwiperItem(1, 'Spring', 'Season of flowers', '#FF9800'),
    new SwiperItem(2, 'Summer', 'Season of sunshine', '#03A9F4'),
    new SwiperItem(3, 'Autumn', 'Season of harvest', '#8BC34A'),
    new SwiperItem(4, 'Winter', 'Season of snow', '#607D8B')
  ]
  @State currentIndex: number = 0

  build() {
    Column({ space: 20 }) {
      Text('Swiper Component Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20 })

      Swiper() {
        ForEach(this.swiperList, (item: SwiperItem) => {
          Column({ space: 10 }) {
            Text(item.title)
              .fontSize(28)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)

            Text(item.description)
              .fontSize(16)
              .fontColor(Color.White)
              .opacity(0.8)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .backgroundColor(item.bgColor)
          .borderRadius(16)
        }, (item: SwiperItem) => item.id.toString())
      }
      .index(this.currentIndex)
      .autoPlay(true)
      .interval(3000)
      .indicator(true)
      .loop(true)
      .duration(1000)
      .itemSpace(10)
      .curve(Curve.EaseInOut)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width('90%')
      .height(300)
      .margin({ top: 20 })

      Text(`Current Page: ${this.currentIndex + 1}`)
        .fontSize(18)
        .margin({ top: 10 })

      Row({ space: 15 }) {
        Button('Previous')
          .onClick(() => {
            if (this.currentIndex > 0) {
              this.currentIndex -= 1
            } else {
              this.currentIndex = this.swiperList.length - 1
            }
          })
          .width('40%')

        Button('Next')
          .onClick(() => {
            if (this.currentIndex < this.swiperList.length - 1) {
              this.currentIndex += 1
            } else {
              this.currentIndex = 0
            }
          })
          .width('40%')
      }
      .width('90%')
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }
}