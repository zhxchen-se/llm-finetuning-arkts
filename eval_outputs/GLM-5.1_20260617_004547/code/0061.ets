import image from '@ohos.multimedia.image'

@Entry
@Component
struct Index {
  @State currentFrameIndex: number = 0
  @State isPlaying: boolean = false
  @State fps: number = 10
  @State maxRepeats: number = 3
  @State currentRepeat: number = 0
  @State totalFrames: number = 16
  @State infiniteLoop: boolean = true
  @State repeatInput: string = '3'
  @State pixelMaps: PixelMap[] = []
  @State currentPixelMap: PixelMap | undefined = undefined
  @State isReady: boolean = false
  @State statusText: string = 'Loading'
  @State isCompleted: boolean = false
  @State generatedCount: number = 0

  private timeoutId: number = -1
  private frameWidth: number = 240
  private frameHeight: number = 240

  private hsvToRgb(h: number, s: number, v: number): number[] {
    let r: number = 0
    let g: number = 0
    let b: number = 0
    const i: number = Math.floor(h * 6)
    const f: number = h * 6 - i
    const p: number = v * (1 - s)
    const q: number = v * (1 - f * s)
    const t: number = v * (1 - (1 - f) * s)
    switch (i % 6) {
      case 0: r = v; g = t; b = p; break
      case 1: r = q; g = v; b = p; break
      case 2: r = p; g = v; b = t; break
      case 3: r = p; g = q; b = v; break
      case 4: r = t; g = p; b = v; break
      case 5: r = v; g = p; b = q; break
    }
    return [Math.floor(r * 255), Math.floor(g * 255), Math.floor(b * 255)]
  }

  aboutToAppear() {
    this.generatePixelMaps()
  }

  async generatePixelMaps() {
    const w: number = this.frameWidth
    const h: number = this.frameHeight
    const cx: number = w / 2
    const cy: number = h / 2
    const tempMaps: PixelMap[] = []

    for (let f = 0; f < this.totalFrames; f++) {
      const buffer: ArrayBuffer = new ArrayBuffer(w * h * 4)
      const data: Uint8Array = new Uint8Array(buffer)
      const phase: number = f / this.totalFrames

      for (let y = 0; y < h; y++) {
        for (let x = 0; x < w; x++) {
          const idx: number = (y * w + x) * 4
          const dx: number = x - cx
          const dy: number = y - cy
          const dist: number = Math.sqrt(dx * dx + dy * dy)
          const angle: number = Math.atan2(dy, dx)

          const wave1: number = Math.sin(dist * 0.1 - phase * Math.PI * 2) * 0.5 + 0.5
          const wave2: number = Math.sin(angle * 4 + phase * Math.PI * 2) * 0.5 + 0.5
          const wave3: number = Math.sin((x + y) * 0.05 + phase * Math.PI * 4) * 0.5 + 0.5

          const hue: number = ((wave1 * 0.3 + wave2 * 0.3 + wave3 * 0.3 + phase) % 1 + 1) % 1
          const sat: number = 0.6 + 0.4 * wave1
          const val: number = 0.4 + 0.6 * wave2

          const rgb: number[] = this.hsvToRgb(hue, Math.max(0, Math.min(1, sat)), Math.max(0, Math.min(1, val)))
          data[idx] = rgb[0]
          data[idx + 1] = rgb[1]
          data[idx + 2] = rgb[2]
          data[idx + 3] = 255
        }
      }

      try {
        const pm: PixelMap = await image.createPixelMap(buffer, {
          size: { width: w, height: h },
          pixelFormat: image.PixelFormat.RGBA_8888,
          editable: true
        })
        tempMaps.push(pm)
        this.generatedCount = tempMaps.length
      } catch (e) {
        console.error('PixelMap creation failed: ' + JSON.stringify(e))
      }
    }

    this.pixelMaps = tempMaps
    if (this.pixelMaps.length > 0) {
      this.currentPixelMap = this.pixelMaps[0]
      this.isReady = true
      this.statusText = 'Ready'
    } else {
      this.statusText = 'Error'
    }
  }

