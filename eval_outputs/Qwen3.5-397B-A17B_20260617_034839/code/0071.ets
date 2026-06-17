@Entry
@Component
struct Index {
  @State isSearchExpanded: boolean = false
  @State searchText: string = ''
  @State actionButtonColor: string = '#FFFFFF'

  build() {
    Column() {
      // App Bar
      Stack() {
        // Centered Title
        Text('My Application')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .width('100%')
          .textAlign(TextAlign.Center)

        // Right Aligned Actions
        Row() {
          // Example Action Button
          Button() {
            Image($r('sys.media.icon.more'))
              .width(24)
              .height(24)
              .fillColor(this.actionButtonColor)
          }
          .type(ButtonType.Circle)
          .backgroundColor('transparent')
          .margin({ right: 8 })
          .onClick(() => {
            // Action logic
          })

          // Search Component
          if (this.isSearchExpanded) {
            Row() {
              TextInput({ placeholder: 'Search...', text: this.searchText })
                .layoutWeight(1)
                .height(36)
                .backgroundColor('#FFFFFF')
                .borderRadius(18)
                .padding({ left: 12, right: 12 })
                .fontSize(14)
                .onChange((value: string) => {
                  this.searchText = value
                })
                .onSubmit(() => {
                  // Submit logic
                })

              Image($r('sys.media.icon.close'))
                .width(20)
                .height(20)
                .fillColor('#666666')
                .margin({ left: 8 })
                .onClick(() => {
                  animateTo({ duration: 300, curve: Curve.Ease }, () => {
                    this.isSearchExpanded = false
                    this.searchText = ''
                  })
                })
            }
            .width(200)
            .height(36)
            .alignItems(VerticalAlign.Center)
          } else {
            Image($r('sys.media.icon.search'))
              .width(24)
              .height(24)
              .fillColor(this.actionButtonColor)
              .onClick(() => {
                animateTo({ duration: 300, curve: Curve.Ease }, () => {
                  this.isSearchExpanded = true
                })
              })
          }
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.End)
        .alignItems(VerticalAlign.Center)
        .padding({ right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#007DFF')

      // Page Content
      Column() {
        Text('Page Content')
          .fontSize(16)
          .fontColor('#333333')
          .margin({ top: 20 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F1F3F5')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}