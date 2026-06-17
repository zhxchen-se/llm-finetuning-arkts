import { Chip, ChipType, ChipSize } from '@ohos.widgets';

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'All';
  @State message: string = 'Click a filter chip to change the selection.';

  private filterChips: string[] = ['All', 'Design', 'Code', 'Test'];

  build() {
    Column() {
      Text('Chip Component Usage')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 24 });

      Text('Normal and small chips')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 12 });

      Row() {
        Chip({
          chipOptions: {
            label: 'Normal',
            type: ChipType.NORMAL,
            size: ChipSize.MEDIUM
          }
        })
          .onClick(() => {
            this.message = 'Normal chip clicked';
          })
          .margin({ right: 12 });

        Chip({
          chipOptions: {
            label: 'Small',
            type: ChipType.NORMAL,
            size: ChipSize.SMALL
          }
        })
          .onClick(() => {
            this.message = 'Small chip clicked';
          })
          .margin({ right: 12 });
      }
        .width('100%');

      Text('Selectable filter chips')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 24, bottom: 12 });

      ForEach(this.filterChips, (item: string) => {
        Chip({
          chipOptions: {
            label: item,
            type: ChipType.FILTER,
            size: ChipSize.MEDIUM,
            selected: item === this.selectedFilter
          }
        })
          .onClick(() => {
            this.selectedFilter = item;
            this.message = `Selected filter: ${item}`;
          })
          .margin({ right: 12, bottom: 12 });
      }, (item: string) => item);

      Text(this.message)
        .fontSize(16)
        .fontColor('#1F2937')
        .margin({ top: 24 });
    }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .backgroundColor('#F8FAFC');
  }
}