  scheduleNextFrame() {
    if (!this.isPlaying) return
    const delay: number = Math.max(16, Math.floor(1000 / this.fps))
    this.timeoutId = setTimeout(() => {
      this.advanceFrame()
      if (this.isPlaying) {
        this.scheduleNextFrame()
      }
    }, delay)
  }

  advanceFrame() {
    let nextFrame: number = this.currentFrameIndex + 1
    if (nextFrame >= this.totalFrames) {
      nextFrame = 0
      this.currentRepeat++
      if (!this.infiniteLoop && this.currentRepeat >= this.maxRepeats) {
        this.isPlaying = false
        this.isCompleted = true
        this.statusText = 'Completed'
        this.currentFrameIndex = this.totalFrames - 1
        this.currentPixelMap = this.pixelMaps[this.currentFrameIndex]
        return
      }
    }
    this.currentFrameIndex = nextFrame
    this.currentPixelMap = this.pixelMaps[this.currentFrameIndex]
  }

  play() {
    if (!this.isReady) return
    if (this.isCompleted) {
      this.currentFrameIndex = 0
      this.currentRepeat = 0
      this.isCompleted = false
    }
    this.isPlaying = true
    this.statusText = 'Playing'
    this.scheduleNextFrame()
  }

  pause() {
    this.isPlaying = false
    if (this.timeoutId !== -1) {
      clearTimeout(this.timeoutId)
      this.timeoutId = -1
    }
    this.statusText = 'Paused'
  }

  stop() {
    this.isPlaying = false
    this.isCompleted = false
    if (this.timeoutId !== -1) {
      clearTimeout(this.timeoutId)
      this.timeoutId = -1
    }
    this.currentFrameIndex = 0
    this.currentRepeat = 0
    if (this.pixelMaps.length > 0) {
      this.currentPixelMap = this.pixelMaps[0]
    }
    this.statusText = 'Stopped'
  }

  stepForward() {
    if (this.isPlaying || !this.isReady) return
    this.isCompleted = false
    let next: number = this.currentFrameIndex + 1
    if (next >= this.totalFrames) {
      next = 0
    }
    this.currentFrameIndex = next
    this.currentPixelMap = this.pixelMaps[this.currentFrameIndex]
  }

  stepBackward() {
    if (this.isPlaying || !this.isReady) return
    this.isCompleted = false
    let prev: number = this.currentFrameIndex - 1
    if (prev < 0) {
      prev = this.totalFrames - 1
    }
    this.currentFrameIndex = prev
    this.currentPixelMap = this.pixelMaps[this.currentFrameIndex]
  }

  goToFrame(index: number) {
    if (!this.isReady) return
    if (index >= 0 && index < this.pixelMaps.length) {
      this.currentFrameIndex = index
      this.currentPixelMap = this.pixelMaps[index]
    }
  }

  aboutToDisappear() {
    if (this.timeoutId !== -1) {
      clearTimeout(this.timeoutId)
    }
    this.pixelMaps.forEach((pm: PixelMap) => {
      try {
        pm.release()
      } catch (e) {
      }
    })
  }

  @Builder
  controlButton(label: string, isActive: boolean, action: () => void) {
    Button(label)
      .height(36)
      .fontSize(13)
      .fontColor(isActive ? '#FFFFFF' : '#CCCCCC')
      .backgroundColor(isActive ? '#4CAF50' : '#1E1E1E')
      .borderRadius(8)
      .onClick(action)
      .layoutWeight(1)
  }

