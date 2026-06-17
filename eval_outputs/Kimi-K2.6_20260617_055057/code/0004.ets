@Entry
@Component
struct Index {
  private items: number[] = Array.from({ length: 24 }, (_, i) => i)

  build() {
    Column() {
      Grid() {
        ForEach(this.items, (item: number) => {
          GridItem() {
            Image($r('app.media.icon'))
              .width('100%')
              .height('100%')
              .objectFit(ImageFit.Cover)
              .borderRadius(8)
          }
          .aspectRatio(1)
        }, (item: number) => item.toString())
      }
      .columnsTemplate('1fr 1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .padding(16)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}