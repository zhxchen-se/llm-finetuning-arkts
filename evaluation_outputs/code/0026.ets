import { Swiper, SwiperItem, Image, Text, Column } from '@ohos.arkui.advanced.Swiper';
import { ForEach } from '@ohos.arkui.advanced.ForEach';

class SwiperItemData {
  image: Resource;
  title: string;
  description: string;

  constructor(image: Resource, title: string, description: string) {
    this.image = image;
    this.title = title;
    this.description = description;
  }
}

@Entry
@Component
struct Index {
  @State swiperData: SwiperItemData[] = [
    new SwiperItemData($r('app.media.img1'), 'Nature', 'Beautiful landscape'),
    new SwiperItemData($r('app.media.img2'), 'City', 'Urban skyline'),
    new SwiperItemData($r('app.media.img3'), 'Ocean', 'Calm sea view')
  ];

  build() {
    Column() {
      Swiper() {
        ForEach(this.swiperData, (item: SwiperItemData, index: number) => {
          SwiperItem() {
            Column() {
              Image(item.image)
                .width('100%')
                .height(200)
                .objectFit(ImageFit.Cover)
                .borderRadius(12)
              Text(item.title)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 12 })
              Text(item.description)
                .fontSize(16)
                .fontColor('#666666')
                .margin({ top: 8 })
            }
            .width('100%')
            .padding(16)
            .alignItems(HorizontalAlign.Center)
          }
        }, (item: SwiperItemData, index: number) => index.toString())
      }
      .loop(true)
      .indicator(true)
      .indicatorStyle({
        selectedColor: '#007AFF',
        color: '#CCCCCC'
      })
      .width('100%')
      .height(320)
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}