@Entry
@Component
struct Index {
  @State items: number[] = Array.from({ length: 20 }, (_, i) => i + 1);

  build() {
    Column({ space: 20 }) {
      Text('Horizontal Scroll List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20 })

      List({ space: 15 }) {
        ForEach(this.items, (item: number) => {
          ListItem() {
            Text(`${item}`)
              .width(120)
              .height(120)
              .fontSize(24)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .backgroundColor('#007DFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#40007DFF', offsetY: 2 })
          }
        }, (item: number) => item.toString())
      }
      .listDirection(Axis.Horizontal)
      .width('100%')
      .height(180)
      .padding({ left: 20, right: 20 })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}