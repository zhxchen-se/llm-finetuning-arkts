import { promptAction } from '@kit.ArkUI';

interface SwiperItem {
  id: number;
  title: string;
  description: string;
  color: string;
}

@Entry
@Component
struct Index {
  @State swiperList: SwiperItem[] = [
    { id: 1, title: 'HarmonyOS', description: 'Next Generation OS', color: '#007DFF' },
    { id: 2, title: 'ArkTS', description: 'Efficient Development', color: '#36D1DC' },
    { id: 3, title: 'ArkUI', description: 'Declarative UI', color: '#5B86E5' }
  ];

  build() {
    Column() {
      Text('Object Bound Swiper')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40, bottom: 20 })
        .fontColor('#333333')

      Swiper() {
        ForEach(this.swiperList, (item: SwiperItem) => {
          Stack() {
            Column() {
              Blank()
              Text(item.title)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
              Text(item.description)
                .fontSize(18)
                .fontColor('#FFFFFF')
                .margin({ top: 10 })
              Blank()
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor(item.color)
            .borderRadius(16)
            .shadow({
              radius: 10,
              color: '#1A000000',
              offsetX: 0,
              offsetY: 5
            })
          }
          .width('100%')
          .height('100%')
        }, (item: SwiperItem) => item.id.toString())
      }
      .width('90%')
      .height(240)
      .indicator({
        width: 8,
        height: 8,
        selectedItemWidth: 24,
        selectedItemHeight: 8,
        color: '#CCCCCC',
        selectedColor: '#007DFF'
      })
      .autoPlay(true)
      .loop(true)
      .interval(3000)
      .vertical(false)
      .margin({ bottom: 30 })

      Column() {
        Text('Data Binding Example')
          .fontSize(16)
          .fontColor('#666666')
        Text('Swipe left or right')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 5 })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor('#F1F3F5')
  }
}