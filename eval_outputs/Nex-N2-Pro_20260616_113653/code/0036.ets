@Entry
@Component
struct Index {
  @State status: string = 'No action selected.'

  private customDialogController: CustomDialogController<CustomDialog> = new CustomDialogController<CustomDialog>({
    builder: CustomDialog,
    builderParam: {
      onCancel: () => {
        this.handleCancel()
      },
      onConfirm: () => {
        this.handleConfirm()
      }
    },
    alignment: DialogAlignment.Center,
    offset: { dx: 0, y: 0 },
    autoCancel: true,
    gridCount: 4,
    customStyle: true,
    cancelArea: {
      width: '100%',
      height: '100%'
    }
  })

  handleCancel(): void {
    this.status = 'Dialog canceled.'
    this.customDialogController.close()
  }

  handleConfirm(): void {
    this.status = 'Dialog confirmed.'
    this.customDialogController.close()
  }

  build() {
    Column() {
      Button('Show Custom Dialog')
        .width('70%')
        .height(48)
        .fontSize(16)
        .onClick(() => {
          this.customDialogController.open()
        })

      Text(this.status)
        .margin({ top: 24 })
        .fontSize(16)
        .fontColor('#333333')
    }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#F1F3F5')
  }
}

@CustomDialog
struct CustomDialog {
  @BuilderParam onCancel: () => void = () => {}
  @BuilderParam onConfirm: () => void = () => {}

  build() {
    Column() {
      Text('Dialog Title')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .textAlign(TextAlign.Center)

      Text('This is a custom dialog message. Please confirm or cancel the action.')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ top: 12, bottom: 24 })
        .textAlign(TextAlign.Center)

      Row() {
        Button('Cancel')
          .height(40)
          .layoutWeight(1)
          .fontSize(15)
          .fontColor('#333333')
          .backgroundColor('#EDEFF2')
          .onClick(() => {
            this.onCancel()
          })

        Button('Confirm')
          .height(40)
          .layoutWeight(1)
          .fontSize(15)
          .fontColor('#FFFFFF')
          .backgroundColor('#007DFF')
          .margin({ left: 12 })
          .onClick(() => {
            this.onConfirm()
          })
      }
        .width('100%')
    }
      .width('86%')
      .padding({ left: 24, right: 24, top: 20, bottom: 16 })
      .backgroundColor(Color.White)
      .borderRadius(16)
  }
}