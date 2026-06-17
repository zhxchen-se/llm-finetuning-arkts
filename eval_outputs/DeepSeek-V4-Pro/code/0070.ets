import { animateTo } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State activeIndex: number = 0;
  @State fontSizes: number[] = [14, 18, 18];
  @State underlineLeft: number = 0;
  @State underlineWidth: number = 120;
  @State rowWidth: number = 360;
  private tabNames: string[] = ['Home', 'Discover', 'Profile'];
  private tabCount: number = this.tabNames.length;

  aboutToAppear(): void {
    this.updateUnderline(0);
  }

  updateUnderline(index: number): void {
    const tabWidth = this.rowWidth / this.tabCount;
    this.underlineLeft = index * tabWidth;
    this.underlineWidth = tabWidth;
  }

  handleTabClick(index: number): void {
    if (this.activeIndex === index) {
      return;
    }
    this.activeIndex = index;
    const newFontSizes: number[] = new Array(this.tabCount).fill(18);
    newFontSizes[index] = 14;
    animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
      this.fontSizes = newFontSizes;
      this.updateUnderline(index);
    });
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        Row() {
          ForEach(this.tabNames, (tab: string, index: number) => {
            Text(tab)
              .fontSize(this.fontSizes[index])
              .fontColor(this.activeIndex === index ? '#FF0000' : '#333333')
              .fontWeight(this.activeIndex === index ? FontWeight.Bold : FontWeight.Normal)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .height('100%')
              .onClick(() => this.handleTabClick(index))
          })
        }
        .width('100%')
        .height(48)
        .backgroundColor('#FFFFFF')
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.rowWidth = newValue.width as number;
          animateTo({ duration: 0 }, () => {
            this.updateUnderline(this.activeIndex);
          });
        })

        View()
          .width(this.underlineWidth)
          .height(2)
          .backgroundColor('#FF0000')
          .margin({ left: this.underlineLeft })
      }
      .width('100%')
      .height(48)

      Column() {
        Text(`Content for ${this.tabNames[this.activeIndex]}`)
          .fontSize(20)
          .margin({ top: 20 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
}