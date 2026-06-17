import { Color, FlexAlign, HorizontalAlign } from '@ohos.base';

@Entry
@Component
struct Index {
  @State selectedIndex: number = 0;
  private fruits: string[] = ['Apple', 'Banana', 'Orange', 'Grape', 'Watermelon'];

  build() {
    Column() {
      TextPicker({
        options: this.fruits,
        selected: this.selectedIndex
      })
      .onChange((index: number) => {
        this.selectedIndex = index;
        console.info(`Selected position: ${index}`);
      })
      .fontColor(Color.Blue)
      .fontSize(20)
      .width('100%')
      .height(200)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}