@Entry
@Component
struct Index {
  @State refreshing: boolean = false
  @State dataList: string[] = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5']

  build() {
    Column() {
      Refresh({ refreshing: this.refreshing }) {
        List() {
          ForEach(this.dataList, (item: string) => {
            ListItem() {
              Text(item)
                .width('100%')
                .height(50)
                .textAlign(TextAlign.Center)
                .fontSize(16)
            }
          }, (item: string) => item)
        }
        .width('100%')
        .height('100%')
      }
      .onRefresh(() => {
        this.refreshing = true
        setTimeout(() => {
          this.refreshing = false
          this.dataList.unshift('New Item ' + Date.now().toString())
        }, 2000)
      })
    }
    .width('100%')
    .height('100%')
  }
}