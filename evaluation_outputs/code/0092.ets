import { Chip, ChipGroup } from '@ohos.arkui.advanced.Chip';

@Entry
@Component
struct Index {
  @State chipList: string[] = ['Chip 1', 'Chip 2', 'Chip 3', 'Chip 4'];
  @State selectedChips: number[] = [0, 2]; // indices of selected chips in chipGroup
  @State removableChips: string[] = ['Removable A', 'Removable B', 'Removable C'];

  build() {
    Column({ space: 20 }) {
      Text('Chip Component Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20 })

      // Basic Chip
      Text('Basic Chip').fontSize(18).fontWeight(FontWeight.Medium)
      Chip({ label: 'Basic Chip' })

      // Chip with icon (using symbol)
      Text('Chip with Symbol Icon').fontSize(18).fontWeight(FontWeight.Medium)
      Chip({ label: 'Favorite' }) {
        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(16)
          .fontColor([Color.Red])
      }

      // Chip with custom icon (image)
      Text('Chip with Image Icon').fontSize(18).fontWeight(FontWeight.Medium)
      Chip({ label: 'Settings' }) {
        Image($r('app.media.ic_public_settings'))
          .width(16)
          .height(16)
      }

      // Chip with close button
      Text('Chip with Close Button').fontSize(18).fontWeight(FontWeight.Medium)
      Row({ space: 8 }) {
        ForEach(this.removableChips, (item: string, index: number) => {
          Chip({ label: item }) {
            // close icon
            SymbolGlyph($r('sys.symbol.xmark'))
              .fontSize(14)
              .onClick(() => {
                this.removableChips.splice(index, 1);
                this.removableChips = [...this.removableChips]; // trigger update
              })
          }
        }, (item: string, index: number) => item + index)
      }
      .width('100%')
      .flexWrap(FlexWrap.Wrap)

      // Chip with different styles
      Text('Chip Styles').fontSize(18).fontWeight(FontWeight.Medium)
      Row({ space: 8 }) {
        Chip({ label: 'Filled' })
          .chipStyle(ChipStyle.FILLED)
        Chip({ label: 'Outlined' })
          .chipStyle(ChipStyle.OUTLINED)
        Chip({ label: 'Elevated' })
          .chipStyle(ChipStyle.ELEVATED)
      }

      // ChipGroup with selection
      Text('ChipGroup (Selectable)').fontSize(18).fontWeight(FontWeight.Medium)
      ChipGroup({
        items: this.chipList,
        selectedIndexes: this.selectedChips,
        onSelectionChange: (indexes: number[]) => {
          this.selectedChips = indexes;
        }
      })
        .chipStyle(ChipStyle.FILLED)
        .multiple(true) // allow multiple selection

      // ChipGroup single selection
      Text('ChipGroup (Single Selection)').fontSize(18).fontWeight(FontWeight.Medium)
      ChipGroup({
        items: ['Option 1', 'Option 2', 'Option 3'],
        selectedIndexes: [0],
        onSelectionChange: (indexes: number[]) => {
          // single selection, only one index
          console.info('Selected: ' + indexes.toString());
        }
      })
        .multiple(false)

      // Disabled Chip
      Text('Disabled Chip').fontSize(18).fontWeight(FontWeight.Medium)
      Chip({ label: 'Disabled' })
        .enabled(false)

    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor($r('app.color.background'))
  }
}