// entry/src/main/ets/pages/Index.ets
import { image } from '@kit.ImageKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State frames: image.PixelMap[] = [];
  @State currentFrameIndex: number = 0;
  @State isPlaying: boolean = true;
  @State opacity: number = 1;
  @State animating: boolean = false;
  @State framesReady: boolean = false;
  private timer: number = -1;
  private readonly colors: string[] = [
    '#FF0000', '#00FF00', '#0000FF', '#FFFF00', '#FF00FF', '#00FFFF'
  ];

  aboutToAppear(): void {
    this.createFrames();
  }

  aboutToDisappear(): void {
    this.stopTimer();
    // Release pixel maps
    this.frames.forEach((pm) => {
      if (pm) {
        pm.release();
      }
    });
  }

  async createFrames(): Promise<void> {
    try {
      const promises = this.colors.map((color) => this.createColorPixelMap(color));
      const maps = await Promise.all(promises);
      this.frames = maps;
      this.framesReady = true;
      if (this.isPlaying) {
        this.startTimer();
      }
    } catch (err) {
      console.error('Failed to create frames: ' + JSON.stringify(err));
    }
  }

  async createColorPixelMap(color: string): Promise<image.PixelMap> {
    const opts: image.InitializationOptions = {
      size: { width: 200, height: 200 },
      pixelFormat: image.PixelMapFormat.RGBA_8888,
      editable: true
    };
    const pixelMap = await image.createPixelMap(opts);
    const buffer = new ArrayBuffer(200 * 200 * 4);
    const view = new Uint8Array(buffer);
    // Parse hex color
    const r = parseInt(color.slice(1, 3), 16);
    const g = parseInt(color.slice(3, 5), 16);
    const b = parseInt(color.slice(5, 7), 16);
    const a = 255;
    for (let i = 0; i < 200 * 200; i++) {
      const offset = i * 4;
      view[offset] = r;     // R
      view[offset + 1] = g; // G
      view[offset + 2] = b; // B
      view[offset + 3] = a; // A
    }
    await pixelMap.writeBufferToPixels(buffer);
    return pixelMap;
  }

  startTimer(): void {
    if (this.timer !== -1) {
      clearInterval(this.timer);
    }
    this.timer = setInterval(() => {
      if (this.isPlaying && !this.animating) {
        this.playNextFrame();
      }
    }, 1500); // Change frame every 1.5 seconds
  }

  stopTimer(): void {
    if (this.timer !== -1) {
      clearInterval(this.timer);
      this.timer = -1;
    }
  }

  playNextFrame(): void {
    if (this.animating || this.frames.length === 0) return;
    this.animating = true;
    // Fade out
    animateTo({
      duration: 300,
      curve: Curve.EaseInOut,
      onFinish: () => {
        // Change frame
        this.currentFrameIndex = (this.currentFrameIndex + 1) % this.frames.length;
        // Fade in
        animateTo({
          duration: 300,
          curve: Curve.EaseInOut,
          onFinish: () => {
            this.animating = false;
          }
        }, () => {
          this.opacity = 1;
        });
      }
    }, () => {
      this.opacity = 0;
    });
  }

  togglePlayPause(): void {
    this.isPlaying = !this.isPlaying;
    if (this.isPlaying) {
      this.startTimer();
    } else {
      this.stopTimer();
    }
  }

  build() {
    Column() {
      if (!this.framesReady) {
        Text('Loading frames...')
          .fontSize(20)
          .margin({ top: 50 });
      } else {
        // Animation display
        Image(this.frames[this.currentFrameIndex])
          .width(200)
          .height(200)
          .opacity(this.opacity)
          .objectFit(ImageFit.Contain)
          .borderRadius(10)
          .margin({ top: 30 });

        // Frame indicator
        Text(`Frame: ${this.currentFrameIndex + 1} / ${this.frames.length}`)
          .fontSize(18)
          .margin({ top: 20 });

        // Play/Pause button
        Button(this.isPlaying ? 'Pause' : 'Play')
          .fontSize(18)
          .margin({ top: 20 })
          .onClick(() => {
            this.togglePlayPause();
          });
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F1F3F5');
  }
}