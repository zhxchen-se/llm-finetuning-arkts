import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Different Fonts in ArkTS')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontFamily('HarmonyOS Sans')
        .margin({ bottom: 20 })
        .textAlign(TextAlign.Center)

      Text('Sans-serif (default)')
        .fontSize(24)
        .fontFamily('sans-serif')
        .margin({ bottom: 10 })

      Text('Serif')
        .fontSize(24)
        .fontFamily('serif')
        .margin({ bottom: 10 })

      Text('Monospace')
        .fontSize(24)
        .fontFamily('monospace')
        .margin({ bottom: 10 })

      Text('HarmonyOS Sans')
        .fontSize(24)
        .fontFamily('HarmonyOS Sans')
        .margin({ bottom: 10 })

      Text('HarmonyOS Sans SC')
        .fontSize(24)
        .fontFamily('HarmonyOS Sans SC')
        .margin({ bottom: 10 })

      Text('Cursive (if available)')
        .fontSize(24)
        .fontFamily('cursive')
        .margin({ bottom: 10 })

      Text('Bold & Italic')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontStyle(FontStyle.Italic)
        .fontFamily('serif')
        .margin({ bottom: 10 })

      Text('Light weight')
        .fontSize(24)
        .fontWeight(FontWeight.Lighter)
        .fontFamily('sans-serif')
        .margin({ bottom: 10 })

      Text('Custom size & color')
        .fontSize(30)
        .fontColor('#FF5733')
        .fontFamily('monospace')
        .margin({ bottom: 10 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}