import { Swiper, SwiperItem } from '@ohos.arkui.advanced.Swiper';

@Entry
@Component
struct Index {
  @State items: string[] = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  build() {
    Column() {
      Text('Swiper Demo')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })
      Swiper() {
        ForEach(this.items, (item: string) => {
          SwiperItem() {
            Text(item)
              .fontSize(50)
              .width('100%')
              .height('100%')
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Orange)
          }
        }, (item: string) => item)
      }
      .width('100%')
      .height('60%')
      .indicator(true)
      .loop(true)
      .autoPlay(false)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}