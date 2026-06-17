import { ColorFilter } from '@ohos.arkui';

interface FilterItem {
  name: string;
  matrix: number[];
  overlayColor?: string;
  overlayOpacity?: number;
}

@Entry
@Component
struct Index {
  @State currentFilterIndex: number = 0
  @State imageScale: number = 1.0
  @State showComparison: boolean = false

  private filters: FilterItem[] = [
    {
      name: 'Original',
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
        0.299, 0.587, 0.114, 0, 0,
        0.299, 0.587, 0.114, 0, 0,
        0.299, 0.587, 0.114, 0, 0,
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
        -1, 0, 0, 0, 255,
        0, -1, 0, 0, 255,
        0, 0, -1, 0, 255,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Warm',
      matrix: [
        1.2, 0.1, 0, 0, 20,
        0, 1.0, 0, 0, 0,
        0, 0, 0.8, 0, 0,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Cool',
      matrix: [
        0.8, 0, 0, 0, 0,
        0, 1.0, 0, 0, 0,
        0.1, 0.1, 1.2, 0, 20,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Vintage',
      matrix: [
        0.6, 0.3, 0.1, 0, 30,
        0.2, 0.6, 0.1, 0, 10,
        0.1, 0.2, 0.5, 0, 10,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'High Contrast',
      matrix: [
        1.5, 0, 0, 0, -40,
        0, 1.5, 0, 0, -40,
        0, 0, 1.5, 0, -40,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Brightness',
      matrix: [
        1.3, 0, 0, 0, 30,
        0, 1.3, 0, 0, 30,
        0, 0, 1.3, 0, 30,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Saturate',
      matrix: [
        1.4, -0.1, -0.1, 0, 0,
        -0.1, 1.4, -0.1, 0, 0,
        -0.1, -0.1, 1.4, 0, 0,
        0, 0, 0, 1, 0
      ]
    },
    {
      name: 'Dramatic',
      matrix: [
        1.1, -0.1, -0.1, 0, 10,
        -0.1, 1.2, -0.1, 0, 10,
        -0.1, -0.1, 1.3, 0, 10,
        0, 0, 0, 1.1, 0
      ]
    },
    {
      name: 'Sunset',
      matrix: [
        1.3, 0.2, 0, 0, 30,
        0, 1.0, 0, 0, 0,
        0, 0, 0.7, 0, 0,
        0, 0, 0, 1, 0
      ]
    }
  ]

  private scroller: Scroller = new Scroller()

  build() {
    Column() {
      // Header
      Row() {
        Text('Color Filters')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
        Blank()
        Text(this.filters[this.currentFilterIndex].name)
          .fontSize(16)
          .fontColor('#FFD700')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 12 })

      // Main Image Area
      Stack() {
        // Background shadow
        Column()
          .width('92%')
          .height(320)
          .borderRadius(16)
          .shadow({ radius: 20, color: '#33000000', offsetX: 0, offsetY: 8 })

        // Image with filter
        Image($r('app.media.startIcon'))
          .width('92%')
          .height(320)
          .objectFit(ImageFit.Cover)
          .borderRadius(16)
          .colorFilter(ColorFilter.createMatrixColorFilter(this.filters[this.currentFilterIndex].matrix))
          .scale({ x: this.imageScale, y: this.imageScale })
          .animation({ duration: 200, curve: Curve.EaseInOut })
          .onClick(() => {
            this.imageScale = 0.97
            setTimeout(() => {
              this.imageScale = 1.0
            }, 100)
          })

        // Comparison overlay
        if (this.showComparison) {
          Column() {
            Text('Original')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
          }
          .width('92%')
          .height(320)
          .borderRadius(16)
          .backgroundColor('#66000000')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }

        // Filter label badge
        Row() {
          Text(this.filters[this.currentFilterIndex].name)
            .fontSize(12)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .borderRadius(20)
        .backgroundColor('#CC000000')
        .position({ x: '4%', y: 280 })
      }
      .width('100%')
      .height(340)
      .alignContent(Alignment.Center)

      // Comparison Button
      Row() {
        Button() {
          Row() {
            Text(this.showComparison ? 'Hide Original' : 'Compare Original')
              .fontSize(13)
              .fontColor('#FFFFFF')
          }
        }
        .height(36)
        .borderRadius(18)
        .backgroundColor('#333333')
        .type(ButtonType.Normal)
        .onClick(() => {
          this.showComparison = !this.showComparison
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 8, bottom: 8 })

      // Filter Category Label
      Row() {
        Text('Filter Effects')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#EEEEEE')
        Blank()
        Text(`${this.currentFilterIndex + 1} / ${this.filters.length}`)
          .fontSize(13)
          .fontColor('#999999')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 8, bottom: 8 })

      // Filter Selection List
      Scroll(this.scroller) {
        Row({ space: 12 }) {
          ForEach(this.filters, (filter: FilterItem, index: number) => {
            Column() {
              // Thumbnail with filter preview
              Stack() {
                Image($r('app.media.startIcon'))
                  .width(72)
                  .height(72)
                  .objectFit(ImageFit.Cover)
                  .borderRadius(12)
                  .colorFilter(ColorFilter.createMatrixColorFilter(filter.matrix))

                // Selection indicator
                if (this.currentFilterIndex === index) {
                  Column() {
                    Image($r('sys.media.ohos_ic_public_ok'))
                      .width(20)
                      .height(20)
                      .fillColor('#FFFFFF')
                  }
                  .width(72)
                  .height(72)
                  .borderRadius(12)
                  .backgroundColor('#4D000000')
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                  .borderWidth(2.5)
                  .borderColor('#FFD700')
                  .borderStyle(BorderStyle.Solid)
                }
              }
              .width(72)
              .height(72)

              // Filter name
              Text(filter.name)
                .fontSize(11)
                .fontColor(this.currentFilterIndex === index ? '#FFD700' : '#CCCCCC')
                .fontWeight(this.currentFilterIndex === index ? FontWeight.Bold : FontWeight.Normal)
                .margin({ top: 6 })
                .maxLines(1)
            }
            .onClick(() => {
              this.currentFilterIndex = index
            })
          }, (filter: FilterItem, index: number) => `${index}_${filter.name}`)
        }
        .padding({ left: 20, right: 20 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .padding({ top: 4, bottom: 12 })

      // Filter Details Card
      Column() {
        Row() {
          Column() {
            Text('Filter Details')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#EEEEEE')
            Text(this.filters[this.currentFilterIndex].name)
              .fontSize(12)
              .fontColor('#999999')
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          // Navigation arrows
          Row({ space: 8 }) {
            Button() {
              Text('◀')
                .fontSize(16)
                .fontColor('#FFFFFF')
            }
            .width(36)
            .height(36)
            .borderRadius(18)
            .backgroundColor('#333333')
            .type(ButtonType.Normal)
            .enabled(this.currentFilterIndex > 0)
            .opacity(this.currentFilterIndex > 0 ? 1.0 : 0.3)
            .onClick(() => {
              if (this.currentFilterIndex > 0) {
                this.currentFilterIndex--
              }
            })

            Button() {
              Text('▶')
                .fontSize(16)
                .fontColor('#FFFFFF')
            }
            .width(36)
            .height(36)
            .borderRadius(18)
            .backgroundColor('#333333')
            .type(ButtonType.Normal)
            .enabled(this.currentFilterIndex < this.filters.length - 1)
            .opacity(this.currentFilterIndex < this.filters.length - 1 ? 1.0 : 0.3)
            .onClick(() => {
              if (this.currentFilterIndex < this.filters.length - 1) {
                this.currentFilterIndex++
              }
            })
          }
        }
        .width('100%')

        // Matrix preview
        Row() {
          Text('Color Matrix: ')
            .fontSize(11)
            .fontColor('#888888')
          Text(this.getMatrixPreview())
            .fontSize(10)
            .fontColor('#AAAAAA')
            .fontFamily('monospace')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: 8 })
      }
      .width('92%')
      .padding(16)
      .borderRadius(16)
      .backgroundColor('#1A1A1A')
      .margin({ top: 4, bottom: 16 })

      // Quick Reset Button
      Button() {
        Row({ space: 8 }) {
          Text('↺')
            .fontSize(18)
            .fontColor('#FFFFFF')
          Text('Reset to Original')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }
      }
      .width('92%')
      .height(48)
      .borderRadius(24)
      .backgroundColor('#2A2A2A')
      .type(ButtonType.Normal)
      .margin({ bottom: 20 })
      .onClick(() => {
        this.currentFilterIndex = 0
        this.showComparison = false
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0D0D0D')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
  }

  private getMatrixPreview(): string {
    const m = this.filters[this.currentFilterIndex].matrix
    return `[${m[0].toFixed(1)},${m[1].toFixed(1)},${m[2].toFixed(1)}] [${m[5].toFixed(1)},${m[6].toFixed(1)},${m[7].toFixed(1)}] [${m[10].toFixed(1)},${m[11].toFixed(1)},${m[12].toFixed(1)}]`
  }
}