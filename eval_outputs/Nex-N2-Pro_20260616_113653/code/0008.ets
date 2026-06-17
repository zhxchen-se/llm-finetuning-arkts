@Entry
@Component
struct Index {
  @State isRefreshing: boolean = false;
  @State listData: DataItem[] = [];
  @State refreshCount: number = 0;
  @State refreshTime: string = '尚未刷新';

  aboutToAppear(): void {
    this.listData = this.createListData(0);
  }

  build() {
    Column() {
      Column() {
        Text('Pull to Refresh')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1D1D1D')
          .margin({ bottom: 6 })

        Text('向下拉动列表即可刷新数据')
          .fontSize(14)
          .fontColor('#666666')

        Text(this.refreshCount === 0 ? '初始数据' : `已刷新 ${this.refreshCount} 次`)
          .fontSize(13)
          .fontColor('#666666')
          .margin({ top: 4 })

        Text(`最后刷新：${this.refreshTime}`)
          .fontSize(12)
          .fontColor('#888888')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .borderRadius(20)
      .margin({ left: 16, right: 16, top: 16, bottom: 8 })
      .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.06)', offsetX: 0, offsetY: 2 })

      Refresh({ refreshing: this.isRefreshing })
        .width('100%')
        .height('100%')
        .layoutWeight(1)
        .onRefreshing(() => {
          this.startRefresh();
        })
        .refreshColor('#007DFF')
        .triggerOffset(90)
        .refreshingOffset(100)
        .friction(0.45)
      {
        List() {
          ForEach(this.listData, (item: DataItem) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.title)
                    .fontSize(17)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1D1D1D')
                    .margin({ bottom: 6 })

                  Text(item.subtitle)
                    .fontSize(13)
                    .fontColor('#666666')
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Text(`#${item.index}`)
                  .fontSize(12)
                  .fontColor('#007DFF')
                  .textAlign(TextAlign.Center)
                  .padding({ left: 10, right: 10, top: 6, bottom: 6 })
                  .backgroundColor('#EAF2FF')
                  .borderRadius(999)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .padding({ left: 16, right: 16, top: 18, bottom: 18 })
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .clip(true)
            .margin({ bottom: 10 })
            .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.04)', offsetX: 0, offsetY: 2 })
          }, (item: DataItem) => item.id)
        }
        .width('100%')
        .height('100%')
        .padding({ left: 16, right: 16, top: 0, bottom: 16 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6FA')
  }

  private startRefresh(): void {
    this.isRefreshing = true;

    setTimeout(() => {
      this.refreshCount += 1;
      this.refreshTime = new Date().toLocaleTimeString();
      this.listData = this.createListData(this.refreshCount);
      this.isRefreshing = false;
    }, 1500);
  }

  private createListData(batch: number): DataItem[] {
    const data: DataItem[] = [];

    for (let i = 0; i < 20; i++) {
      data.push({
        id: `${batch}-${i}`,
        index: i + 1,
        title: batch === 0 ? `初始列表项 ${i + 1}` : `第 ${batch} 次刷新后的列表项 ${i + 1}`,
        subtitle: batch === 0 ? '初始加载的数据' : '刷新后重新加载的数据'
      });
    }

    return data;
  }
}

interface DataItem {
  id: string;
  index: number;
  title: string;
  subtitle: string;
}