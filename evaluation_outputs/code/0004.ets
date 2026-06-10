@Entry
@Component
struct Index {
  build() {
    Grid() {
      ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (item: number) => {
        GridItem() {
          Image($r('app.media.icon'))
            .objectFit(ImageFit.Cover)
            .width('100%')
            .height('100%')
        }
      }, (item: number) => item.toString())
    }
    .columnsTemplate('1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr')
    .columnsGap(10)
    .rowsGap(10)
    .width('100%')
    .height('100%')
    .padding(10)
  }
}