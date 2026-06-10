import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State isHovered: boolean = false;
  @State clickCount: number = 0;
  @State imageOpacity: number = 1.0;

  build() {
    Column({ space: 20 }) {
      Text('Image Event Handlers Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20 })

      Image($r('app.media.startIcon'))
        .width(200)
        .height(200)
        .objectFit(ImageFit.Contain)
        .opacity(this.imageOpacity)
        .border({
          width: this.isHovered ? 3 : 1,
          color: this.isHovered ? Color.Blue : Color.Gray,
          radius: 10
        })
        .animation({ duration: 200, curve: Curve.EaseInOut })
        .onClick(() => {
          this.clickCount++;
          promptAction.showToast({
            message: `Image clicked ${this.clickCount} time(s)`,
            duration: 2000
          });
        })
        .onHover((isHover: boolean) => {
          this.isHovered = isHover;
          this.imageOpacity = isHover ? 0.8 : 1.0;
        })

      Text(`Hover state: ${this.isHovered ? 'Hovering' : 'Not hovering'}`)
        .fontSize(18)
        .fontColor(this.isHovered ? Color.Blue : Color.Black)

      Text(`Click count: ${this.clickCount}`)
        .fontSize(18)

      Button('Reset click count')
        .onClick(() => {
          this.clickCount = 0;
        })
        .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
  }
}