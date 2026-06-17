import { CustomDialogController } from '@ohos.arkui.advanced.CustomDialogController';

@CustomDialog
struct MyCustomDialog {
  controller: CustomDialogController;
  title: string = 'Title';
  message: string = 'Message';

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
          .fontSize(16)
          .onClick(() => {
            this.controller.close();
          })
          .margin({ right: 10 })
        Button('Confirm')
          .fontSize(16)
          .onClick(() => {
            this.controller.close();
            // Optionally show a toast or perform action
            promptAction.showToast({ message: 'Confirmed' });
          })
      }
      .justifyContent(FlexAlign.Center)
    }
    .padding(20)
  }
}

@Entry
@Component
struct Index {
  @State dialogController: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog({
      title: 'Custom Dialog',
      message: 'This is a custom dialog message.'
    }),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true
  });

  build() {
    Column() {
      Button('Open Dialog')
        .fontSize(18)
        .onClick(() => {
          this.dialogController.open();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}