  build() {
    Scroll() {
      Column() {
        // Header
        Column() {
          Text('Pixel Map Animation')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          Text('Frame-by-frame playback with PixelMap array')
            .fontSize(13)
            .fontColor('#777777')
            .margin({ top: 4 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .margin({ bottom: 24 })

        // Animation display
        Column() {
          if (this.isReady && this.currentPixelMap) {
            Image(this.currentPixelMap)
              .width(this.frameWidth)
              .height(this.frameHeight)
              .objectFit(ImageFit.Fill)
              .interpolation(ImageInterpolation.Low)
          } else {
            Column() {
              LoadingProgress()
                .width(50)
                .height(50)
                .color('#4CAF50')
              Text(`Generating frames... ${this.generatedCount}/${this.totalFrames}`)
                .fontSize(13)
                .fontColor('#888888')
                .margin({ top: 12 })
            }
            .width(this.frameWidth)
            .height(this.frameHeight)
            .justifyContent(FlexAlign.Center)
          }
        }
        .borderRadius(12)
        .border({
          width: this.isPlaying ? 2 : 1,
          color: this.isPlaying ? '#4CAF50' : '#333333'
        })
        .backgroundColor('#0A0A0A')
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .shadow(this.isPlaying ? {
          radius: 20,
          color: '#1B4CAF50',
          offsetX: 0,
          offsetY: 0
        } : { radius: 0, color: '#00000000', offsetX: 0, offsetY: 0 })
        .animation({ duration: 300 })

        // Info row
        Row() {
          Column() {
            Text('Frame')
              .fontSize(10)
              .fontColor('#666666')
              .margin({ bottom: 2 })
            Text(`${this.currentFrameIndex + 1} / ${this.totalFrames}`)
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#E0E0E0')
          }
          Column() {
            Text('Repeat')
              .fontSize(10)
              .fontColor('#666666')
              .margin({ bottom: 2 })
            Text(this.infiniteLoop ? '∞' : `${this.currentRepeat} / ${this.maxRepeats}`)
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#E0E0E0')
          }
          Column() {
            Text('Status')
              .fontSize(10)
              .fontColor('#666666')
              .margin({ bottom: 2 })
            Text(this.statusText)
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.isPlaying ? '#4CAF50' : this.isCompleted ? '#FF9800' : '#E0E0E0')
          }
          Column() {
            Text('Speed')
              .fontSize(10)
              .fontColor('#666666')
              .margin({ bottom: 2 })
            Text(`${this.fps} FPS`)
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#E0E0E0')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 16 })

        // Progress bar
        Progress({
          value: this.currentFrameIndex + 1,
          total: this.totalFrames,
          type: ProgressType.Linear
        })
          .width('100%')
          .margin({ top: 12 })
          .color('#4CAF50')
          .backgroundColor('#1A1A1A')

        // Frame scrubber
        Row() {
          Text('0')
            .fontSize(10)
            .fontColor('#555555')
            .width(16)
            .textAlign(TextAlign.Center)
          Slider({
            value: this.currentFrameIndex,
            min: 0,
            max: this.totalFrames - 1,
            step: 1,
            style: SliderStyle.InSet
          })
            .layoutWeight(1)
            .selectedColor('#4CAF50')
            .trackColor('#1A1A1A')
            .blockColor('#FFFFFF')
            .onChange((value: number) => {
              if (!this.isPlaying) {
                this.goToFrame(Math.floor(value))
              }
            })
          Text(`${this.totalFrames - 1}`)
            .fontSize(10)
            .fontColor('#555555')
            .width(20)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .margin({ top: 8 })

        // Playback controls
        Row() {
          Button({ type: ButtonType.Circle }) {
            Text('⏮').fontSize(16).fontColor('#E0E0E0')
          }
          .width(46)
          .height(46)
          .backgroundColor('#1E1E1E')
          .onClick(() => this.goToFrame(0))

          Button({ type: ButtonType.Circle }) {
            Text('◀').fontSize(16).fontColor('#E0E0E0')
          }
          .width(46)
          .height(46)
          .backgroundColor('#1E1E1E')
          .onClick(() => this.stepBackward())

          Button({ type: ButtonType.Circle }) {
            Text(this.isCompleted ? '↻' : (this.isPlaying ? '⏸' : '▶'))
              .fontSize(this.isCompleted ? 24 : (this.isPlaying ? 18 : 24))
              .fontColor('#FFFFFF')
          }
          .width(64)
          .height(64)
          .backgroundColor(this.isCompleted ? '#FF9800' : '#4CAF50')
          .onClick(() => {
            if (this.isPlaying) {
              this.pause()
            } else {
              this.play()
            }
          })

          Button({ type: ButtonType.Circle }) {
            Text('▶').fontSize(16).fontColor('#E0E0E0')
          }
          .width(46)
          .height(46)
          .backgroundColor('#1E1E1E')
          .onClick(() => this.stepForward())

          Button({ type: ButtonType.Circle }) {
            Text('⏹').fontSize(16).fontColor('#E0E0E0')
          }
          .width(46)
          .height(46)
          .backgroundColor('#1E1E1E')
          .onClick(() => this.stop())
        }
        .margin({ top: 16 })
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')

        // Section: Speed Control
        Column() {
          Row() {
            Text('Speed Control')
              .fontSize(17)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E0E0E0')
            Blank()
            Text(`${this.fps} FPS`)
              .fontSize(14)
              .fontColor('#4CAF50')
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .margin({ bottom: 12 })

          Row() {
            Text('1')
              .fontSize(11)
              .fontColor('#666666')
              .width(16)
            Slider({
              value: this.fps,
              min: 1,
              max: 30,
              step: 1,
              style: SliderStyle.OutSet
            })
              .layoutWeight(1)
              .selectedColor('#4CAF50')
              .trackColor('#1A1A1A')
              .blockColor('#FFFFFF')
              .onChange((value: number) => {
                this.fps = Math.floor(value)
              })
            Text('30')
              .fontSize(11)
              .fontColor('#666666')
              .width(20)
          }
          .width('100%')

          // Speed presets
          Row({ space: 6 }) {
            this.controlButton('1x', this.fps === 1, () => { this.fps = 1 })
            this.controlButton('5x', this.fps === 5, () => { this.fps = 5 })
            this.controlButton('10x', this.fps === 10, () => { this.fps = 10 })
            this.controlButton('15x', this.fps === 15, () => { this.fps = 15 })
            this.controlButton('24x', this.fps === 24, () => { this.fps = 24 })
            this.controlButton('30x', this.fps === 30, () => { this.fps = 30 })
          }
          .width('100%')
          .margin({ top: 10 })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#141414')
        .borderRadius(12)
        .margin({ top: 24 })

        // Section: Repetition Control
        Column() {
          Text('Repetition Control')
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E0E0E0')
            .width('100%')
            .margin({ bottom: 12 })

          Row() {
            Toggle({ type: ToggleType.Switch, isOn: this.infiniteLoop })
              .onChange((isOn: boolean) => {
                this.infiniteLoop = isOn
                if (!isOn) {
                  const num: number = parseInt(this.repeatInput)
                  if (!isNaN(num) && num > 0) {
                    this.maxRepeats = num
                  }
                }
              })
              .selectedColor('#4CAF50')
            Text('Infinite Loop')
              .fontSize(14)
              .fontColor('#E0E0E0')
              .margin({ left: 12 })
            Blank()
            if (this.infiniteLoop) {
              Text('∞')
                .fontSize(20)
                .fontColor('#4CAF50')
                .fontWeight(FontWeight.Bold)
            }
          }
          .width('100%')

          if (!this.infiniteLoop) {
            Column() {
              Row() {
                Text('Repeat Count:')
                  .fontSize(14)
                  .fontColor('#CCCCCC')
                Blank()
                TextInput({ text: this.repeatInput, placeholder: 'Count' })
                  .type(InputType.Number)
                  .width(90)
                  .height(38)
                  .backgroundColor('#1E1E1E')
                  .fontColor('#E0E0E0')
                  .borderRadius(8)
                  .padding({ left: 8, right: 8 })
                  .onChange((value: string) => {
                    this.repeatInput = value
                    const num: number = parseInt(value)
                    if (!isNaN(num) && num > 0) {
                      this.maxRepeats = num
                    }
                  })
              }
              .width('100%')
              .margin({ top: 12 })

              Row({ space: 6 }) {
                this.controlButton('1x', this.maxRepeats === 1, () => {
                  this.maxRepeats = 1
                  this.repeatInput = '1'
                })
                this.controlButton('2x', this.maxRepeats === 2, () => {
                  this.maxRepeats = 2
                  this.repeatInput = '2'
                })
                this.controlButton('3x', this.maxRepeats === 3, () => {
                  this.maxRepeats = 3
                  this.repeatInput = '3'
                })
                this.controlButton('5x', this.maxRepeats === 5, () => {
                  this.maxRepeats = 5
                  this.repeatInput = '5'
                })
                this.controlButton('10x', this.maxRepeats === 10, () => {
                  this.maxRepeats = 10
                  this.repeatInput = '10'
                })
              }
              .width('100%')
              .margin({ top: 10 })
            }
            .width('100%')
          }
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#141414')
        .borderRadius(12)
        .margin({ top: 12 })
        .alignItems(HorizontalAlign.Start)

        // Section: Frame Thumbnails
        Column() {
          Row() {
            Text('Frame Thumbnails')
              .fontSize(17)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E0E0E0')
            Blank()
            Text(`${this.pixelMaps.length} frames`)
              .fontSize(12)
              .fontColor('#666666')
          }
          .width('100%')
          .margin({ bottom: 12 })

          if (this.isReady && this.pixelMaps.length > 0) {
            List({ space: 8 }) {
              ForEach(this.pixelMaps, (pm: PixelMap, index?: number) => {
                ListItem() {
                  Column() {
                    Image(pm)
                      .width(52)
                      .height(52)
                      .objectFit(ImageFit.Fill)
                      .borderRadius(4)
                      .border({
                        width: this.currentFrameIndex === (index ?? 0) ? 2 : 1,
                        color: this.currentFrameIndex === (index ?? 0) ? '#4CAF50' : '#333333'
                      })
                    Text(`${(index ?? 0) + 1}`)
                      .fontSize(9)
                      .fontColor(this.currentFrameIndex === (index ?? 0) ? '#4CAF50' : '#888888')
                      .margin({ top: 2 })
                  }
                  .onClick(() => {
                    if (!this.isPlaying && index !== undefined) {
                      this.goToFrame(index)
                    }
                  })
                }
              }, (_pm: PixelMap, index?: number) => `frame_${index}`)
            }
            .listDirection(Axis.Horizontal)
            .width('100%')
            .height(76)
            .scrollBar(BarState.Off)
          } else {
            Row() {
              LoadingProgress()
                .width(24)
                .height(24)
                .color('#4CAF50')
              Text('Generating pixel maps...')
                .fontSize(13)
                .fontColor('#666666')
                .margin({ left: 8 })
            }
          }
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#141414')
        .borderRadius(12)
        .margin({ top: 12 })

        // Footer info
        Column() {
          Text(`Resolution: ${this.frameWidth}×${this.frameHeight} | Format: RGBA_8888`)
            .fontSize(11)
            .fontColor('#555555')
          Text(`Memory: ~${((this.frameWidth * this.frameHeight * 4 * this.totalFrames) / 1024).toFixed(0)} KB`)
            .fontSize(11)
            .fontColor('#555555')
            .margin({ top: 2 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 16, bottom: 8 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 24, bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0D0D0D')
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)
  }
}