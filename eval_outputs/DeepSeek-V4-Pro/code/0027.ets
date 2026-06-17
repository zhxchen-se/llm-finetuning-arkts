import { CustomDialogController } from '@ohos.arkui.advanced.CustomDialogController';

@CustomDialog
struct MyCustomDialog {
  controller: CustomDialogController;
  title: string = 'Custom Dialog';
  message: string = 'This is a custom dialog.';
  confirm?: () => void;
  cancel?: () => void;

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
            if (this.cancel) {
              this.cancel();
            }
            this.controller.close();
          })
          .backgroundColor('#FFCCCC')
          .margin({ right: 10 })
        Button('Confirm')
          .onClick(() => {
            if (this.confirm) {
              this.confirm();
            }
            this.controller.close();
          })
          .backgroundColor('#CCFFCC')
      }
    }
    .padding(20)
    .borderRadius(10)
    .backgroundColor(Color.White)
  }
}

@Entry
@Component
struct Index {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog({
      title: 'Welcome',
      message: 'Do you want to proceed?',
      confirm: () => {
        console.info('User confirmed');
      },
      cancel: () => {
        console.info('User cancelled');
      }
    }),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true
  });

  build() {
    Column() {
      Button('Open Custom Dialog')
        .onClick(() => {
          this.dialogController.open();
        })
        .margin({ top: 100 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}