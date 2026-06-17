@CustomDialog
struct CustomDialogExample {
  controller: CustomDialogController
  title: string = 'Dialog Title'
  message: string = 'This is a custom dialog message.'

  build() {
    Column() {
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 12 })

      Text(this.message)
        .fontSize(16)
        .fontColor('#666666')
        .margin({ bottom: 24 })

      Row() {
        Button('Cancel')
          .width(100)
          .height(40)
          .fontSize(16)
          .backgroundColor('#CCCCCC')
          .fontColor('#333333')
          .onClick(() => {
            this.controller.close()
          })

        Blank()
          .width(20)

        Button('Confirm')
          .width(100)
          .height(40)
          .fontSize(16)
          .onClick(() => {
            this.controller.close()
          })
      }
      .justifyContent(FlexAlign.Center)
    }
    .padding(24)
    .borderRadius(16)
    .backgroundColor(Color.White)
  }
}

@Entry
@Component
struct Index {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      title: 'Confirm Action',
      message: 'Are you sure you want to proceed with this action?'
    }),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true
  })

  build() {
    Row() {
      Column() {
        Text('Custom Dialog Demo')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 30 })

        Button('Show Dialog')
          .width(200)
          .height(50)
          .fontSize(18)
          .onClick(() => {
            this.dialogController.open()
          })
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}