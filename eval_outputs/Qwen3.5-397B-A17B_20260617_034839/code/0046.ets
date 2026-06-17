@Entry
@Component
struct Index {
  @State rating: number = 3;
  private userName: string = 'Alex Johnson';
  private joinDate: string = 'Joined: 2023-10-15';
  private avatarUrl: string = 'https://placehold.co/100x100/007DFF/white?text=AJ';

  build() {
    Column() {
      // User Information Section
      Row() {
        Image(this.avatarUrl)
          .width(80)
          .height(80)
          .borderRadius(40)
          .objectFit(ImageFit.Cover)
          .margin({ right: 16 })

        Column() {
          Text(this.userName)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 8 })

          Text(this.joinDate)
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('90%')
      .padding(20)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
      .margin({ top: 40 })

      // Rating Section
      Column() {
        Text('Your Rating')
          .fontSize(16)
          .margin({ bottom: 10, top: 30 })

        Rating({ rating: this.rating, indicator: false })
          .starStyle({
            background: '#E5E5E5',
            foreground: '#FFA500',
            secondaryForeground: '#FFA500'
          })
          .onChange((value: number) => {
            this.rating = value;
          })

        Text(`Rating: ${this.rating} / 5`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 15 })
          .fontColor('#007DFF')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}