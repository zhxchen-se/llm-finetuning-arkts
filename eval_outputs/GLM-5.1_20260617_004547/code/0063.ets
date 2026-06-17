@Entry
@Component
struct Index {
  private objectFitItems: { name: string; fit: ImageFit; description: string }[] = [
    { name: 'Contain', fit: ImageFit.Contain, description: 'Scales to fit within bounds, maintains aspect ratio' },
    { name: 'Cover', fit: ImageFit.Cover, description: 'Scales to fill bounds, maintains aspect ratio, may crop' },
    { name: 'Fill', fit: ImageFit.Fill, description: 'Stretches to fill bounds, ignores aspect ratio' },
    { name: 'None', fit: ImageFit.None, description: 'No scaling, image displayed at original size' },
    { name: 'ScaleDown', fit: ImageFit.ScaleDown, description: 'Like contain but never scales up beyond original size' }
  ]

  private containerSizes: { label: string; width: number; height: number }[] = [
    { label: 'Wide', width: 200, height: 100 },
    { label: 'Tall', width: 100, height: 200 },
    { label: 'Square', width: 140, height: 140 },
    { label: 'Small', width: 80, height: 80 }
  ]

  private imageUrl: string = 'https://picsum.photos/seed/harmony2024/400/300'

  @Builder
  ImageCard(item: { name: string; fit: ImageFit; description: string }) {
    Column() {
      Text(item.name)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1a1a2e')
        .margin({ bottom: 4 })

      Text(item.description)
        .fontSize(12)
        .fontColor('#666')
        .maxLines(2)
        .margin({ bottom: 12 })

      Row() {
        ForEach(this.containerSizes, (size: { label: string; width: number; height: number }) => {
          Column() {
            Stack() {
              Image(this.imageUrl)
                .objectFit(item.fit)
                .width('100%')
                .height('100%')
                .interpolation(ImageInterpolation.High)
                .alt($r('sys.media.ohos_ic_public_phone'))
            }
            .width(size.width)
            .height(size.height)
            .borderWidth(1)
            .borderColor('#e0e0e0')
            .borderStyle(BorderStyle.Dashed)
            .backgroundColor('#f5f5f5')
            .borderRadius(8)

            Text(size.label)
              .fontSize(11)
              .fontColor('#999')
              .margin({ top: 6 })

            Text(`${size.width}×${size.height}`)
              .fontSize(10)
              .fontColor('#bbb')
              .margin({ top: 2 })
          }
          .margin({ right: 12 })
        })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .shadow({ radius: 8, color: '#1a000000', offsetY: 2 })
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('objectFit')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1a1a2e')
        Text(' Explorer')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#e94560')
      }
      .margin({ top: 16, bottom: 4 })

      Text('See how different objectFit values affect image rendering\nacross various container sizes')
        .fontSize(13)
        .fontColor('#888')
        .textAlign(TextAlign.Center)
        .margin({ bottom: 16 })

      // Original image reference
      Row() {
        Text('Original Image: ')
          .fontSize(12)
          .fontColor('#666')
        Text('400×300')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#e94560')
      }
      .margin({ bottom: 16 })

      // ObjectFit sections
      List({ space: 16 }) {
        ForEach(this.objectFitItems, (item: { name: string; fit: ImageFit; description: string }) => {
          ListItem() {
            this.ImageCard(item)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 16 })
      .scrollBar(BarState.Auto)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f0f2f5')
  }
}