@Entry
@Component
struct Index {
  build() {
    Column() {
      Button('Show Dialog')
        .width(200)
        .height(50)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(Color.Blue)
        .onClick(() => {
          AlertDialog.show({
            title: 'Dialog Title',
            message: 'This is a dialog message triggered by the button.',
            alignment: DialogAlignment.Center,
            primaryButton: {
              value: 'Cancel',
              action: () => {
                console.info('Cancel button clicked');
              }
            },
            secondaryButton: {
              value: 'OK',
              action: () => {
                console.info('OK button clicked');
              }
            }
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}