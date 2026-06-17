@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  private items: number[] = Array.from({ length: 80 }, (_item: number, index: number) => index + 1);

  build() {
    Column() {
      Text('Long List with Vertical Scrolling')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#182431')
        .padding({ top: 16, bottom: 12 })

      Button('Scroll to Bottom')
        .fontSize(16)
        .padding(10)
        .margin({ bottom: 12 })
        .onClick(() => {
          this.scroller.scrollTo({ x: 0, y: 100000 });
        })

      Scroll(this.scroller) {
        Column() {
          ForEach(this.items, (item: number) => {
            Text(`Element ${item}`)
              .width('100%')
              .height(64)
              .fontSize(18)
              .fontColor('#182431')
              .padding(16)
              .backgroundColor(item % 2 === 0 ? '#F1F3F5' : '#FFFFFF')
          }, (item: number) => item.toString())

          Text('You reached the bottom of the list.')
            .width('100%')
            .height(80)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E7D32')
            .textAlign(TextAlign.Center)
            .padding(16)
            .backgroundColor('#E8F5E9')
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.On)
    }
    .width('100%')
    .height('100%')
    .padding(12)
    .backgroundColor('#FAFAFA')
  }
}