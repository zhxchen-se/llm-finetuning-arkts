@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column() {
        Text('Text with Different Fonts')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ bottom: 24 })

        Text('Serif Font\nThe quick brown fox jumps over the lazy dog.')
          .fontFamily('serif')
          .fontSize(28)
          .fontColor('#1F2937')
          .margin({ bottom: 20 })

        Text('Sans-Serif Font\nThe quick brown fox jumps over the lazy dog.')
          .fontFamily('sans-serif')
          .fontSize(28)
          .fontColor('#1F2937')
          .margin({ bottom: 20 })

        Text('Monospace Font\nThe quick brown fox jumps over the lazy dog.')
          .fontFamily('monospace')
          .fontSize(28)
          .fontColor('#1F2937')
          .margin({ bottom: 20 })

        Text('Cursive Font\nThe quick brown fox jumps over the lazy dog.')
          .fontFamily('cursive')
          .fontSize(28)
          .fontColor('#1F2937')
          .margin({ bottom: 20 })

        Text('Fantasy Font\nThe quick brown fox jumps over the lazy dog.')
          .fontFamily('fantasy')
          .fontSize(28)
          .fontColor('#1F2937')
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}