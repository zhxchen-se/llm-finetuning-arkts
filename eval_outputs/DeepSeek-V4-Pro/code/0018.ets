import { TextBackgroundStyle } from '@ohos.arkui.UIContext';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Highlighted Text Example')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Text() {
        Span('This ')
        Span('is ')
        Span('a ')
        Span('text ')
        Span('with ')
        Span('different ')
          .textBackgroundStyle({ color: Color.Yellow, radius: 4 })
        Span('highlights.')
          .textBackgroundStyle({ color: Color.Cyan, radius: 4 })
      }
      .fontSize(20)
      .fontColor(Color.Black)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
  }
}