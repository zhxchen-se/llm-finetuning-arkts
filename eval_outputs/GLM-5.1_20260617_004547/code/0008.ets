@Entry
@Component
struct Index {
  @State isRefreshing: boolean = false
  @State dataList: string[] = Array.from({ length: 5 }, (_, i) => `Item ${i + 1}`)

  build() {
    Column() {
      Refresh({ refreshing: $$this.isRefreshing }) {
        List({ space: 10 }) {
          ForEach(this.dataList, (item: string, index?: number) => {
            ListItem() {
              Text(item)
                .width('90%')
                .height(60)
                .fontSize(18)
                .fontColor('#333333')
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor('#F1F3F5')
            }
            .width('100%')
            .margin({ top: 10 })
          }, (item: string, index?: number) => `${index}_${item}`)
        }
        .width('100%')
        .height('100%')
        .padding({ left: 10, right: 10 })
      }
      .onRefreshing(() => {
        setTimeout(() => {
          this.dataList.unshift(`New Item ${this.dataList.length + 1}`)
          this.isRefreshing = false
        }, 1500)
      })
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }
}