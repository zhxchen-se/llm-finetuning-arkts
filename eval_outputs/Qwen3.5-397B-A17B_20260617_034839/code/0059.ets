import { promptAction } from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State scale: number = 1;
  @State opacity: number = 1;
  @State statusText: string = 'Idle';
  @State borderColor: Color = Color.Gray;

  build() {
    Column() {
      Text(this.statusText)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })
        .fontColor(Color.Black)

      Image('https://placehold.co/400x400.png')
        .width(200)
        .height(200)
        .borderRadius(16)
        .borderWidth(5)
        .borderColor(this.borderColor)
        .scale({ x: this.scale, y: this.scale })
        .opacity(this.opacity)
        .objectFit(ImageFit.Cover)
        .onClick(() => {
          this.statusText = 'Image Clicked!';
          this.borderColor = Color.Green;
          promptAction.showToast({
            message: 'Image Clicked',
            duration: 2000
          });
        })
        .onHover((event: HoverEvent) => {
          if (event.isHovering) {
            this.statusText = 'Hovering...';
            this.scale = 1.1;
            this.opacity = 0.8;
            this.borderColor = Color.Blue;
          } else {
            this.statusText = 'Idle';
            this.scale = 1;
            this.opacity = 1;
            this.borderColor = Color.Gray;
          }
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.statusText = 'Touch Down';
            this.scale = 0.9;
          } else if (event.type === TouchType.Up) {
            this.statusText = 'Touch Up';
            this.scale = 1;
          }
        })

      Text('Try clicking, hovering, or touching the image')
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}