@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State images: string[] = [
    'https://picsum.photos/id/1015/900/600',
    'https://picsum.photos/id/1025/900/600',
    'https://picsum.photos/id/1039/900/600',
    'https://picsum.photos/id/1043/900/600',
    'https://picsum.photos/id/1074/900/600'
  ]

  build() {
    Column() {
      Text('Swipe between images')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1D2939')
        .margin({ top: 48, bottom: 24 })

      Stack() {
        Image(this.images[this.currentIndex])
          .width('100%')
          .height('100%')
          .borderRadius(24)
          .objectFit(ImageFit.Cover)
          .shadow({
            radius: 18,
            color: '#10182826',
            offsetX: 0,
            offsetY: 10
          })

        Text((this.currentIndex + 1).toString() + ' / ' + this.images.length.toString())
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .borderRadius(14)
          .backgroundColor('#00000066')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .height(360)
      .gesture(
        SwipeGesture()
          .onAction((event: GestureEvent) => {
            if (event.direction === SwipeDirection.Left) {
              this.currentIndex = (this.currentIndex + 1) % this.images.length
            } else if (event.direction === SwipeDirection.Right) {
              this.currentIndex = (this.currentIndex - 1 + this.images.length) % this.images.length
            }
          })
      )

      Row() {
        ForEach(this.images, (item: string, index: number) => {
          TriangleIndicator({
            active: index === this.currentIndex,
            onTap: () => {
              this.currentIndex = index
            }
          })
          .width(24)
          .height(24)
        }, (item: string, index: number) => index.toString())
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 24 })

      Text('Swipe left or right to change the image')
        .fontSize(14)
        .fontColor('#667085')
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F7FA')
  }
}

@Component
struct TriangleIndicator {
  @Prop active: boolean = false
  private onTap: () => void = () => {}

  build() {
    Stack() {
      Text(this.active ? '▲' : '△')
        .fontSize(this.active ? 24 : 18)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.active ? '#0A84FF' : '#B8C0CC')
    }
    .width('100%')
    .height('100%')
    .onClick(() => {
      this.onTap()
    })
  }
}