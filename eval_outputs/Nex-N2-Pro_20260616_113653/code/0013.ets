@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Dialogue Button Example')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 12 })

      Text('Click the button below to open a dialogue.')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ bottom: 32 })

      Button('Show Dialogue')
        .width('70%')
        .height(48)
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor('#007DFF')
        .borderRadius(10)
        .onClick(() => {
          AlertDialog.show({
            title: 'Dialogue',
            message: 'This is a dialogue opened from an ArkTS button.',
            primaryButton: {
              value: 'OK',
              action: () => {
                console.info('OK button clicked')
              }
            },
            secondaryButton: {
              value: 'Cancel',
              action: () => {
                console.info('Cancel button clicked')
              }
            },
            autoCancel: false
          })
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(24)
    .backgroundColor('#F1F3F5')
  }
}