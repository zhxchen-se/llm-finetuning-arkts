@Entry
@Component
struct Index {
  @State rating: number = 4

  build() {
    Column() {
      Row() {
        Column({ space: 8 }) {
          Image($r('app.media.icon'))
            .width(72)
            .height(72)
            .borderRadius(36)
            .objectFit(ImageFit.Cover)

          Text('Alex Morgan')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          Text('Date: 2024-05-16')
            .fontSize(14)
            .fontColor('#666666')
        }
        .width(220)
        .alignItems(HorizontalAlign.Start)

        Column({ space: 12 }) {
          Text('User rating')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Rating({ rating: this.rating, indicator: false })
            .starStyle({
              secondaryColor: '#F6D276',
              primaryColor: '#FF8800',
              background: '#F6D276',
              foreground: '#FF8800'
            })
            .onChange((value: number) => {
              this.rating = value
            })

          Text(`Rating: ${this.rating.toFixed(1)} / 5`)
            .fontSize(16)
            .fontColor('#1D1D1F')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#F7F8FA')
  }
}