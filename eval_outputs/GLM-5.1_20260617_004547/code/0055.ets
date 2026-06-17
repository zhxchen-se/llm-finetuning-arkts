import { font } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  aboutToAppear() {
    font.registerFont({
      familyName: 'CustomRoboto',
      familySrc: $rawfile('Roboto-Regular.ttf')
    })
    font.registerFont({
      familyName: 'CustomRobotoBold',
      familySrc: $rawfile('Roboto-Bold.ttf')
    })
    font.registerFont({
      familyName: 'CustomRobotoItalic',
      familySrc: $rawfile('Roboto-Italic.ttf')
    })
    font.registerFont({
      familyName: 'CustomRobotoBoldItalic',
      familySrc: $rawfile('Roboto-BoldItalic.ttf')
    })
  }

  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Custom Font Registration & Styles')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 20, bottom: 10 })

        Text('This section demonstrates text rendered using registered custom fonts. Ensure the corresponding .ttf files are placed in the resources/rawfile directory.')
          .fontSize(14)
          .fontColor('#666666')
          .width('100%')
          .margin({ bottom: 10 })

        Divider().color('#EEEEEE')

        Text('Custom Font - Regular')
          .fontFamily('CustomRoboto')
          .fontSize(22)
          .width('100%')

        Text('Custom Font - Bold (Using dedicated bold font file)')
          .fontFamily('CustomRobotoBold')
          .fontSize(22)
          .width('100%')

        Text('Custom Font - Italic (Using dedicated italic font file)')
          .fontFamily('CustomRobotoItalic')
          .fontSize(22)
          .width('100%')

        Text('Custom Font - Bold Italic (Using dedicated bold italic font file)')
          .fontFamily('CustomRobotoBoldItalic')
          .fontSize(22)
          .width('100%')

        Divider().color('#EEEEEE').margin({ top: 10, bottom: 10 })

        Text('Applying Styles via Attributes')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 5 })

        Text('Custom Font - Regular with FontWeight.Bold attribute')
          .fontFamily('CustomRoboto')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Text('Custom Font - Regular with FontStyle.Italic attribute')
          .fontFamily('CustomRoboto')
          .fontSize(22)
          .fontStyle(FontStyle.Italic)
          .width('100%')

        Text('Custom Font - Regular with Bold and Italic attributes')
          .fontFamily('CustomRoboto')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .width('100%')

        Divider().color('#EEEEEE').margin({ top: 10, bottom: 10 })

        Text('System Font Comparison')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 5 })

        Text('System Font - Regular')
          .fontSize(22)
          .width('100%')

        Text('System Font - Bold')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Text('System Font - Italic')
          .fontSize(22)
          .fontStyle(FontStyle.Italic)
          .width('100%')

      }
      .width('100%')
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}