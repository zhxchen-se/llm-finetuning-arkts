@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

  private imageList: string[] = [
    'https://picsum.photos/id/1015/1200/800',
    'https://picsum.photos/id/1025/1200/800',
    'https://picsum.photos/id/1035/1200/800',
    'https://picsum.photos/id/1043/1200/800',
    'https://picsum.photos/id/1062/1200/800'
  ];

  build() {
    Column() {
      Text('Swipeable Image Gallery')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .margin({ top: 48, bottom: 8 });

      Text('Swipe left or right to browse images')
        .fontSize(15)
        .fontColor('#64748B')
        .margin({ bottom: 24 });

      Swiper() {
        ForEach(this.imageList, (item: string, index: number) => {
          Image(item)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover);
        }, (item: string, index: number) => index.toString());
      }
        .width('90%')
        .height(360)
        .loop(true)
        .indicator(false)
        .borderRadius(24)
        .clip(true)
        .onChange((index: number) => {
          this.currentIndex = index;
        });

      Row() {
        ForEach(this.imageList, (item: string, index: number) => {
          Column() {}
            .width(index === this.currentIndex ? 24 : 8)
            .height(8)
            .backgroundColor(index === this.currentIndex ? '#2563EB' : '#CBD5E1')
            .borderRadius(99)
            .margin({ left: index === 0 ? 0 : 6 });
        }, (item: string, index: number) => index.toString());
      }
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20 })
        .animation({ duration: 200, curve: Curve.Ease });
    }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F8FAFC');
  }
}