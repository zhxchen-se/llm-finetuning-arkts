import { ImageFit } from '@ohos/arkui';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Image Scaling Comparison')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 30 })

      Row() {
        Column() {
          Image('https://picsum.photos/200/300')
            .width(200)
            .height(200)
            .objectFit(ImageFit.Contain)
            .borderRadius(10)
            .border({ width: 2, color: '#007DFF' })
          
          Text('Contain')
            .fontSize(16)
            .margin({ top: 10 })
        }
        .alignItems(HorizontalAlign.Center)

        Column() {
          Image('https://picsum.photos/200/300')
            .width(200)
            .height(200)
            .objectFit(ImageFit.Cover)
            .borderRadius(10)
            .border({ width: 2, color: '#007DFF' })
          
          Text('Cover')
            .fontSize(16)
            .margin({ top: 10 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .space(50)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}