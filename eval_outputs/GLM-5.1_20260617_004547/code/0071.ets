@Entry
@Component
struct Index {
  @State isSearching: boolean = false
  @State searchText: string = ''

  build() {
    Column() {
      // App Bar
      Row() {
        if (this.isSearching) {
          // Search Mode Layout
          Row() {
            Image($r('sys.media.ohos_ic_public_arrow_left'))
              .width(24)
              .height(24)
              .fillColor('#182431')
              .onClick(() => {
                animateTo({ duration: 300 }, () => {
                  this.isSearching = false
                  this.searchText = ''
                })
              })

            TextInput({ placeholder: 'Search...', text: this.searchText })
              .layoutWeight(1)
              .height(40)
              .margin({ left: 12, right: 12 })
              .border({ radius: 20 })
              .backgroundColor('#F1F3F5')
              .type(InputType.Normal)
              .enterKeyType(EnterKeyType.Search)
              .onChange((value: string) => {
                this.searchText = value
              })
              .onSubmit(() => {
                // Handle search submit
              })

            Image($r('sys.media.ohos_ic_public_search'))
              .width(24)
              .height(24)
              .fillColor('#182431')
              .onClick(() => {
                // Trigger search action
              })
          }
          .width('100%')
          .height('100%')
          .alignItems(VerticalAlign.Center)
        } else {
          // Normal Mode Layout
          Stack() {
            Text('App Title')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#182431')
              .textAlign(TextAlign.Center)
              .width('100%')

            Row({ space: 16 }) {
              Image($r('sys.media.ohos_ic_public_search'))
                .width(24)
                .height(24)
                .fillColor('#182431')
                .onClick(() => {
                  animateTo({ duration: 300 }, () => {
                    this.isSearching = true
                  })
                })

              Image($r('sys.media.ohos_ic_public_add'))
                .width(24)
                .height(24)
                .fillColor('#182431')

              Image($r('sys.media.ohos_ic_public_more'))
                .width(24)
                .height(24)
                .fillColor('#182431')
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
          }
          .width('100%')
          .height('100%')
          .alignContent(Alignment.Center)
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)
      .shadow({ radius: 2, color: '#1A000000', offsetY: 2 })

      // Main Content Area
      Column() {
        if (this.isSearching && this.searchText) {
          Text(`Searching for: ${this.searchText}`)
            .fontSize(16)
            .fontColor('#666666')
        } else {
          Text('Welcome to the App')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#182431')
            .margin({ bottom: 8 })

          Text('Click the search icon to expand the search bar.')
            .fontSize(16)
            .fontColor('#666666')
        }
      }
      .layoutWeight(1)
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}