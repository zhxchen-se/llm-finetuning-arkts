import { router } from '@kit.ArkUI'

@Entry
@Component
struct IndexPage {
  @State currentIndex: number = 0
  @State indicatorOffset: number = 0
  @State isDragging: boolean = false
  @State dragOffset: number = 0
  @State imageScale: number = 1
  @State imageBrightness: number = 1
  @State showInfo: boolean = false

  private images: Resource[] = [
    $r('app.media.startIcon'),
    $r('app.media.startIcon'),
    $r('app.media.startIcon'),
    $r('app.media.startIcon'),
    $r('app.media.startIcon')
  ]

  private titles: string[] = [
    'Misty Mountain Peaks',
    'Golden Desert Dunes',
    'Emerald Forest Path',
    'Azure Ocean Waves',
    'Starry Night Valley'
  ]

  private subtitles: string[] = [
    'Nature Collection 01',
    'Nature Collection 02',
    'Nature Collection 03',
    'Nature Collection 04',
    'Nature Collection 05'
  ]

  private swiperController: SwiperController = new SwiperController()

  aboutToAppear() {
    this.updateIndicatorPosition()
  }

  private updateIndicatorPosition() {
    const itemWidth = 48
    const gap = 16
    const totalWidth = this.images.length * itemWidth + (this.images.length - 1) * gap
    const startX = (360 - totalWidth / 2) - itemWidth / 2
    this.indicatorOffset = startX + this.currentIndex * (itemWidth + gap) + itemWidth / 2
  }

  private onIndexChange(index: number) {
    animateTo({ duration: 400, curve: Curve.EaseInOut }, () => {
      this.currentIndex = index
      this.updateIndicatorPosition()
    })
  }

  @Builder
  TriangleIndicator() {
    Shape() {
      Path()
        .commands('M 0 12 L 10 0 L 20 12 Z')
        .fill('#FFFFFF')
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.3)', offsetX: 0, offsetY: 2 })
    }
    .width(20)
    .height(12)
    .position({ x: this.indicatorOffset - 10, y: 0 })
    .animation({
      duration: 400,
      curve: Curve.EaseInOut,
      iterations: 1,
      playMode: PlayMode.Normal
    })
  }

  @Builder
  DotIndicator(index: number) {
    Stack() {
      if (this.currentIndex === index) {
        Circle()
          .width(10)
          .height(10)
          .fill('#FFFFFF')
          .shadow({ radius: 6, color: 'rgba(255,255,255,0.5)' })
      } else {
        Circle()
          .width(8)
          .height(8)
          .fill('rgba(255,255,255,0.4)')
      }
    }
    .width(48)
    .height(48)
    .onClick(() => {
      this.swiperController.showNext()
      this.swiperController.showPrevious()
      this.swiperController.changeIndex(index, true)
    })
  }

  @Builder
  ImageCard(resource: Resource, index: number) {
    Stack({ alignContent: Alignment.BottomStart }) {
      Image(resource)
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .scale({
          x: this.currentIndex === index ? this.imageScale : 1,
          y: this.currentIndex === index ? this.imageScale : 1
        })
        .brightness(this.currentIndex === index ? this.imageBrightness : 0.7)
        .animation({
          duration: 600,
          curve: Curve.EaseInOut,
          iterations: 1
        })

      LinearGradient()
        .width('100%')
        .height(200)
        .direction(GradientDirection.Bottom)
        .colors([
          ['rgba(0,0,0,0)', 0],
          ['rgba(0,0,0,0.6)', 1]
        ])

      Column() {
        Text(this.titles[index])
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.subtitles[index])
          .fontSize(14)
          .fontColor('rgba(255,255,255,0.7)')
          .margin({ top: 4 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(`${index + 1} / ${this.images.length}`)
            .fontSize(12)
            .fontColor('rgba(255,255,255,0.5)')
        }
        .margin({ top: 12 })
      }
      .padding(24)
      .margin({ bottom: 20 })
      .opacity(this.currentIndex === index ? 1 : 0)
      .translate({ y: this.currentIndex === index ? 0 : 20 })
      .animation({
        duration: 500,
        curve: Curve.EaseOut,
        delay: this.currentIndex === index ? 200 : 0
      })
    }
    .width('100%')
    .height('100%')
    .borderRadius(24)
    .clip(true)
    .shadow({
      radius: this.currentIndex === index ? 20 : 10,
      color: this.currentIndex === index ? 'rgba(0,0,0,0.3)' : 'rgba(0,0,0,0.1)',
      offsetX: 0,
      offsetY: this.currentIndex === index ? 8 : 4
    })
    .animation({
      duration: 400,
      curve: Curve.EaseInOut
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Stack({ alignContent: Alignment.TopEnd }) {
          Swiper(this.swiperController) {
            ForEach(this.images, (item: Resource, index: number) => {
              this.ImageCard(item, index)
            })
          }
          .index(this.currentIndex)
          .autoPlay(false)
          .indicator(false)
          .loop(true)
          .duration(500)
          .curve(Curve.EaseInOut)
          .itemSpace(16)
          .displayMode(SwiperDisplayMode.STRETCH)
          .prevMargin(30)
          .nextMargin(30)
          .onChange((index: number) => {
            this.onIndexChange(index)
          })
          .onGestureSwipe((index: number, extraInfo: SwiperAnimationEvent) => {
            this.isDragging = true
            this.imageScale = 0.95
            this.imageBrightness = 0.85
          })
          .onAnimationStart((index: number, targetIndex: number, extraInfo: SwiperAnimationEvent) => {
            this.isDragging = true
          })
          .onAnimationEnd((index: number, extraInfo: SwiperAnimationEvent) => {
            this.isDragging = false
            this.imageScale = 1
            this.imageBrightness = 1
          })
          .width('100%')
          .height(480)

          Row() {
            Button() {
              SymbolGlyph($r('sys.symbol.arrow_left'))
                .fontSize(20)
                .fontColor(['#FFFFFF'])
            }
            .width(40)
            .height(40)
            .backgroundColor('rgba(0,0,0,0.3)')
            .borderRadius(20)
            .onClick(() => {
              this.swiperController.showPrevious()
            })

            Blank()

            Button() {
              SymbolGlyph($r('sys.symbol.arrow_right'))
                .fontSize(20)
                .fontColor(['#FFFFFF'])
            }
            .width(40)
            .height(40)
            .backgroundColor('rgba(0,0,0,0.3)')
            .borderRadius(20)
            .onClick(() => {
              this.swiperController.showNext()
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
          .position({ y: 220 })
        }
        .width('100%')
        .height(480)

        Stack({ alignContent: Alignment.Top }) {
          this.TriangleIndicator()

          Row() {
            ForEach(this.images, (_: Resource, index: number) => {
              this.DotIndicator(index)
            })
          }
          .width('100%')
          .height(48)
          .justifyContent(FlexAlign.Center)
          .margin({ top: 16 })
        }
        .width('100%')
        .height(80)
        .padding({ top: 8 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#0F0F0F')
      .padding({ top: 40, bottom: 40 })

      Column() {
        Text('Swipe to explore')
          .fontSize(12)
          .fontColor('rgba(255,255,255,0.3)')
          .margin({ bottom: 8 })
      }
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F0F0F')
  }
}