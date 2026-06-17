import { ImageFit } from '@ohos.multimedia.image';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Image Scaling: Contain vs. Cover')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })
        .textAlign(TextAlign.Center)
        .width('100%')

      Row() {
        // Contain side
        Column() {
          Text('Contain')
            .fontSize(18)
            .margin({ bottom: 8 })
          Image($r('app.media.sample_image'))
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Contain)
            .border({ width: 2, color: Color.Blue })
            .backgroundColor(Color.Gray)
        }
        .layoutWeight(1)
        .height('100%')
        .padding(8)

        // Cover side
        Column() {
          Text('Cover')
            .fontSize(18)
            .margin({ bottom: 8 })
          Image($r('app.media.sample_image'))
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
            .border({ width: 2, color: Color.Red })
            .backgroundColor(Color.Gray)
        }
        .layoutWeight(1)
        .height('100%')
        .padding(8)
      }
      .height(300)
      .width('100%')
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}