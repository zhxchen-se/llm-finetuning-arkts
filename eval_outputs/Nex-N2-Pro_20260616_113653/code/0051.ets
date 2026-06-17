import { VerticalAlign, FlexAlign, HorizontalAlign, FontWeight, TextAlign } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column() {
        Text('VerticalAlign Demo')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .margin({ top: 24, bottom: 8 })

        Text('Each colored Row has the same white child block.')
          .fontSize(15)
          .fontColor('#475569')
          .textAlign(TextAlign.Center)
          .width('90%')

        this.AlignCard('VerticalAlign.Top', VerticalAlign.Top, '#E0F2FE')
        this.AlignCard('VerticalAlign.Center', VerticalAlign.Center, '#FCE7F3')
        this.AlignCard('VerticalAlign.Bottom', VerticalAlign.Bottom, '#DCFCE7')

        Text('Only alignItems changes: Top, Center, or Bottom.')
          .fontSize(14)
          .fontColor('#64748B')
          .textAlign(TextAlign.Center)
          .width('90%')
          .margin({ top: 16, bottom: 24 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 0, bottom: 24 })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  @Builder
  AlignCard(title: string, alignment: VerticalAlign, background: string) {
    Column() {
      Text(title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#334155')
        .margin({ bottom: 8 })

      Row() {
        this.CommonChild()
      }
      .width('100%')
      .height(120)
      .padding({ left: 16, right: 16 })
      .backgroundColor(background)
      .border({ width: 1, color: '#CBD5E1' })
      .borderRadius(14)
      .alignItems(alignment)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E2E8F0' })
    .borderRadius(16)
    .margin({ top: 12 })
  }

  @Builder
  CommonChild() {
    Column() {
      Text('Identical child elements')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')

      Text('240 x 64 vp')
        .fontSize(14)
        .fontColor('#64748B')
        .margin({ top: 6 })
    }
    .width(240)
    .height(64)
    .padding(8)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#94A3B8' })
    .borderRadius(12)
  }
}