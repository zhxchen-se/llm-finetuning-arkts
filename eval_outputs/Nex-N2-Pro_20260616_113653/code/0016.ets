@Entry
@Component
struct Index {
  @State items: ListItemData[] = []
  @State isLoading: boolean = false
  @State hasMore: boolean = true

  private readonly pageSize: number = 20
  private readonly totalItems: number = 100
  private readonly loadDelay: number = 800

  aboutToAppear(): void {
    this.loadMore()
  }

  private loadMore(): void {
    if (this.isLoading || !this.hasMore) {
      return
    }

    this.isLoading = true

    setTimeout(() => {
      const start: number = this.items.length
      const count: number = Math.min(this.pageSize, this.totalItems - start)

      if (count <= 0) {
        this.hasMore = false
        this.isLoading = false
        return
      }

      const newItems: ListItemData[] = []
      for (let i: number = 0; i < count; i++) {
        const id: number = start + i + 1
        newItems.push({
          id: id,
          title: 'Item ' + id,
          desc: 'Description for item ' + id
        })
      }

      this.items = this.items.concat(newItems)
      this.hasMore = this.items.length < this.totalItems
      this.isLoading = false
    }, this.loadDelay)
  }

  build() {
    Column() {
      Text('Lazy Loading Demo')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16, bottom: 12 })

      List() {
        LazyForEach(this.items, (item: ListItemData) => {
          ListItem() {
            Column() {
              Text(item.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)

              Text(item.desc)
                .fontSize(14)
                .fontColor('#666666')
                .margin({ top: 4 })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 14, bottom: 14 })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Start)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 8 })
          }
          .width('100%')
        }, (item: ListItemData) => item.id.toString())

        ListItem() {
          Column() {
            if (this.isLoading) {
              LoadingProgress()
                .width(32)
                .height(32)

              Text('Loading more items...')
                .fontSize(14)
                .fontColor('#666666')
                .margin({ top: 8 })
            } else if (this.hasMore) {
              Text('Scroll down to load more')
                .fontSize(14)
                .fontColor('#888888')
            } else {
              Text('No more items')
                .fontSize(14)
                .fontColor('#888888')
            }
          }
          .width('100%')
          .height(70)
          .justifyContent(FlexAlign.Center)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .onReachEnd(() => {
        this.loadMore()
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
  }
}

interface ListItemData {
  id: number
  title: string
  desc: string
}