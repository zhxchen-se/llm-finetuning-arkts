import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State bgColor: string = '#FF0000'; // Initial red color

  build() {
    Column() {
      // Component whose background color changes
      Text('Tap the button to change my background')
        .fontSize(20)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .width('80%')
        .height(100)
        .backgroundColor(this.bgColor)
        .borderRadius(10)
        .margin({ bottom: 20 })

      // Button to trigger color change
      Button('Change Color')
        .fontSize(18)
        .onClick(() => {
          // Cycle through a set of colors
          const colors = ['#FF0000', '#00FF00', '#0000FF', '#FFFF00', '#FF00FF', '#00FFFF'];
          const currentIndex = colors.indexOf(this.bgColor);
          const nextIndex = (currentIndex + 1) % colors.length;
          this.bgColor = colors[nextIndex];
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F0F0F0')
  }
}