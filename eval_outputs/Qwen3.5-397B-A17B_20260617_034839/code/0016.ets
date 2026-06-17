@Entry
@Component
struct Index {
  @State dataList: Array<ListItem> = []
  @State isLoading: boolean = false
  private currentPage: number = 1
  private pageSize: number = 15
  private totalCount: number = 100

  aboutToAppear() {
    this.loadMore()
  }

  loadMore() {
    if (this.isLoading) {
      return
    }
    if (this.dataList.length >= this.totalCount) {
      return
    }

    this.isLoading = true
    setTimeout(() => {
      let newItems: Array<ListItem> = []
      let startIndex = (this.currentPage - 1) * this.pageSize
      for (let i = 0; i < this.pageSize; i++) {
        let currentIndex = startIndex + i
        if (currentIndex >= this.totalCount) {
          break
        }
        newItems.push({
          id: currentIndex,
          title: `Item Content ${currentIndex + 1}`
        })
      }
      this.dataList = [...this.dataList, ...newItems]
      this.currentPage++
      this.isLoading = false
    }, 1000)
  }

  build() {
    Column() {
      Text('Lazy Loading List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .padding(20)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor('#007DFF')
        .fontColor('#FFFFFF')

      List({ space: 10 }) {
        ForEach(this.dataList, (item: ListItem) => {
          ListItem() {
            Column() {
              Text(`ID: ${item.id}`)
                .fontSize(14)
                .fontColor('#666666')
              Text(item.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .margin({ top: 5 })
            }
            .width('100%')
            .padding(15)
            .backgroundColor('#FFFFFF')
            .borderRadius(10)
            .shadow({ radius: 5, color: '#10000000', offsetX: 0, offsetY: 2 })
          }
        }, (item: ListItem) => item.id.toString())

        ListItem() {
          Column() {
            if (this.isLoading) {
              LoadingProgress()
                .width(30)
                .height(30)
              Text('Loading...')
                .fontSize(14)
                .margin({ top: 10 })
            } else if (this.dataList.length >= this.totalCount) {
              Text('No more items')
                .fontSize(14)
                .fontColor('#999999')
            } else {
              Text('Pull up to load more')
                .fontSize(14)
                .fontColor('#999999')
            }
          }
          .width('100%')
          .padding(20)
          .justifyContent(FlexAlign.Center)
        }
      }
      .onReachEnd(() => {
        this.loadMore()
      })
      .layoutWeight(1)
      .width('100%')
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}

interface ListItem {
  id: number
  title: string
}