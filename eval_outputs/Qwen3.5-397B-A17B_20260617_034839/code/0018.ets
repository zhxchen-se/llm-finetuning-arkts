@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Text Highlight Examples')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })
        .fontColor('#182431')

      Text() {
        span('This is ')
        span('normal ').fontColor('#182431')
        span('highlighted ').fontColor('#FFFFFF').backgroundColor('#007DFF').padding({ left: 5, right: 5 })
        span('text with ')
        span('different ').fontColor('#FF0000').fontWeight(FontWeight.Bold)
        span('styles.')
      }
      .fontSize(18)
      .padding(20)
      .backgroundColor('#F1F3F5')
      .borderRadius(10)
      .margin({ left: 20, right: 20 })

      Text() {
        span('Background ')
        span('Highlight ').backgroundColor('#FFD700').fontColor('#000000').fontWeight(FontWeight.Medium)
        span(' Example')
      }
      .fontSize(18)
      .padding(20)
      .margin({ top: 20, left: 20, right: 20 })
      .backgroundColor('#F1F3F5')
      .borderRadius(10)

      Text() {
        span('Soft Highlight ').backgroundColor('#E8F5E9').fontColor('#2E7D32')
        span('vs ')
        span('Hard Highlight ').backgroundColor('#FFEBEE').fontColor('#C62828')
      }
      .fontSize(18)
      .padding(20)
      .margin({ top: 20, left: 20, right: 20 })
      .backgroundColor('#F1F3F5')
      .borderRadius(10)

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .padding({ top: 50 })
  }
}