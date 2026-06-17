@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Image Scaling Comparison')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Row() {
        this.ScalingCard('Contain', ImageFit.Contain, 'Whole image is visible. Extra space may appear.')
        this.ScalingCard('Cover', ImageFit.Cover, 'Area is fully filled. Image may be cropped.')
      }
      .width('100%')
      .height(380)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
  }

  @Builder ScalingCard(title: string, fitMode: ImageFit, description: string) {
    Column() {
      Text(title)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .margin({ bottom: 12 })

      Image($r('app.media.app_icon'))
        .width(180)
        .height(260)
        .objectFit(fitMode)
        .borderRadius(16)
        .backgroundColor('#111827')

      Text(description)
        .fontSize(14)
        .fontColor('#4b5563')
        .textAlign(TextAlign.Center)
        .margin({ top: 12 })
    }
    .width('42%')
    .height(360)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(16)
    .borderRadius(20)
    .backgroundColor('#f3f4f6')
  }
}