import { ToggleType, FontWeight, HorizontalAlign, VerticalAlign, FlexAlign } from '@ohos/arkui';

@Component
export struct CustomRatingBar {
  @Link rating: number;
  @Prop ratingIndicator: boolean = false;
  private maxRating: number = 5;
  private circleCount: number = 10;
  private circleData: Array<{ index: number, value: number }> = [];

  aboutToAppear() {
    for (let i = 1; i <= this.circleCount; i++) {
      this.circleData.push({ index: i, value: i * 0.5 });
    }
  }

  build() {
    Row() {
      ForEach(this.circleData, (item: { index: number, value: number }) => {
        Circle()
          .width(24)
          .height(24)
          .fill(this.rating >= item.value ? '#FFD700' : '#FFFFFF')
          .stroke(this.rating >= item.value ? '#FFD700' : '#CCCCCC')
          .strokeWidth(2)
          .margin({ left: 4, right: 4 })
          .onClick(() => {
            if (!this.ratingIndicator) {
              this.rating = item.value;
            }
          })
          .hoverEffect(!this.ratingIndicator)
          .cursor(!this.ratingIndicator ? Cursor.Default : Cursor.Pointer)
      }, (item: { index: number, value: number }) => item.index)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct Index {
  @State rating: number = 0;
  @State ratingIndicator: boolean = false;

  build() {
    Column() {
      Text('Custom Rating Bar')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      CustomRatingBar({ rating: $$(this.rating), ratingIndicator: this.ratingIndicator })
        .margin({ bottom: 30 })

      Text(`Current Rating: ${this.rating}`)
        .fontSize(18)
        .margin({ bottom: 20 })

      Row() {
        Text('Display Only Mode (ratingIndicator): ')
          .fontSize(16)
        Toggle({ type: ToggleType.Switch, isOn: this.ratingIndicator })
          .onChange((isOn: boolean) => {
            this.ratingIndicator = isOn;
          })
      }
      .alignItems(VerticalAlign.Center)
      .padding(10)
      .backgroundColor('#F1F3F5')
      .borderRadius(8)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}