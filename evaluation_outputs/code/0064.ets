import { Lottie, LottieController } from '@ohos/lottie';

@Entry
@Component
struct Index {
  private controller: LottieController = new LottieController();
  @State status: string = 'Stopped';

  build() {
    Column() {
      Text('Animation Player')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 });

      Lottie({
        controller: this.controller,
        src: $rawfile('animation.json'),
        autoPlay: false,
        loop: true
      })
        .width('100%')
        .height('50%')
        .backgroundColor(Color.White)
        .borderRadius(10)
        .margin({ bottom: 20 });

      Text(`Status: ${this.status}`)
        .fontSize(18)
        .margin({ bottom: 20 });

      Row() {
        Button('Start')
          .width('30%')
          .onClick(() => {
            this.controller.play();
            this.status = 'Playing';
          });

        Button('Pause')
          .width('30%')
          .onClick(() => {
            this.controller.pause();
            this.status = 'Paused';
          });

        Button('Stop')
          .width('30%')
          .onClick(() => {
            this.controller.stop();
            this.status = 'Stopped';
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ left: 10, right: 10 });
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F1F3F5');
  }
}