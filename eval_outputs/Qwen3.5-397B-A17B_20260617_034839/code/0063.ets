import { ImageFit, FontWeight, FlexAlign, HorizontalAlign } from '@ohos/arkui';

@Entry
@Component
struct Index {
  @State imageUrl: string = 'https://placehold.co/400x200/png';

  build() {
    Scroll() {
      Column() {
        Text('Image ObjectFit Demos')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 30 })

        // 1. Contain: Fit within box, maintain aspect ratio, may have empty space
        this.buildDemoItem('Contain', ImageFit.Contain, '200vp', '200vp', 'Square Container')

        // 2. Cover: Fill box, maintain aspect ratio, may crop
        this.buildDemoItem('Cover', ImageFit.Cover, '200vp', '300vp', 'Tall Container')

        // 3. Fill: Stretch to fill box, ignore aspect ratio
        this.buildDemoItem('Fill', ImageFit.Fill, '300vp', '150vp', 'Wide Container')

        // 4. None: Original size, centered (clipped if container smaller)
        this.buildDemoItem('None', ImageFit.None, '150vp', '150vp', 'Small Container')

        // 5. ScaleDown: Like Contain, but don't scale up if image is smaller
        this.buildDemoItem('ScaleDown', ImageFit.ScaleDown, '250vp', '250vp', 'Medium Container')

        Text('Note: Ensure ohos.permission.INTERNET is enabled for network images.')
          .fontSize(12)
          .fontColor('#666')
          .margin({ top: 20, bottom: 40 })
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
  }

  buildDemoItem(title: string, fitMode: ImageFit, width: string, height: string, subtitle: string) {
    Column() {
      Text(`${title} (${subtitle})`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })

      Column() {
        Image(this.imageUrl)
          .width('100%')
          .height('100%')
          .objectFit(fitMode)
      }
      .width(width)
      .height(height)
      .border({ width: 2, color: '#007DFF', style: BorderStyle.Solid })
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text(`Container: ${width} x ${height}`)
        .fontSize(12)
        .fontColor('#888')
        .margin({ top: 5 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 30 })
  }
}