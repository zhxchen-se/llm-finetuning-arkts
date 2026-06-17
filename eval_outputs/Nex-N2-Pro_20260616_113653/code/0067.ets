@Entry
@Component
struct Index {
  @State bgColor: string = '#E6F7FF';

  build() {
    Column() {
      Text('Change Background Color')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Text('This component background will change')
        .fontSize(18)
        .padding(20)
        .backgroundColor(this.bgColor)
        .borderRadius(12)
        .margin({ bottom: 24 })

      Button('Change Color')
        .onClick(() => {
          this.bgColor = this.bgColor === '#E6F7FF' ? '#FFE6E6' : '#E6F7FF';
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F5F5')
  }
}