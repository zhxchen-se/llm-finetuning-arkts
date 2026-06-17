@Entry
@Component
struct Index {
  @State items: string[] = []
  @State isLoading: boolean = false
  @State hasMore: boolean = true
  private pageIndex: number = 0
  private pageSize: number = 20

  aboutToAppear() {
    this.loadMore()
  }

  private loadMore() {
    if (this.isLoading || !this.hasMore) {
      return
    }
    this.isLoading = true

    setTimeout(() => {
      const newItems: string[] = []
      for (let i = 0; i < this.pageSize; i++) {
        const index = this.pageIndex * this.pageSize + i
        newItems.push(`Item ${index + 1}`)
      }

      this.items = this.items.concat(newItems)
      this.pageIndex++

      if (this.pageIndex >= 5) {
        this.hasMore = false
      }

      this.isLoading = false
    }, 1000)
  }

  build() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.items, (item: string, index?: number) => {
          ListItem() {
            Text(item)
              .width('100%')
              .height(60)
              .fontSize(18)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.White)
              .borderRadius(8)
              .shadow({ radius: 2, color: '#cccccc', offsetY: 2 })
          }
        }, (item: string, index?: number) => `${index}_${item}`)

        if (this.isLoading) {
          ListItem() {
            Row() {
              LoadingProgress().width(24).height(24).color(Color.Blue)
              Text('Loading more...')
                .fontSize(16)
                .fontColor(Color.Gray)
                .margin({ left: 8 })
            }
            .width('100%')
            .height(50)
            .justifyContent(FlexAlign.Center)
          }
        } else if (!this.hasMore) {
          ListItem() {
            Text('No more data')
              .width('100%')
              .height(50)
              .fontSize(16)
              .fontColor(Color.Gray)
              .textAlign(TextAlign.Center)
          }
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 10, right: 10, top: 10 })
      .onReachEnd(() => {
        this.loadMore()
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}