import { ImageFit } from '@ohos.arkui';

@Entry
@Component
struct Index {
  @State imageWidth: number = 200
  @State imageHeight: number = 260

  build() {
    Column() {
      // Title
      Text('Image Scaling Comparison')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1a1a2e')
        .margin({ top: 30, bottom: 8 })

      Text('Observe how the same image behaves with different scaling modes')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ bottom: 24 })

      // Image dimensions info
      Row() {
        Text(`Container: ${this.imageWidth} × ${this.imageHeight}`)
          .fontSize(13)
          .fontColor('#888888')
      }
      .margin({ bottom: 20 })

      // Side by side comparison
      Row({ space: 20 }) {
        // Contain mode
        Column() {
          Text('Contain')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#e94560')
            .margin({ bottom: 6 })

          Text('Full image visible, may have empty space')
            .fontSize(11)
            .fontColor('#999999')
            .margin({ bottom: 12 })

          // Container with visible border to show bounds
          Stack() {
            // Background to show empty areas
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor('#f0f0f0')

            Image($r('app.media.startup_icon'))
              .width(this.imageWidth)
              .height(this.imageHeight)
              .objectFit(ImageFit.Contain)
              .interpolation(ImageInterpolation.High)
          }
          .width(this.imageWidth)
          .height(this.imageHeight)
          .border({ width: 2, color: '#e94560', radius: 8 })
          .clip(true)

          // Legend
          Row({ space: 6 }) {
            Circle({ width: 10, height: 10 })
              .fill('#f0f0f0')
              .stroke('#cccccc')
              .strokeWidth(1)
            Text('Empty space')
              .fontSize(11)
              .fontColor('#999999')
          }
          .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Center)

        // Cover mode
        Column() {
          Text('Cover')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0f3460')
            .margin({ bottom: 6 })

          Text('Fills container, image may be cropped')
            .fontSize(11)
            .fontColor('#999999')
            .margin({ bottom: 12 })

          // Container with visible border to show bounds
          Stack() {
            Image($r('app.media.startup_icon'))
              .width(this.imageWidth)
              .height(this.imageHeight)
              .objectFit(ImageFit.Cover)
              .interpolation(ImageInterpolation.High)
          }
          .width(this.imageWidth)
          .height(this.imageHeight)
          .border({ width: 2, color: '#0f3460', radius: 8 })
          .clip(true)

          // Legend
          Row({ space: 6 }) {
            Circle({ width: 10, height: 10 })
              .fill('#0f3460')
            Text('Cropped area hidden')
              .fontSize(11)
              .fontColor('#999999')
          }
          .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .justifyContent(FlexAlign.Center)

      // Divider
      Divider()
        .width('80%')
        .color('#e0e0e0')
        .margin({ top: 28, bottom: 20 })

      // Controls
      Text('Adjust Container Size')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .margin({ bottom: 16 })

      // Width slider
      Row() {
        Text('Width')
          .fontSize(13)
          .fontColor('#666666')
          .width(50)
        Slider({
          value: this.imageWidth,
          min: 120,
          max: 300,
          step: 10,
          style: SliderStyle.OutSet
        })
          .width('60%')
          .trackColor('#e0e0e0')
          .selectedColor('#e94560')
          .blockColor('#e94560')
          .onChange((value: number) => {
            this.imageWidth = value
          })
        Text(`${this.imageWidth}`)
          .fontSize(13)
          .fontColor('#333333')
          .width(40)
          .textAlign(TextAlign.End)
      }
      .width('85%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 12 })

      // Height slider
      Row() {
        Text('Height')
          .fontSize(13)
          .fontColor('#666666')
          .width(50)
        Slider({
          value: this.imageHeight,
          min: 120,
          max: 360,
          step: 10,
          style: SliderStyle.OutSet
        })
          .width('60%')
          .trackColor('#e0e0e0')
          .selectedColor('#0f3460')
          .blockColor('#0f3460')
          .onChange((value: number) => {
            this.imageHeight = value
          })
        Text(`${this.imageHeight}`)
          .fontSize(13)
          .fontColor('#333333')
          .width(40)
          .textAlign(TextAlign.End)
      }
      .width('85%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 16 })

      // Reset button
      Button('Reset to Default')
        .fontSize(14)
        .fontColor('#ffffff')
        .backgroundColor('#533483')
        .borderRadius(20)
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
        .onClick(() => {
          this.imageWidth = 200
          this.imageHeight = 260
        })
        .margin({ bottom: 20 })

      // Explanation card
      Column() {
        Text('Key Differences')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1a1a2e')
          .margin({ bottom: 10 })

        Row({ space: 8 }) {
          Text('●')
            .fontColor('#e94560')
            .fontSize(12)
          Text('Contain preserves the entire image within bounds, adding letterboxing if aspect ratios differ.')
            .fontSize(12)
            .fontColor('#555555')
            .layoutWeight(1)
        }
        .width('100%')
        .margin({ bottom: 6 })

        Row({ space: 8 }) {
          Text('●')
            .fontColor('#0f3460')
            .fontSize(12)
          Text('Cover fills the entire container, cropping the image if aspect ratios differ.')
            .fontSize(12)
            .fontColor('#555555')
            .layoutWeight(1)
        }
        .width('100%')
        .margin({ bottom: 6 })

        Row({ space: 8 }) {
          Text('●')
            .fontColor('#533483')
            .fontSize(12)
          Text('Resize the container to see how each mode adapts to different aspect ratios.')
            .fontSize(12)
            .fontColor('#555555')
            .layoutWeight(1)
        }
        .width('100%')
      }
      .width('85%')
      .padding(16)
      .backgroundColor('#f8f8fc')
      .borderRadius(12)
      .margin({ bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffffff')
    .alignItems(HorizontalAlign.Center)
  }
}