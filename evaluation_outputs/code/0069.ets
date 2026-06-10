import { SwiperController } from '@ohos.arkui.advanced.SwiperController';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private swiperController: SwiperController = new SwiperController();
  private imageList: string[] = [
    'https://picsum.photos/400/600?random=1',
    'https://picsum.photos/400/600?random=2',
    'https://picsum.photos/400/600?random=3',
    'https://picsum.photos/400/600?random=4',
    'https://picsum.photos/400/600?random=5'
  ];

  build() {
    Column() {
      Swiper(this.swiperController) {
        ForEach(this.imageList, (item: string, index: number) => {
          Image(item)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
        }, (item: string, index: number) => index.toString())
      }
      .index(this.currentIndex)
      .autoPlay(false)
      .loop(true)
      .indicator(false)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .width('100%')
      .layoutWeight(1)

      Row() {
        ForEach(this.imageList, (item: string, index: number) => {
          Text('●')
            .fontSize(14)
            .fontColor(index === this.currentIndex ? '#FFFFFF' : '#808080')
            .margin({ left: 6, right: 6 })
            .onClick(() => {
              this.currentIndex = index;
              this.swiperController.changeIndex(index);
            })
        }, (item: string, index: number) => index.toString())
      }
      .width('100%')
      .height(48)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#1A1A1A')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}