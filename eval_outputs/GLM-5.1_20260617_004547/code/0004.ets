import { $r } from '@ohos.arkui.UIContext'

@Entry
@Component
struct Index {
  @State imageList: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  build() {
    Column() {
      Text('Image Grid')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      Grid() {
        ForEach(this.imageList, (item: number) => {
          GridItem() {
            Image($r('app.media.icon'))
              .width('100%')
              .height('100%')
              .objectFit(ImageFit.Cover)
              .borderRadius(8)
          }
          .width('100%')
          .aspectRatio(1)
          .padding(4)
        }, (item: number) => item.toString())
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
      .width('90%')
      .height(450)
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }
}