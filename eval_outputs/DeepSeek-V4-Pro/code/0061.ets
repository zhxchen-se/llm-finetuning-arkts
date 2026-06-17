import { image } from '@ohos.multimedia.image';
import { BusinessError } from '@ohos.base';

@Entry
@Component
struct Index {
  @State pixelMaps: PixelMap[] = [];
  @State currentFrameIndex: number = 0;
  @State isPlaying: boolean = false;
  @State fps: number = 5; // frames per second
  @State loopEnabled: boolean = true;
  @State repeatCount: number = 1; // used when loopEnabled is false
  @State currentRepeat: number = 0; // remaining repeats for current cycle
  private timerId: number = -1;

  // Generate a solid color PixelMap of given size
  private async createColorPixelMap(color: string, width: number, height: number): Promise<PixelMap> {
    // Parse hex color to RGBA
    const hex = color.replace('#', '');
    const r = parseInt(hex.substring(0, 2), 16);
    const g = parseInt(hex.substring(2, 4), 16);
    const b = parseInt(hex.substring(4, 6), 16);
    const a = 255;

    // Create pixel map
    const pixelMap = await image.createPixelMap({
      size: { width: width, height: height },
      pixelFormat: image.PixelMapFormat.RGBA_8888,
      editable: true
    });

    // Fill buffer with color
    const bufferSize = width * height * 4;
    const buffer = new ArrayBuffer(bufferSize);
    const view = new Uint8Array(buffer);
    for (let i = 0; i < bufferSize; i += 4) {
      view[i] = r;     // R
      view[i + 1] = g; // G
      view[i + 2] = b; // B
      view[i + 3] = a; // A
    }

    // Write pixels to the pixel map
    await pixelMap.writePixels({
      pixels: buffer,
      offset: 0,
      stride: width * 4,
      region: { size: { width: width, height: height }, x: 0, y: 0 }
    });

    return pixelMap;
  }

  async aboutToAppear(): Promise<void> {
    // Create a set of colored frames
    const colors = ['#FF0000', '#00FF00', '#0000FF', '#FFFF00', '#FF00FF'];
    const width = 200;
    const height = 200;
    const maps: PixelMap[] = [];
    for (const color of colors) {
      const pm = await this.createColorPixelMap(color, width, height);
      maps.push(pm);
    }
    this.pixelMaps = maps;
  }

  aboutToDisappear(): void {
    this.stopAnimation();
  }

  // Start or restart the animation timer based on current fps
  private startAnimation(): void {
    this.stopAnimation();
    if (!this.isPlaying || this.pixelMaps.length === 0) return;

    const interval = Math.round(1000 / this.fps);
    this.timerId = setInterval(() => {
      this.nextFrame();
    }, interval);
  }

  private stopAnimation(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  private nextFrame(): void {
    if (this.pixelMaps.length === 0) return;

    const nextIndex = this.currentFrameIndex + 1;
    if (nextIndex < this.pixelMaps.length) {
      this.currentFrameIndex = nextIndex;
    } else {
      // End of sequence
      if (this.loopEnabled) {
        this.currentFrameIndex = 0;
      } else {
        // Non-looping: check remaining repeats
        if (this.currentRepeat > 1) {
          this.currentRepeat--;
          this.currentFrameIndex = 0;
        } else {
          // Animation finished
          this.isPlaying = false;
          this.stopAnimation();
        }
      }
    }
  }

  // Toggle play/pause
  private togglePlay(): void {
    if (this.pixelMaps.length === 0) return;

    if (this.isPlaying) {
      this.isPlaying = false;
      this.stopAnimation();
    } else {
      // If we were stopped at the end and not looping, reset to start
      if (!this.loopEnabled && this.currentFrameIndex === this.pixelMaps.length - 1 && this.currentRepeat <= 1) {
        this.currentFrameIndex = 0;
        this.currentRepeat = this.repeatCount;
      }
      this.isPlaying = true;
      this.startAnimation();
    }
  }

  // Called when fps changes while playing
  @Watch('onFpsChange')
  onFpsChange(): void {
    if (this.isPlaying) {
      this.startAnimation(); // restart timer with new interval
    }
  }

  // Called when loopEnabled changes
  @Watch('onLoopChange')
  onLoopChange(): void {
    if (this.isPlaying) {
      // If loop is turned off while playing, we need to set currentRepeat appropriately
      if (!this.loopEnabled) {
        this.currentRepeat = this.repeatCount;
      }
    }
  }

  build() {
    Column() {
      // Animation display
      if (this.pixelMaps.length > 0) {
        Image(this.pixelMaps[this.currentFrameIndex])
          .width(200)
          .height(200)
          .objectFit(ImageFit.Contain)
          .border({ width: 2, color: '#000000' })
      } else {
        Text('Loading frames...')
          .width(200)
          .height(200)
          .textAlign(TextAlign.Center)
          .backgroundColor('#F0F0F0')
      }

      Text(`Frame: ${this.currentFrameIndex + 1} / ${this.pixelMaps.length}`)
        .fontSize(16)
        .margin({ top: 8 })

      // Play/Pause button
      Button(this.isPlaying ? 'Pause' : 'Play')
        .width(120)
        .margin({ top: 16 })
        .onClick(() => this.togglePlay())

      // Speed control (FPS)
      Row() {
        Text('Speed (FPS):')
        Slider({
          value: this.fps,
          min: 1,
          max: 30,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('60%')
          .onChange((value: number) => {
            this.fps = value;
          })
        Text(`${this.fps}`)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 16 })

      // Loop control
      Row() {
        Text('Loop:')
        Toggle({ type: ToggleType.Switch, isOn: this.loopEnabled })
          .onChange((isOn: boolean) => {
            this.loopEnabled = isOn;
            if (!isOn) {
              this.currentRepeat = this.repeatCount;
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 8 })

      // Repeat count (only when not looping)
      if (!this.loopEnabled) {
        Row() {
          Text('Repeat count:')
          TextInput({ text: this.repeatCount.toString() })
            .type(InputType.Number)
            .width(80)
            .onChange((value: string) => {
              const num = parseInt(value);
              if (!isNaN(num) && num > 0) {
                this.repeatCount = num;
                this.currentRepeat = num;
              }
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 8 })
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
  }
}