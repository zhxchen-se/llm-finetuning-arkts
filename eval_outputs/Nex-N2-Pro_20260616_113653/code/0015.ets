@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State offsetX: number = 0;
  @State opacity: number = 1;
  @State isAutoPlay: boolean = true;

  private items: string[] = [
    'First String Item',
    'Second String Item',
    'Third String Item',
    'Fourth String Item',
    'Fifth String Item'
  ];

  private isAnimating: boolean = false;
  private timer: number = -1;

  aboutToAppear(): void {
    this.startAutoPlay();
  }

  aboutToDisappear(): void {
    this.stopAutoPlay();
  }

  startAutoPlay(): void {
    if (this.timer !== -1) {
      return;
    }

    this.timer = setTimeout(() => {
      this.timer = -1;

      if (this.isAutoPlay) {
        this.slideItem(1);
        this.startAutoPlay();
      }
    }, 1800);
  }

  stopAutoPlay(): void {
    if (this.timer !== -1) {
      clearTimeout(this.timer);
      this.timer = -1;
    }
  }

  toggleAutoPlay(): void {
    this.isAutoPlay = !this.isAutoPlay;

    if (this.isAutoPlay) {
      this.startAutoPlay();
    } else {
      this.stopAutoPlay();
    }
  }

  slideItem(delta: number): void {
    if (this.isAnimating || this.items.length <= 1) {
      return;
    }

    this.isAnimating = true;

    const total: number = this.items.length;
    const distance: number = 120;
    const targetOffset: number = delta * distance;

    animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
      this.offsetX = targetOffset;
      this.opacity = 0;
    }, () => {
      this.currentIndex = (this.currentIndex + delta + total) % total;
      this.offsetX = -targetOffset;
      this.opacity = 0;

      animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
        this.offsetX = 0;
        this.opacity = 1;
      }, () => {
        this.isAnimating = false;
      });
    });
  }

  build() {
    Column() {
      Text('String Items')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .margin({ bottom: 12 })

      Text('Items are displayed one by one with a sliding animation')
        .fontSize(16)
        .fontColor('#6B7280')
        .margin({ bottom: 36 })

      Stack() {
        Text(this.items[this.currentIndex])
          .width('82%')
          .height(120)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .offset({ x: this.offsetX, y: 0 })
          .opacity(this.opacity)
      }
        .width('90%')
        .height(180)
        .backgroundColor('#2563EB')
        .borderRadius(24)
        .margin({ bottom: 32 })

      Text(`${this.currentIndex + 1} / ${this.items.length}`)
        .fontSize(18)
        .fontColor('#374151')
        .margin({ bottom: 28 })

      Row() {
        Button('Previous')
          .width(130)
          .height(46)
          .backgroundColor('#4F46E5')
          .fontColor('#FFFFFF')
          .onClick(() => {
            this.slideItem(-1);
          })

        Button(this.isAutoPlay ? 'Pause Auto Play' : 'Start Auto Play')
          .width(150)
          .height(46)
          .backgroundColor(this.isAutoPlay ? '#059669' : '#DC2626')
          .fontColor('#FFFFFF')
          .margin({ left: 16, right: 16 })
          .onClick(() => {
            this.toggleAutoPlay();
          })

        Button('Next')
          .width(130)
          .height(46)
          .backgroundColor('#4F46E5')
          .fontColor('#FFFFFF')
          .onClick(() => {
            this.slideItem(1);
          })
      }
        .width('100%')
        .alignItems(VerticalAlign.Center)
    }
      .width('100%')
      .height('100%')
      .padding(24)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#F3F4F6')
  }
}