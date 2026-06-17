import {
  animateTo,
  Curve,
  FlexAlign,
  FontWeight,
  HorizontalAlign,
  TextOverflow,
  VerticalAlign
} from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State activeIndex: number = 0;
  private readonly tabNames: string[] = ['Home', 'Discover', 'Create', 'Profile'];

  build() {
    Column() {
      Text('Top Tab Cursor')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .margin({ bottom: 8 })

      Text('The line cursor moves under the active tab; active labels shrink while inactive labels expand.')
        .fontSize(14)
        .fontColor('#64748B')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: 20 })

      Column() {
        Row() {
          ForEach(this.tabNames, (name: string, index: number) => {
            Row()
              .width(`${100 / this.tabNames.length}%`)
              .height(72)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(this.activeIndex === index ? '#EEF2FF' : '#FFFFFF')
              .borderRadius(18)
              .onClick(() => this.switchTab(index))
            {
              Text(name)
                .fontSize(this.activeIndex === index ? 16 : 22)
                .fontWeight(this.activeIndex === index ? FontWeight.Bold : FontWeight.Medium)
                .fontColor(this.activeIndex === index ? '#1D4ED8' : '#64748B')
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
          }, (name: string) => name)
        }
        .width('100%')
        .height(72)
        .justifyContent(FlexAlign.Start)

        Row()
          .width(this.cursorWidth())
          .height(4)
          .backgroundColor('#2563EB')
          .borderRadius(10)
          .margin({ left: this.cursorLeft() })
          .shadow({
            radius: 12,
            color: 'rgba(37, 99, 235, 0.35)',
            offsetX: 0,
            offsetY: 4
          })
      }
      .width('100%')
      .height(80)
      .padding({ left: 4, right: 4, bottom: 4 })
      .borderRadius(24)
      .backgroundColor('#FFFFFF')
      .shadow({
        radius: 22,
        color: 'rgba(15, 23, 42, 0.08)',
        offsetX: 0,
        offsetY: 12
      })

      Column() {
        Text(this.tabNames[this.activeIndex])
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')

        Text('Tap another tab to see the cursor slide and the labels resize.')
          .fontSize(15)
          .fontColor('#64748B')
          .margin({ top: 8 })

        Row() {
          ForEach(['Animated cursor', 'Compact active label', 'Expanded inactive labels'], (item: string) => {
            Column() {
              Text(item)
                .fontSize(13)
                .fontColor('#475569')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .width('30%')
            .height(86)
            .padding(12)
            .margin({ right: 8 })
            .borderRadius(18)
            .backgroundColor('#F8FAFC')
          }, (item: string) => item)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .padding({ top: 28, left: 16, right: 16, bottom: 24 })
    .backgroundColor('#F6F8FB')
  }

  private switchTab(index: number): void {
    if (this.activeIndex === index) {
      return;
    }

    animateTo({ duration: 360, curve: Curve.Ease }, () => {
      this.activeIndex = index;
    });
  }

  private cursorWidth(): string {
    const segment = 100 / this.tabNames.length;
    return `${(segment * 0.42).toFixed(2)}%`;
  }

  private cursorLeft(): string {
    const segment = 100 / this.tabNames.length;
    const width = segment * 0.42;
    return `${(segment * this.activeIndex + (segment - width) / 2).toFixed(2)}%`;
  }
}