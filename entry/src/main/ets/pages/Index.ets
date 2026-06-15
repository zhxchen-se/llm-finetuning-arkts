// import promptAction from '@ohos.promptAction';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State selectedOption: string = 'None';

  build() {
    Column() {
      Text('Dropdown Menu Example')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      Text(`Selected: ${this.selectedOption}`)
        .fontSize(18)
        .fontColor('#666666')
        .margin({ bottom: 30 })

      Button('Select Option')
        .width('60%')
        .height(48)
        .fontSize(16)
        .bindMenu([
          MenuItem({
            content: 'Option 1',
            action: () => {
              this.selectedOption = 'Option 1';
              promptAction.showToast({ message: 'Option 1 selected' });
            }
          }),
          MenuItem({
            content: 'Option 2',
            action: () => {
              this.selectedOption = 'Option 2';
              promptAction.showToast({ message: 'Option 2 selected' });
            }
          }),
          MenuItem({
            content: 'Option 3',
            action: () => {
              this.selectedOption = 'Option 3';
              promptAction.showToast({ message: 'Option 3 selected' });
            }
          })
        ])
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F1F3F5')
  }
}