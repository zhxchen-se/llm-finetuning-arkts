import { Curve } from '@ohos.arkui'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private swiperController: SwiperController = new SwiperController()
  private itemCount: number = 5
  private colors: string[] = ['#E74C3C', '#3498DB', '#2ECC71', '#F39C12', '#9B59B6']
  private labels: string[] = ['Sunset', 'Ocean', 'Forest', 'Desert', 'Aurora']
  private icons: string[] = ['☀️', '🌊', '🌲', '🏜️', '🌌']

  @Builder
  ImageCard(index: number) {
    Stack() {
      Column() {
        Text(this.icons[index])
          .fontSize(64)
          .margin({ bottom: 12 })

        Text(this.labels[index])
          .fontSize(28)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 8 })

        Text(`Page ${index + 1} of ${this.itemCount}`)
          .fontSize(14)
          .fontColor('#FFFFFFCC')
      }
      .width('100%')
      .height(320)
      .justifyContent(FlexAlign.Center)
      .borderRadius(20)
      .backgroundColor(this.colors[index])
      .shadow({
        radius: 20,
        color: this.colors[index] + '66',
        offsetY: 8
      })
    }
    .width('92%')
    .padding({ left: '4%', right: '4%' })
  }

  @Builder
  TriangleIndicator(index: number) {
    Column() {
      Stack() {
        Shape() {
          Path()
            .commands('M 14 0 L 28 22 L 0 22 Z')
            .fill(index === this.currentIndex ? this.colors[index] : '#D5D5D5')
            .stroke(index === this.currentIndex ? this.colors[index] : '#B0B0B0')
            .strokeWidth(1.5)
        }
        .width(28)
        .height(22)
        .scale({
          x: index === this.currentIndex ? 1.3 : 1.0,
          y: index === this.currentIndex ? 1.3 : 1.0
        })
        .animation({
          duration: 300,
          curve: Curve.EaseInOut
        })

        if (index === this.currentIndex) {
          Shape() {
            Path()
              .commands('M 8 6 L 14 16 L 2 16 Z')
              .fill(Color.White)
          }
          .width(28)
          .height(22)
          .scale({ x: 1.3, y: 1.3 })
          .animation({
            duration: 300,
            curve: Curve.EaseInOut
          })
        }
      }
      .width(36)
      .height(28)
      .alignContent(Alignment.Center)
    }
    .width(44)
    .height(36)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
        this.currentIndex = index
      })
      this.swiperController.changeIndex(index)
    })
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('Swipe Gallery')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2C3E50')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 50, bottom: 16 })
      .justifyContent(FlexAlign.Center)

      // Subtitle
      Text('Swipe or tap triangles to navigate')
        .fontSize(14)
        .fontColor('#7F8C8D')
        .margin({ bottom: 20 })

      // Swiper
      Swiper(this.swiperController) {
        ForEach(this.colors, (color: string, index?: number) => {
          this.ImageCard(index ?? 0)
        }, (color: string, index?: number) => `${index}`)
      }
      .index(this.currentIndex)
      .autoPlay(false)
      .indicator(false)
      .loop(true)
      .duration(400)
      .curve(Curve.EaseInOut)
      .itemSpace(0)
      .onChange((index: number) => {
        animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
          this.currentIndex = index
        })
      })
      .width('100%')
      .height(340)

      // Triangle Indicators Row
      Row({ space: 16 }) {
        ForEach(this.colors, (color: string, index?: number) => {
          this.TriangleIndicator(index ?? 0)
        }, (color: string, index?: number) => `${index}`)
      }
      .margin({ top: 28 })
      .justifyContent(FlexAlign.Center)
      .width('100%')

      // Page Counter
      Row() {
        Text(`${this.currentIndex + 1}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors[this.currentIndex])
          .animation({ duration: 300 })
        Text(' / ')
          .fontSize(16)
          .fontColor('#95A5A6')
        Text(`${this.itemCount}`)
          .fontSize(16)
          .fontColor('#95A5A6')
      }
      .margin({ top: 20 })

      // Navigation Buttons
      Row({ space: 40 }) {
        // Previous Button
        Button() {
          Row() {
            Shape() {
              Path()
                .commands('M 12 2 L 2 10 L 12 18 Z')
                .fill(Color.White)
            }
            .width(14)
            .height(20)
          }
          .justifyContent(FlexAlign.Center)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#ECF0F1')
        .type(ButtonType.Circle)
        .onClick(() => {
          let prev = this.currentIndex - 1
          if (prev < 0) prev = this.itemCount - 1
          animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
            this.currentIndex = prev
          })
          this.swiperController.changeIndex(prev)
        })

        // Next Button
        Button() {
          Row() {
            Shape() {
              Path()
                .commands('M 2 2 L 12 10 L 2 18 Z')
                .fill(Color.White)
            }
            .width(14)
            .height(20)
          }
          .justifyContent(FlexAlign.Center)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor(this.colors[this.currentIndex])
        .type(ButtonType.Circle)
        .animation({ duration: 300, curve: Curve.EaseInOut })
        .onClick(() => {
          let next = this.currentIndex + 1
          if (next >= this.itemCount) next = 0
          animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
            this.currentIndex = next
          })
          this.swiperController.changeIndex(next)
        })
      }
      .margin({ top: 24 })

      // Progress Bar
      Row() {
        ForEach(this.colors, (color: string, index?: number) => {
          Row()
            .width(index !== undefined && index <= this.currentIndex ? '100%' : '0%')
            .height('100%')
            .borderRadius(2)
            .backgroundColor(index === this.currentIndex ? this.colors[index] : '#BDC3C7')
            .animation({ duration: 300, curve: Curve.EaseInOut })
        }, (color: string, index?: number) => `${index}`)
      }
      .width('80%')
      .height(4)
      .borderRadius(2)
      .backgroundColor('#ECF0F1')
      .margin({ top: 28 })
      .direction(Direction.LTR)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFA')
  }
}