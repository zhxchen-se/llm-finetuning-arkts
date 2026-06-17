@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column() {
        Text('Image inside a Frame')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0f172a')
          .width('86%')

        Text('The Frame sets the outer size. The Image is sized to the Frame and centered.')
          .fontSize(15)
          .fontColor('#475569')
          .width('86%')
          .margin({ top: 8, bottom: 28 })

        Text('Contain mode: the whole image stays visible')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0f172a')
          .width('86%')
          .margin({ bottom: 10 })

        Frame() {
          Image($r('app.media.icon'))
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Contain)
        }
        .width('86%')
        .aspectRatio(1.5)
        .align(Alignment.Center)
        .backgroundColor('#e2e8f0')
        .borderRadius(20)
        .border({ width: 1, color: '#cbd5e1' })
        .clip(true)

        Text('Frame: width("86%"), aspectRatio(1.5), align(Alignment.Center)')
          .fontSize(14)
          .fontColor('#334155')
          .width('86%')
          .margin({ top: 12, bottom: 4 })

        Text('Image: width("100%"), height("100%"), objectFit(ImageFit.Contain)')
          .fontSize(14)
          .fontColor('#334155')
          .width('86%')

        Divider()
          .width('86%')
          .margin({ top: 24, bottom: 24 })

        Text('Cover mode: the image fills the frame')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0f172a')
          .width('86%')
          .margin({ bottom: 10 })

        Frame() {
          Image($r('app.media.icon'))
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
        }
        .width('86%')
        .aspectRatio(1.5)
        .align(Alignment.Center)
        .backgroundColor('#e2e8f0')
        .borderRadius(20)
        .border({ width: 1, color: '#cbd5e1' })
        .clip(true)

        Text('Frame: fixed outer area, child aligned to center')
          .fontSize(14)
          .fontColor('#334155')
          .width('86%')
          .margin({ top: 12, bottom: 4 })

        Text('Image: width("100%"), height("100%"), objectFit(ImageFit.Cover)')
          .fontSize(14)
          .fontColor('#334155')
          .width('86%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f8fafc')
  }
}