@Entry
@Component
struct Index {
  images: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  build() {
    Column() {
      Text('Image Grid')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Grid() {
        ForEach(this.images, (item: number, index: number) => {
          GridItem() {
            Image($r('app.media.icon'))
              .width('100%')
              .height('100%')
              .objectFit(ImageFit.Cover)
          }
          .width('100%')
          .height('100%')
          .padding(6)
        }, (item: number, index: number) => item.toString())
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .width('100%')
      .height('70%')
      .padding(12)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#F5F5F5')
  }
}