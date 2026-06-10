import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State data: string[] = [];
  @State isLoading: boolean = false;
  private pageSize: number = 20;
  private currentPage: number = 0;

  aboutToAppear(): void {
    this.loadMoreData();
  }

  loadMoreData(): void {
    if (this.isLoading) return;
    this.isLoading = true;
    // Simulate network request
    setTimeout(() => {
      let newItems: string[] = [];
      for (let i = 0; i < this.pageSize; i++) {
        newItems.push(`Item ${this.currentPage * this.pageSize + i + 1}`);
      }
      this.data = this.data.concat(newItems);
      this.currentPage++;
      this.isLoading = false;
    }, 1000);
  }

  build() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.data, (item: string, index: number) => {
          ListItem() {
            Text(item)
              .width('100%')
              .height(60)
              .fontSize(18)
              .textAlign(TextAlign.Center)
              .backgroundColor('#F1F3F5')
              .borderRadius(8)
          }
        }, (item: string, index: number) => item + index)

        ListItem() {
          Row() {
            if (this.isLoading) {
              LoadingProgress()
                .width(30)
                .height(30)
                .color('#007DFF')
              Text('Loading more...')
                .fontSize(14)
                .margin({ left: 8 })
            } else {
              Text('Pull up to load more')
                .fontSize(14)
                .fontColor('#999')
            }
          }
          .width('100%')
          .height(60)
          .justifyContent(FlexAlign.Center)
        }
      }
      .width('100%')
      .height('100%')
      .onReachEnd(() => {
        this.loadMoreData();
      })
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}