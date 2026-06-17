@CustomDialog
struct CustomDialogWidget {
  controller: CustomDialogController
  onConfirm: () => void = () => {}
  onCancel: () => void = () => {}

  build() {
    Column() {
      Text('Confirm Action')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Text('Are you sure you want to proceed with this action? This operation cannot be undone.')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ bottom: 24 })

      Row() {
        Button('Cancel')
          .width(120)
          .height(40)
          .backgroundColor('#E0E0E0')
          .fontColor('#333333')
          .onClick(() => {
            this.onCancel()
            this.controller.close()
          })

        Button('Confirm')
          .width(120)
          .height(40)
          .backgroundColor('#007DFF')
          .onClick(() => {
            this.onConfirm()
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .padding(24)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .width('85%')
  }
}

@Entry
@Component
struct Index {
  @State dialogResult: string = 'No action taken yet'
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogWidget({
      onConfirm: () => {
        this.dialogResult = 'Action confirmed successfully!'
      },
      onCancel: () => {
        this.dialogResult = 'Action was cancelled'
      }
    }),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true
  })

  build() {
    Row() {
      Column() {
        Text('Custom Dialog Demo')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 20 })

        Text(this.dialogResult)
          .fontSize(18)
          .fontColor('#555555')
          .margin({ bottom: 40 })
          .textAlign(TextAlign.Center)
          .width('80%')

        Button('Show Custom Dialog')
          .width(220)
          .height(50)
          .fontSize(18)
          .backgroundColor('#007DFF')
          .borderRadius(25)
          .onClick(() => {
            this.dialogController.open()
          })
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}