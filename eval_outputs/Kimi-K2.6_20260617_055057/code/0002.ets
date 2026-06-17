@Entry
@Component
struct Index {
  private dataList: string[] = Array.from({ length: 100 }, (_, i) => `List Item ${i + 1}`);

  build() {
    Column() {
      Text('Scrollable List Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })
        .textAlign(TextAlign.Center)
        .width('100%')

      List({ space: 12 }) {
        ForEach(this.dataList, (item: string, index: number) => {
          ListItem() {
            Row() {
              Text(`${index + 1}`)
                .fontSize(14)
                .fontColor('#666666')
                .width(40)
                .textAlign(TextAlign.Center)

              Text(item)
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)
            }
            .width('100%')
            .height(60)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#f5f5f5')
            .borderRadius(8)
          }
        }, (item: string, index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 16 })
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffffff')
  }
}