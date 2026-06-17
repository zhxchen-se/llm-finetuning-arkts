@Entry
@Component
struct Index {
  @State isRefreshing: boolean = false;
  @State dataList: ListItemModel[] = [];
  @State nextId: number = 0;
  @State refreshCount: number = 0;

  aboutToAppear(): void {
    this.loadData();
  }

  loadData(): void {
    for (let i = 0; i < 20; i++) {
      this.dataList.push(new ListItemModel(this.nextId++, `Item ${i + 1}`));
    }
  }

  handleRefresh(): void {
    this.isRefreshing = true;
    setTimeout(() => {
      this.refreshCount++;
      const newItems: ListItemModel[] = [];
      for (let i = 0; i < 5; i++) {
        newItems.unshift(new ListItemModel(this.nextId++, `Refreshed ${this.refreshCount}-${i + 1}`));
      }
      this.dataList = [...newItems, ...this.dataList];
      this.isRefreshing = false;
    }, 1500);
  }

  build() {
    Column() {
      Text('Pull to Refresh Demo')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .padding(16)
        .width('100%')
        .textAlign(TextAlign.Center)

      Refresh({ refreshing: this.isRefreshing, offset: 64, friction: 0.6 }) {
        List({ space: 12 }) {
          ForEach(this.dataList, (item: ListItemModel) => {
            ListItem() {
              Row() {
                Text(item.title)
                  .fontSize(16)
                  .fontColor('#333333')
                Blank()
                Text(`ID: ${item.id}`)
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(8)
              .shadow({ radius: 2, color: '#1f000000', offsetX: 0, offsetY: 1 })
            }
          }, (item: ListItemModel) => item.id.toString())
        }
        .padding({ left: 16, right: 16 })
        .layoutWeight(1)
        .edgeEffect(EdgeEffect.Spring)
        .scrollBar(BarState.Auto)
      }
      .onRefresh(() => {
        this.handleRefresh();
      })
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}

class ListItemModel {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}