@Entry
@Component
struct Index {
  @State userRating: number = 3.5;
  @State userName: string = 'John Doe';
  @State joinDate: string = '2023-01-15';

  build() {
    Column() {
      // User photo placeholder (circle with initial)
      Stack() {
        Circle()
          .width(80)
          .height(80)
          .fill('#E0E0E0')
        Text(this.userName.charAt(0).toUpperCase())
          .fontSize(30)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .width(80)
      .height(80)
      .margin({ bottom: 10 })

      Text(this.userName)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 5 })

      Text(`Member since: ${this.joinDate}`)
        .fontSize(14)
        .fontColor('#888888')
        .margin({ bottom: 20 })

      Divider()
        .strokeWidth(1)
        .color('#CCCCCC')
        .width('80%')
        .margin({ bottom: 20 })

      // Rating section
      Text('Your Rating')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })

      Rating({ rating: this.userRating, indicator: false })
        .stars(5)
        .stepSize(0.5)
        .onChange((value: number) => {
          this.userRating = value;
        })
        .margin({ bottom: 10 })

      Text(`${this.userRating} / 5`)
        .fontSize(18)
        .fontColor('#FFA500')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
    .backgroundColor('#F5F5F5')
  }
}