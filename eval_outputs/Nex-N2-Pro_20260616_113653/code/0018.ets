@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Text with Different Highlights')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .margin({ top: 60, bottom: 24 })

      Text.richText(
        '<span style="background-color:#DBEAFE;color:#1D4ED8;padding:4px 8px;border-radius:8px;">Blue highlight</span> ' +
        '<span style="background-color:#FEF3C7;color:#B45309;padding:4px 8px;border-radius:8px;">Yellow highlight</span> ' +
        '<span style="background-color:#DCFCE7;color:#166534;padding:4px 8px;border-radius:8px;">Green highlight</span> ' +
        '<span style="background-color:#FEE2E2;color:#B91C1C;padding:4px 8px;border-radius:8px;">Red highlight</span>'
      )
        .fontSize(20)
        .lineHeight(36)
        .width('90%')
        .margin({ bottom: 36 })

      Text.richText(
        'This is a sample paragraph where ' +
        '<span style="color:#7C3AED;font-weight:bold;">important words</span> can be highlighted, ' +
        '<span style="background-color:#FFE4E6;color:#BE123C;">errors can be marked</span>, ' +
        'and ' +
        '<span style="background-color:#E0F2FE;color:#0369A1;">notes can be emphasized</span> ' +
        'to make the text easier to read.'
      )
        .fontSize(18)
        .lineHeight(32)
        .width('90%')

      Divider()
        .width('90%')
        .margin({ top: 36, bottom: 28 })

      Column() {
        Row() {
          Text('Normal text ')
            .fontSize(18)
            .fontColor('#374151')
          Text('Blue')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .backgroundColor('#2563EB')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(8)
          Text(' highlight')
            .fontSize(18)
            .fontColor('#374151')
        }
        .width('90%')
        .justifyContent(FlexAlign.Start)
        .wrap(true)

        Row() {
          Text('Another ')
            .fontSize(18)
            .fontColor('#374151')
          Text('Green')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .backgroundColor('#16A34A')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(8)
          Text(' highlight')
            .fontSize(18)
            .fontColor('#374151')
        }
        .width('90%')
        .justifyContent(FlexAlign.Start)
        .wrap(true)
        .margin({ top: 18 })

        Row() {
          Text('And an ')
            .fontSize(18)
            .fontColor('#374151')
          Text('Orange')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .backgroundColor('#F97316')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(8)
          Text(' highlight')
            .fontSize(18)
            .fontColor('#374151')
        }
        .width('90%')
        .justifyContent(FlexAlign.Start)
        .wrap(true)
        .margin({ top: 18 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}