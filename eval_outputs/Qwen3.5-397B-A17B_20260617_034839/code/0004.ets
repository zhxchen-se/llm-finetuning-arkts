@Entry
@Component
struct Index {
  @State imageList: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  build() {
    Column() {
      Grid() {
        ForEach(this.imageList, (item: number) => {
          GridItem() {
            Image($r('app.media.icon'))
              .width(100)
              .height(100)
              .objectFit(ImageFit.Cover)
          }
        }, (item: number) => item.toString())
      }
      .columnsCount(3)
      .rowsGap(10)
      .columnsGap(10)
      .padding(10)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}