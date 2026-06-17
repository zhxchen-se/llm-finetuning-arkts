import { Slider } from '@ohos.arkui.advanced.Slider';
import { Radio } from '@ohos.arkui.advanced.Radio';

@Entry
@Component
struct Index {
  @State imageWidth: number = 200;
  @State imageHeight: number = 200;
  @State fitMode: ImageFit = ImageFit.Contain;
  private fitOptions: string[] = ['Contain', 'Cover', 'Fill', 'None', 'ScaleDown'];

  build() {
    Column() {
      Text('Image Resizing Techniques')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 });

      // Width slider
      Row() {
        Text('Width: ' + this.imageWidth.toFixed(0))
          .width(80)
          .fontSize(16);
        Slider({
          value: this.imageWidth,
          min: 50,
          max: 300,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('60%')
          .onChange((value: number) => {
            this.imageWidth = value;
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 10 });

      // Height slider
      Row() {
        Text('Height: ' + this.imageHeight.toFixed(0))
          .width(80)
          .fontSize(16);
        Slider({
          value: this.imageHeight,
          min: 50,
          max: 300,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('60%')
          .onChange((value: number) => {
            this.imageHeight = value;
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 20 });

      // ObjectFit selection
      Row() {
        Text('ObjectFit: ')
          .fontSize(16)
          .margin({ right: 10 });
        Radio({ value: 'Contain', group: 'fitGroup' })
          .checked(this.fitMode === ImageFit.Contain)
          .onChange((isChecked: boolean) => {
            if (isChecked) this.fitMode = ImageFit.Contain;
          });
        Text('Contain').fontSize(14).margin({ right: 10 });

        Radio({ value: 'Cover', group: 'fitGroup' })
          .checked(this.fitMode === ImageFit.Cover)
          .onChange((isChecked: boolean) => {
            if (isChecked) this.fitMode = ImageFit.Cover;
          });
        Text('Cover').fontSize(14).margin({ right: 10 });

        Radio({ value: 'Fill', group: 'fitGroup' })
          .checked(this.fitMode === ImageFit.Fill)
          .onChange((isChecked: boolean) => {
            if (isChecked) this.fitMode = ImageFit.Fill;
          });
        Text('Fill').fontSize(14).margin({ right: 10 });

        Radio({ value: 'None', group: 'fitGroup' })
          .checked(this.fitMode === ImageFit.None)
          .onChange((isChecked: boolean) => {
            if (isChecked) this.fitMode = ImageFit.None;
          });
        Text('None').fontSize(14).margin({ right: 10 });

        Radio({ value: 'ScaleDown', group: 'fitGroup' })
          .checked(this.fitMode === ImageFit.ScaleDown)
          .onChange((isChecked: boolean) => {
            if (isChecked) this.fitMode = ImageFit.ScaleDown;
          });
        Text('ScaleDown').fontSize(14);
      }
      .width('100%')
      .flexWrap(FlexWrap.Wrap)
      .margin({ bottom: 20 });

      // Image container with border
      Stack() {
        Image($r('app.media.startIcon'))
          .objectFit(this.fitMode)
          .width(this.imageWidth)
          .height(this.imageHeight)
          .border({ width: 2, color: Color.Gray, style: BorderStyle.Dashed });
      }
      .width(this.imageWidth + 4) // account for border
      .height(this.imageHeight + 4)
      .border({ width: 2, color: Color.Black, style: BorderStyle.Solid })
      .alignContent(Alignment.Center)
      .margin({ top: 10 });

      // Description
      Text(this.getFitDescription())
        .fontSize(14)
        .fontColor(Color.Gray)
        .margin({ top: 20 })
        .textAlign(TextAlign.Center);
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .justifyContent(FlexAlign.Start);
  }

  getFitDescription(): string {
    switch (this.fitMode) {
      case ImageFit.Contain:
        return 'Contain: Scales image to fit within bounds, maintaining aspect ratio. Entire image visible, may leave empty space.';
      case ImageFit.Cover:
        return 'Cover: Scales image to fill bounds, maintaining aspect ratio. Image may be cropped.';
      case ImageFit.Fill:
        return 'Fill: Stretches image to exactly fill bounds, ignoring aspect ratio (distortion allowed).';
      case ImageFit.None:
        return 'None: No scaling. Image displayed at original size, may overflow or be smaller than bounds.';
      case ImageFit.ScaleDown:
        return 'ScaleDown: Scales down only if image is larger than bounds, otherwise displays at original size. Maintains aspect ratio.';
      default:
        return '';
    }
  }
}