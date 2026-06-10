import { Swiper, SwiperItem, Image, Column, Row, Stack, Circle, Polygon } from '@ohos/arkui';
import { LengthMetrics } from '@ohos.arkui.node';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private imageList: string[] = [
    'https://picsum.photos/400/300?random=1',
    'https://picsum.photos/400/300?random=2',
    'https://picsum.photos/400/300?random=3',
    'https://picsum.photos/400/300?random=4',
    'https://picsum.photos/400/300?random=5'
  ];
  private dotSize: number = 8;
  private dotSpacing: number = 12;
  private triangleWidth: number = 16;
  private triangleHeight: number = 8;

  build() {
    Column() {
      Swiper() {
        ForEach(this.imageList, (item: string, index: number) => {
          SwiperItem() {
            Image(item)
              .width('100%')
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(12)
          }
        })
      }
      .width('100%')
      .height(200)
      .indicator(false)
      .loop(true)
      .autoPlay(true)
      .interval(3000)
      .onChange((index: number) => {
        this.currentIndex = index;
      })

      // Custom triangle indicator
      Stack({ alignContent: Alignment.Center }) {
        // Inactive dots
        Row({ space: this.dotSpacing }) {
          ForEach(this.imageList, (item: string, index: number) => {
            Circle()
              .width(this.dotSize)
              .height(this.dotSize)
              .fill(index === this.currentIndex ? Color.Transparent : '#CCCCCC')
          })
        }
        .width('auto')
        .height(this.dotSize)

        // Active triangle (moves to current index)
        Polygon()
          .width(this.triangleWidth)
          .height(this.triangleHeight)
          .points([
            [0, this.triangleHeight],
            [this.triangleWidth / 2, 0],
            [this.triangleWidth, this.triangleHeight]
          ])
          .fill('#FF6600')
          .position({
            x: this.currentIndex * (this.dotSize + this.dotSpacing) + this.dotSize / 2 - this.triangleWidth / 2,
            y: 0
          })
          .animation({ duration: 300, curve: Curve.EaseInOut })
      }
      .width('100%')
      .height(this.triangleHeight + this.dotSize)
      .margin({ top: 12 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }
}