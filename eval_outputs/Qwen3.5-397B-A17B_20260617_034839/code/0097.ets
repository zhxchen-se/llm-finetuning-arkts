import type { Resource } from '@ohos.base';

@Entry
@Component
struct Index {
  @State fruits: Array<{ name: string, image: Resource }> = [
    { name: 'Apple', image: $r('app.media.icon') },
    { name: 'Banana', image: $r('app.media.icon') },
    { name: 'Orange', image: $r('app.media.icon') },
    { name: 'Grape', image: $r('app.media.icon') },
    { name: 'Watermelon', image: $r('app.media.icon') }
  ]

  build() {
    Column() {
      ForEach(this.fruits, (item: { name: string, image: Resource }, index: number) => {
        Row() {
          Image(item.image)
            .width(50)
            .height(50)
            .objectFit(ImageFit.Contain)

          Text(item.name)
            .fontSize(24)
            .fontColor('#333333')
            .margin({ left: 15 })
        }
        .width('100%')
        .padding(15)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 5, color: '#CCCCCC', offsetX: 0, offsetY: 2 })
        .margin({ bottom: 10 })
      }, (item: { name: string, image: Resource }, index: number) => {
        return item.name + index.toString();
      })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F1F3F5')
  }
}