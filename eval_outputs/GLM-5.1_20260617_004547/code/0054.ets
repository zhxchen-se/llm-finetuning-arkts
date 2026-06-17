import { ImageFit } from '@ohos.arkui.UIContext'

@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column({ space: 25 }) {
        Text('Image in Frame Component Demo')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })
          .width('100%')
          .textAlign(TextAlign.Center)

        // Example 1: Center Alignment with Cover
        ImageFrame({
          title: 'Center Alignment / Cover',
          description: 'Image fills the frame while maintaining aspect ratio, aligned to the center.',
          alignment: Alignment.Center,
          objectFit: ImageFit.Cover
        })

        // Example 2: Top Alignment with Contain
        ImageFrame({
          title: 'Top Alignment / Contain',
          description: 'Image is contained within the frame, aligned to the top.',
          alignment: Alignment.Top,
          objectFit: ImageFit.Contain
        })

        // Example 3: BottomStart Alignment with ScaleDown
        ImageFrame({
          title: 'BottomStart Alignment / ScaleDown',
          description: 'Image is scaled down if larger than the frame, aligned to the bottom-start.',
          alignment: Alignment.BottomStart,
          objectFit: ImageFit.ScaleDown
        })

        // Example 4: Center Alignment with None (Original Size)
        ImageFrame({
          title: 'Center Alignment / None',
          description: 'Image retains its original size, aligned to the center (clipped by frame).',
          alignment: Alignment.Center,
          objectFit: ImageFit.None
        })
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .scrollBar(BarState.Auto)
  }
}

@Component
struct ImageFrame {
  @Prop title: string = '';
  @Prop description: string = '';
  @Prop alignment: Alignment = Alignment.Center;
  @Prop objectFit: ImageFit = ImageFit.Cover;

  build() {
    Column({ space: 12 }) {
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')

      Text(this.description)
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      // The Frame Component implemented using a Stack
      Stack() {
        // Placeholder background to visualize the frame area
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#E8E8E8')

        // The Image placed inside the frame
        Image($r('app.media.startIcon'))
          .width('100%')
          .height('100%')
          .objectFit(this.objectFit)
          .interpolation(ImageInterpolation.High)
      }
      .width('100%')
      .height(220)
      .border({ width: 2, color: '#007DFF', radius: 16, style: BorderStyle.Solid })
      .backgroundColor('#FFFFFF')
      .alignContent(this.alignment) // Controls the alignment of the image within the frame
      .clip(true) // Ensures the image does not overflow outside the frame borders
      .shadow({ radius: 8, color: '#1F000000', offsetX: 2, offsetY: 2 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
  }
}