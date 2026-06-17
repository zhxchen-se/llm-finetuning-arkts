@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Default Font (HarmonyOS Sans)')
          .fontSize(22)
          .fontColor(Color.Black)

        Text('Serif Font (HarmonyOS Sans Serif)')
          .fontSize(22)
          .fontFamily('HarmonyOS Sans Serif')
          .fontColor(Color.DarkGray)

        Text('Condensed Font (HarmonyOS Sans Condensed)')
          .fontSize(22)
          .fontFamily('HarmonyOS Sans Condensed')
          .fontColor(Color.DarkGray)

        Text('Monospace Font')
          .fontSize(22)
          .fontFamily('monospace')
          .fontColor(Color.DarkGray)

        Text('Generic Sans-Serif')
          .fontSize(22)
          .fontFamily('sans-serif')
          .fontColor(Color.Gray)

        Text('Generic Serif')
          .fontSize(22)
          .fontFamily('serif')
          .fontColor(Color.Gray)

        Divider().margin({ top: 10, bottom: 10 })

        Text('Bold Weight')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)

        Text('Lighter Weight')
          .fontSize(22)
          .fontWeight(FontWeight.Lighter)

        Text('Italic Style')
          .fontSize(22)
          .fontStyle(FontStyle.Italic)

        Text('Combined: Serif + Bold + Italic')
          .fontSize(22)
          .fontFamily('serif')
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .fontColor('#007DFF')
      }
      .width('100%')
      .padding(20)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}