import { CustomDialogController, DialogAlignment } from '@ohos.arkui.customDialogController';

@CustomDialog
struct MyDialog {
  title: string
  message: string
  onCancel: () => void
  onConfirm: () => void

  build() {
    Column() {
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 10 })

      Text(this.message)
        .fontSize(16)
        .margin({ bottom: 20 })

      Row() {
        Button('Cancel')
          .onClick(() => {
            this.onCancel()
          })
          .margin({ right: 10 })

        Button('Confirm')
          .onClick(() => {
            this.onConfirm()
          })
      }
    }
    .width('80%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(10)
  }
}

@Entry
@Component
struct Index {
  @State isDialogShow: boolean = false
  private customDialogController: CustomDialogController = new CustomDialogController({
    builder: () => MyDialog({
      title: 'Custom Dialog',
      message: 'This is a custom dialog message.',
      onCancel: () => {
        this.customDialogController.close()
      },
      onConfirm: () => {
        this.customDialogController.close()
      }
    }),
    autoOpen: false,
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: 0 },
    customStyle: true,
    gridCount: 4
  })

  build() {
    Column() {
      Text('Hello World')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Button('Show Dialog')
        .onClick(() => {
          this.customDialogController.open()
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}