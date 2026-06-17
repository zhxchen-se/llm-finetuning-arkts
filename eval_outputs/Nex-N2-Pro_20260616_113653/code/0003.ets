@Entry
@Component
struct Index {
  @State elements: string[] = [
    'Element 1',
    'Element 2',
    'Element 3',
    'Element 4',
    'Element 5',
    'Element 6',
    'Element 7',
    'Element 8',
    'Element 9',
    'Element 10'
  ];

  build() {
    Column() {
      Text('Horizontal Scroll List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 24, bottom: 12 })

      Text('Swipe horizontally to view more elements')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ bottom: 16 })

      List({ space: 16 }) {
        ForEach(this.elements, (item: string, index: number) => {
          ListItem() {
            Column() {
              Text(`${index + 1}`)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')

              Text(item)
                .fontSize(16)
                .fontColor('#FFFFFF')
                .margin({ top: 8 })
            }
            .width(180)
            .height(180)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .borderRadius(20)
            .backgroundColor(this.getColor(index))
          }
          .width(180)
        }, (item: string) => item)
      }
      .width('100%')
      .height(230)
      .horizontal(true)
      .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      .scrollBar(BarState.Auto)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F7F8FA')
  }

  private getColor(index: number): string {
    const colors: string[] = [
      '#3B82F6',
      '#10B981',
      '#F59E0B',
      '#EF4444',
      '#8B5CF6',
      '#06B6D4',
      '#EC4899',
      '#84CC16'
    ];

    return colors[index % colors.length];
  }
}