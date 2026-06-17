import { CustomDialogController, DialogAlignment } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  private controller: CustomDialogController = new CustomDialogController({
    builder: this.DialogBuilder,
    autoOpen: false,
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: 0 },
    customStyle: true,
    gridCount: 4
  })

  @State message: string = 'Click the button to open the custom dialog';

  @Builder DialogBuilder() {
    Column() {
      Text('Custom Dialog')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ bottom: 12 })

      Text('This is a custom dialog implemented using ArkTS and ArkUI.')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ bottom: 24 })
        .textAlign(TextAlign.Center)

      Row() {
        Button('Cancel')
          .fontColor('#666666')
          .backgroundColor('#FFFFFF')
          .borderWidth(1)
          .borderColor('#DDDDDD')
          .height(40)
          .width('45%')
          .onClick(() => {
            this.controller.close();
          })

        Button('Confirm')
          .fontColor('#FFFFFF')
          .backgroundColor('#007DFF')
          .height(40)
          .width('45%')
          .margin({ left: 10 })
          .onClick(() => {
            this.message = 'You confirmed the action!';
            this.controller.close();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('85%')
    .padding(24)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .shadow({
      radius: 20,
      color: 'rgba(0, 0, 0, 0.15)',
      offsetX: 0,
      offsetY: 5
    })
  }

  build() {
    Column() {
      Text(this.message)
        .fontSize(18)
        .fontColor('#333333')
        .margin({ bottom: 40 })
        .textAlign(TextAlign.Center)
        .width('80%')

      Button('Open Custom Dialog')
        .fontSize(16)
        .fontColor('#FFFFFF')
        .backgroundColor('#007DFF')
        .width('200')
        .height(50)
        .borderRadius(25)
        .onClick(() => {
          this.controller.open();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F1F3F5')
  }
}