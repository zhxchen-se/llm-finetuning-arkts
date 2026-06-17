@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Image Inside Frame Component Demo')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      // Example 1: Image filling the Frame
      Text('1. Image Filling Frame (ObjectFit: Cover)')
        .fontSize(14)
        .margin({ top: 10, bottom: 5 })
      Frame() {
        Image($r('app.media.icon'))
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Cover)
      }
      .width(200)
      .height(200)
      .border({ width: 4, color: '#007DFF', radius: 12 })
      .backgroundColor('#F1F3F5')
      .margin({ bottom: 20 })

      // Example 2: Image Centered in Larger Frame
      Text('2. Image Centered in Frame (Using Position)')
        .fontSize(14)
        .margin({ top: 10, bottom: 5 })
      Frame() {
        Image($r('app.media.icon'))
          .width(100)
          .height(100)
          .objectFit(ImageFit.Contain)
          // Center the image within the 200x200 frame
          .position({ x: 50, y: 50 })
      }
      .width(200)
      .height(200)
      .border({ width: 4, color: '#007DFF', radius: 12 })
      .backgroundColor('#F1F3F5')
      .margin({ bottom: 20 })

      // Example 3: Image with Contain Fit (Showing Frame Background)
      Text('3. Image Contain Fit (Frame Background Visible)')
        .fontSize(14)
        .margin({ top: 10, bottom: 5 })
      Frame() {
        Image($r('app.media.icon'))
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Contain)
      }
      .width(200)
      .height(200)
      .border({ width: 4, color: '#007DFF', radius: 12 })
      .backgroundColor('#E8F4FF')
      .margin({ bottom: 20 })

      // Example 4: Multiple Images Stacked in Frame
      Text('4. Multiple Images Stacked (Frame Capability)')
        .fontSize(14)
        .margin({ top: 10, bottom: 5 })
      Frame() {
        Image($r('app.media.icon'))
          .width(150)
          .height(150)
          .position({ x: 0, y: 0 })
        Image($r('app.media.icon'))
          .width(150)
          .height(150)
          .position({ x: 25, y: 25 })
          .opacity(0.7)
      }
      .width(200)
      .height(200)
      .border({ width: 4, color: '#007DFF', radius: 12 })
      .backgroundColor('#F1F3F5')
    }
    .width('100%')
    .padding(20)
  }
}