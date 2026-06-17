@Entry
@Component
struct Index {
  @State itemList: number[] = Array.from({ length: 50 }, (_, i) => i + 1);

  build() {
    Column() {
      Text('Vertical Scrolling List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })
        .width('100%')
        .textAlign(TextAlign.Center)

      // The List component inherently provides vertical scrolling when its content exceeds its height
      List({ space: 12 }) {
        ForEach(this.itemList, (item: number) => {
          ListItem() {
            Text(`List Item ${item}`)
              .width('100%')
              .height(80)
              .fontSize(20)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .backgroundColor('#007DFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#888888', offsetY: 2 })
          }
        }, (item: number) => item.toString())
      }
      .width('100%')
      .layoutWeight(1) // Takes remaining vertical space
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .scrollBar(BarState.Auto) // Shows scrollbar when scrolling
      .edgeEffect(EdgeEffect.Spring) // Adds a spring bounce effect at the edges
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}