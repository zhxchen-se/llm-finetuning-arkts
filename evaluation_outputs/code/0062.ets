import { ColorFilter } from '@ohos.graphics.colorFilter';

@Entry
@Component
struct Index {
  @State currentFilterIndex: number = 0;
  private filters: Array<{ name: string, matrix: number[] }> = [
    {
      name: 'None',
      matrix: [
        1, 0, 0, 0, 0,
        0, 1, 0, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Grayscale',
      matrix: [
        0.33, 0.59, 0.11, 0, 0,
        0.33, 0.59, 0.11, 0, 0,
        0.33, 0.59, 0.11, 0, 0,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Sepia',
      matrix: [
        0.393, 0.769, 0.189, 0, 0,
        0.349, 0.686, 0.168, 0, 0,
        0.272, 0.534, 0.131, 0, 0,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Invert',
      matrix: [
        -1, 0, 0, 0, 1,
        0, -1, 0, 0, 1,
        0, 0, -1, 0, 1,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Vintage',
      matrix: [
        0.9, 0.5, 0.1, 0, 0,
        0.3, 0.8, 0.1, 0, 0,
        0.2, 0.3, 0.5, 0, 0,
        0, 0, 0, 1, 0
      ]
    }
  ];

  build() {
    Column() {
      // Image with color filter
      Image($r('app.media.sample'))
        .width('100%')
        .height(300)
        .objectFit(ImageFit.Contain)
        .colorFilter(
          ColorFilter.byColorMatrix(this.filters[this.currentFilterIndex].matrix)
        )

      // Filter name display
      Text(this.filters[this.currentFilterIndex].name)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      // Navigation buttons
      Row() {
        Button('Previous')
          .onClick(() => {
            if (this.currentFilterIndex > 0) {
              this.currentFilterIndex--;
            } else {
              this.currentFilterIndex = this.filters.length - 1;
            }
          })
          .margin({ right: 10 })

        Button('Next')
          .onClick(() => {
            if (this.currentFilterIndex < this.filters.length - 1) {
              this.currentFilterIndex++;
            } else {
              this.currentFilterIndex = 0;
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F1F3F5')
  }
}