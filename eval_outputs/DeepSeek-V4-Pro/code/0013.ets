// entry/src/main/ets/pages/Index.ets
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Button('Show Dialog')
        .fontSize(20)
        .margin({ top: 20 })
        .onClick(() => {
          promptAction.showDialog({
            title: 'Dialog Title',
            message: 'This is a dialog message.',
            buttons: [
              {
                text: 'Cancel',
                color: '#000000'
              },
              {
                text: 'OK',
                color: '#007DFF'
              }
            ]
          }).then((data) => {
            console.info('Dialog clicked: ' + data.index);
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}