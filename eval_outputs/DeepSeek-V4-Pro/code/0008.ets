import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State dataArray: string[] = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  @State isRefreshing: boolean = false;

  // Simulate a data refresh
  refreshData() {
    this.isRefreshing = true;
    // Simulate network request delay
    setTimeout(() => {
      // Add new items or reload data
      const newItems = ['New Item A', 'New Item B', 'New Item C'];
      this.dataArray = [...newItems, ...this.dataArray];
      this.isRefreshing = false;
      promptAction.showToast({ message: 'Refresh completed' });
    }, 2000);
  }

  build() {
    Column() {
      Refresh({ refreshing: $$this.isRefreshing }) {
        List() {
          ForEach(this.dataArray, (item: string, index: number) => {
            ListItem() {
              Text(item)
                .fontSize(18)
                .padding(16)
                .width('100%')
                .textAlign(TextAlign.Start)
            }
            .border({ width: { bottom: 0.5 }, color: '#dddddd' })
          }, (item: string, index: number) => item + index)
        }
        .width('100%')
        .height('100%')
        .divider({ strokeWidth: 0.5, color: '#dddddd', startMargin: 16, endMargin: 0 })
      }
      .onRefreshing(() => {
        this.refreshData();
      })
      .refreshOffset(64) // Pull-down distance to trigger refresh
      .pullDownRatio(0.6) // Ratio of pull-down distance to trigger refresh
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}