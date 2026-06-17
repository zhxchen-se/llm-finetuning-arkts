import image from '@ohos.multimedia.image';

@Entry
@Component
struct Index {
  @State pixelMaps: (image.PixelMap | null)[] = [null, null, null];
  @State currentIndex: number = 0;
  @State isPlaying: boolean = false;
  private intervalId: number = -1;

  async aboutToAppear() {
    await this.createPixelMaps();
  }

  aboutToDisappear() {
    this.stopAnimation();
    this.pixelMaps.forEach(pm => {
      if (pm) {
        pm.release();
      }
    });
  }

  async createPixelMaps() {
    const width = 300;
    const height = 300;
    const colors = [
      [220, 50, 50],   // Red
      [50, 180, 50],   // Green
      [50, 100, 220]   // Blue
    ];

    for (let i = 0; i < colors.length; i++) {
      const buffer = new ArrayBuffer(width * height * 4);
      const data = new Uint8Array(buffer);
      
      for (let j = 0; j < width * height; j++) {
        const x = j % width;
        const y = Math.floor(j / width);
        
        let r = colors[i][0];
        let g = colors[i][1];
        let b = colors[i][2];
        
        // Draw a white border
        if (x < 10 || x > width - 10 || y < 10 || y > height - 10) {
          r = 255; g = 255; b = 255;
        }
        
        // Draw a white cross in the center
        const cx = width / 2;
        const cy = height / 2;
        if ((Math.abs(x - cx) < 30 && Math.abs(y - cy) < 10) || (Math.abs(x - cx) < 10 && Math.abs(y - cy) < 30)) {
          r = 255; g = 255; b = 255;
        }
        
        data[j * 4] = r;
        data[j * 4 + 1] = g;
        data[j * 4 + 2] = b;
        data[j * 4 + 3] = 255;
      }
      
      const opts: image.PixelMapOptions = {
        size: { width: width, height: height },
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        alphaType: image.AlphaType.OPAQUE,
        editable: true
      };
      this.pixelMaps[i] = await image.createPixelMap(buffer, opts);
    }
  }

  startAnimation() {
    if (this.isPlaying) return;
    this.isPlaying = true;
    this.intervalId = setInterval(() => {
      this.currentIndex = (this.currentIndex + 1) % 3;
    }, 1500);
  }

  stopAnimation() {
    this.isPlaying = false;
    clearInterval(this.intervalId);
  }

  nextFrame() {
    this.currentIndex = (this.currentIndex + 1) % 3;
  }

  build() {
    Column({ space: 20 }) {
      Text('PixelMap Animation')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
      
      Text('Frame-by-frame animation with transition effects')
        .fontSize(16)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
        .width('80%')

      Stack() {
        if (this.currentIndex === 0 && this.pixelMaps[0]) {
          Image(this.pixelMaps[0])
            .width(300).height(300)
            .transition(
              TransitionEffect.OPACITY
                .combine(TransitionEffect.scale({ x: 0.9, y: 0.9 }))
                .animation({ duration: 500, curve: Curve.EaseInOut })
            )
        } else if (this.currentIndex === 1 && this.pixelMaps[1]) {
          Image(this.pixelMaps[1])
            .width(300).height(300)
            .transition(
              TransitionEffect.OPACITY
                .combine(TransitionEffect.scale({ x: 0.9, y: 0.9 }))
                .animation({ duration: 500, curve: Curve.EaseInOut })
            )
        } else if (this.currentIndex === 2 && this.pixelMaps[2]) {
          Image(this.pixelMaps[2])
            .width(300).height(300)
            .transition(
              TransitionEffect.OPACITY
                .combine(TransitionEffect.scale({ x: 0.9, y: 0.9 }))
                .animation({ duration: 500, curve: Curve.EaseInOut })
            )
        }
      }
      .width(300)
      .height(300)
      .borderRadius(16)
      .clip(true)
      .shadow({ radius: 10, color: '#aaaaaa', offsetY: 4 })
      .alignContent(Alignment.Center)

      Text(`Current Frame: ${this.currentIndex + 1} / 3`)
        .fontSize(18)
        .margin({ top: 10 })

      Row({ space: 20 }) {
        Button(this.isPlaying ? 'Pause' : 'Play')
          .onClick(() => {
            if (this.isPlaying) {
              this.stopAnimation();
            } else {
              this.startAnimation();
            }
          })
          .width(120)

        Button('Next Frame')
          .onClick(() => {
            this.nextFrame();
          })
          .width(120)
      }
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}