import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State currentTab: number = 0

  build() {
    Column() {
      // Title Bar
      Row() {
        Text('Image Resizing Techniques')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#1976D2')
      .justifyContent(FlexAlign.Center)

      Tabs({ index: this.currentTab }) {
        TabContent() {
          Scroll() {
            ObjectFitDemo()
          }
          .scrollBar(BarState.Auto)
        }
        .tabBar('ObjectFit')

        TabContent() {
          Scroll() {
            AspectRatioDemo()
          }
          .scrollBar(BarState.Auto)
        }
        .tabBar('Aspect Ratio')

        TabContent() {
          Scroll() {
            DirectionalResizeDemo()
          }
          .scrollBar(BarState.Auto)
        }
        .tabBar('Directional')

        TabContent() {
          Scroll() {
            ObjectRepeatDemo()
          }
          .scrollBar(BarState.Auto)
        }
        .tabBar('Repeat')
      }
      .barMode(BarMode.Scrollable)
      .barBackgroundColor('#E3F2FD')
      .barActiveColor('#1976D2')
      .onChange((index: number) => {
        this.currentTab = index
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct ObjectFitDemo {
  build() {
    Column({ space: 16 }) {
      Text('ObjectFit Modes')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 12 })
        .fontColor('#333333')

      Text('Same image in 200×150 containers with different fit modes')
        .fontSize(13)
        .fontColor('#777777')
        .margin({ bottom: 4 })

      // Contain
      this.ObjectFitCard('Contain', 'Scales to fit within bounds, aspect ratio preserved',
        ImageFit.Contain)

      // Cover
      this.ObjectFitCard('Cover', 'Scales to fill bounds, aspect ratio preserved, may crop',
        ImageFit.Cover)

      // Auto
      this.ObjectFitCard('Auto', 'Automatic sizing based on image dimensions',
        ImageFit.Auto)

      // Fill
      this.ObjectFitCard('Fill', 'Stretches to fill bounds, aspect ratio NOT preserved (distortion)',
        ImageFit.Fill)

      // ScaleDown
      this.ObjectFitCard('ScaleDown', 'Only shrinks if larger than bounds, never enlarges',
        ImageFit.ScaleDown)

      // None
      this.ObjectFitCard('None', 'Original size, no scaling, may overflow container',
        ImageFit.None)
    }
    .padding({ left: 16, right: 16, bottom: 24 })
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ObjectFitCard(title: string, description: string, fit: ImageFit) {
    Column() {
      Text(title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1976D2')
        .width('100%')

      Text(description)
        .fontSize(12)
        .fontColor('#888888')
        .margin({ top: 4 })
        .width('100%')

      Row() {
        // Container with visible border
        Stack() {
          Image($r('app.media.startIcon'))
            .width(200)
            .height(150)
            .objectFit(fit)
            .backgroundColor('#E8EAF6')
        }
        .width(200)
        .height(150)
        .border({ width: 2, color: '#90CAF9', style: BorderStyle.Dashed })

        Column({ space: 8 }) {
          Text('Container: 200×150')
            .fontSize(11)
            .fontColor('#666666')

          Text(`Fit: ${title}`)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor('#444444')

          // Visual indicator
          Row() {
            if (fit === ImageFit.Fill) {
              Text('⚠ Distorted')
                .fontSize(11)
                .fontColor('#E53935')
                .fontWeight(FontWeight.Medium)
            } else {
              Text('✓ Aspect Preserved')
                .fontSize(11)
                .fontColor('#43A047')
                .fontWeight(FontWeight.Medium)
            }
          }
        }
        .margin({ left: 16 })
        .alignItems(HorizontalAlign.Start)
      }
      .margin({ top: 8 })
      .width('100%')
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}

@Component
struct AspectRatioDemo {
  @State widthSlider: number = 200
  @State heightSlider: number = 150
  @State maintainAspect: boolean = true

  build() {
    Column({ space: 16 }) {
      Text('Aspect Ratio Control')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 12 })
        .fontColor('#333333')

      Text('Toggle aspect ratio lock and adjust dimensions')
        .fontSize(13)
        .fontColor('#777777')

      // Toggle
      Row() {
        Text('Maintain Aspect Ratio')
          .fontSize(15)
          .fontColor('#333333')

        Toggle({ type: ToggleType.Switch, isOn: this.maintainAspect })
          .onChange((isOn: boolean) => {
            this.maintainAspect = isOn
          })
          .selectedColor('#1976D2')
          .margin({ left: 12 })
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

      // Width Slider
      Column() {
        Text(`Width: ${this.widthSlider.toFixed(0)}vp`)
          .fontSize(14)
          .fontColor('#555555')
          .width('100%')

        Slider({
          value: this.widthSlider,
          min: 80,
          max: 360,
          step: 10,
          style: SliderStyle.OutSet
        })
          .onChange((value: number) => {
            this.widthSlider = value
          })
          .width('100%')
          .blockColor('#1976D2')
          .trackColor('#BBDEFB')
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

      // Height Slider
      Column() {
        Text(`Height: ${this.heightSlider.toFixed(0)}vp`)
          .fontSize(14)
          .fontColor('#555555')
          .width('100%')

        Slider({
          value: this.heightSlider,
          min: 60,
          max: 300,
          step: 10,
          style: SliderStyle.OutSet
        })
          .onChange((value: number) => {
            this.heightSlider = value
          })
          .width('100%')
          .blockColor('#1976D2')
          .trackColor('#BBDEFB')
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

      // Preview
      Column() {
        Text('Preview')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1976D2')
          .width('100%')

        Row() {
          Stack() {
            Image($r('app.media.startIcon'))
              .width(this.widthSlider)
              .height(this.maintainAspect ? undefined : this.heightSlider)
              .aspectRatio(this.maintainAspect ? 1.33 : undefined)
              .objectFit(this.maintainAspect ? ImageFit.Contain : ImageFit.Fill)
              .backgroundColor('#E8EAF6')
          }
          .width(this.widthSlider)
          .height(this.heightSlider)
          .border({ width: 2, color: '#90CAF9', style: BorderStyle.Dashed })
          .alignContent(Alignment.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 12 })

        Text(this.maintainAspect ? 'Aspect ratio locked at 4:3' : 'Free resizing — distortion possible')
          .fontSize(12)
          .fontColor(this.maintainAspect ? '#43A047' : '#E53935')
          .margin({ top: 8 })

        Text(`Effective size: ${this.widthSlider.toFixed(0)} × ${this.heightSlider.toFixed(0)}`)
          .fontSize(12)
          .fontColor('#888888')
          .margin({ top: 4 })
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
    }
    .padding({ left: 16, right: 16, bottom: 24 })
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct DirectionalResizeDemo {
  @State horizontalStretch: number = 200
  @State verticalStretch: number = 150

  build() {
    Column({ space: 16 }) {
      Text('Directional Resizing')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 12 })
        .fontColor('#333333')

      Text('See how images behave when stretched in specific directions')
        .fontSize(13)
        .fontColor('#777777')

      // Wide Horizontal
      Column() {
        Text('Wide Horizontal Stretch')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1976D2')
          .width('100%')

        Text('Image stretched horizontally — observe distortion vs. containment')
          .fontSize(12)
          .fontColor('#888888')
          .margin({ top: 2, bottom: 8 })
          .width('100%')

        // Fill (distorted)
        Column() {
          Text('Fill — Distorted')
            .fontSize(11)
            .fontColor('#E53935')
          Image($r('app.media.startIcon'))
            .width('100%')
            .height(80)
            .objectFit(ImageFit.Fill)
            .backgroundColor('#E8EAF6')
        }
        .width('100%')

        Divider().margin({ top: 8, bottom: 8 })

        // Contain (preserved)
        Column() {
          Text('Contain — Aspect Preserved')
            .fontSize(11)
            .fontColor('#43A047')
          Image($r('app.media.startIcon'))
            .width('100%')
            .height(80)
            .objectFit(ImageFit.Contain)
            .backgroundColor('#E8EAF6')
        }
        .width('100%')

        Divider().margin({ top: 8, bottom: 8 })

        // Cover (preserved, cropped)
        Column() {
          Text('Cover — Preserved, Cropped')
            .fontSize(11)
            .fontColor('#FF9800')
          Image($r('app.media.startIcon'))
            .width('100%')
            .height(80)
            .objectFit(ImageFit.Cover)
            .backgroundColor('#E8EAF6')
        }
        .width('100%')
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

      // Tall Vertical
      Column() {
        Text('Tall Vertical Stretch')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1976D2')
          .width('100%')

        Text('Image stretched vertically — observe distortion vs. containment')
          .fontSize(12)
          .fontColor('#888888')
          .margin({ top: 2, bottom: 8 })
          .width('100%')

        Row({ space: 12 }) {
          // Fill
          Column() {
            Text('Fill')
              .fontSize(11)
              .fontColor('#E53935')
            Image($r('app.media.startIcon'))
              .width(90)
              .height(220)
              .objectFit(ImageFit.Fill)
              .backgroundColor('#E8EAF6')
          }

          // Contain
          Column() {
            Text('Contain')
              .fontSize(11)
              .fontColor('#43A047')
            Image($r('app.media.startIcon'))
              .width(90)
              .height(220)
              .objectFit(ImageFit.Contain)
              .backgroundColor('#E8EAF6')
          }

          // Cover
          Column() {
            Text('Cover')
              .fontSize(11)
              .fontColor('#FF9800')
            Image($r('app.media.startIcon'))
              .width(90)
              .height(220)
              .objectFit(ImageFit.Cover)
              .backgroundColor('#E8EAF6')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

      // Interactive directional resize
      Column() {
        Text('Interactive Directional Resize')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1976D2')
          .width('100%')

        Row({ space: 16 }) {
          Column() {
            Text('Width')
              .fontSize(13)
              .fontColor('#555555')
            Slider({
              value: this.horizontalStretch,
              min: 60,
              max: 360,
              step: 10,
              style: SliderStyle.OutSet
            })
              .onChange((value: number) => {
                this.horizontalStretch = value
              })
              .width(140)
              .blockColor('#1976D2')
          }

          Column() {
            Text('Height')
              .fontSize(13)
              .fontColor('#555555')
            Slider({
              value: this.verticalStretch,
              min: 60,
              max: 300,
              step: 10,
              style: SliderStyle.OutSet
            })
              .onChange((value: number) => {
                this.verticalStretch = value
              })
              .width(140)
              .blockColor('#1976D2')
          }
        }
        .width('100%')
        .margin({ top: 8 })

        // Side by side comparison
        Row({ space: 12 }) {
          Column() {
            Text('Fill (Distort)')
              .fontSize(11)
              .fontColor('#E53935')
            Stack() {
              Image($r('app.media.startIcon'))
                .width(this.horizontalStretch)
                .height(this.verticalStretch)
                .objectFit(ImageFit.Fill)
                .backgroundColor('#E8EAF6')
            }
            .border({ width: 1, color: '#EF9A9A', style: BorderStyle.Dashed })
          }

          Column() {
            Text('Contain (Preserve)')
              .fontSize(11)
              .fontColor('#43A047')
            Stack() {
              Image($r('app.media.startIcon'))
                .width(this.horizontalStretch)
                .height(this.verticalStretch)
                .objectFit(ImageFit.Contain)
                .backgroundColor('#E8EAF6')
            }
            .border({ width: 1, color: '#A5D6A7', style: BorderStyle.Dashed })
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 12 })

        Text(`${this.horizontalStretch.toFixed(0)} × ${this.verticalStretch.toFixed(0)} vp`)
          .fontSize(12)
          .fontColor('#888888')
          .margin({ top: 8 })
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
    }
    .padding({ left: 16, right: 16, bottom: 24 })
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ObjectRepeatDemo {
  build() {
    Column({ space: 16 }) {
      Text('Image Repeat Modes')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 12 })
        .fontColor('#333333')

      Text('How images tile when the container is larger than the image')
        .fontSize(13)
        .fontColor('#777777')

      // No Repeat
      this.RepeatCard('No Repeat (Default)', 'Image placed once at original size',
        ImageRepeat.NoRepeat)

      // X Repeat
      this.RepeatCard('Repeat-X', 'Image repeated horizontally only',
        ImageRepeat.X)

      // Y Repeat
      this.RepeatCard('Repeat-Y', 'Image repeated vertically only',
        ImageRepeat.Y)

      // XY Repeat
      this.RepeatCard('Repeat-XY', 'Image repeated in both directions (tile)',
        ImageRepeat.XY)

      // Combined: objectFit + repeat
      Column() {
        Text('Combined: ObjectFit + Repeat')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1976D2')
          .width('100%')

        Text('Cover with NoRepeat vs. None with XY repeat')
          .fontSize(12)
          .fontColor('#888888')
          .margin({ top: 2, bottom: 8 })
          .width('100%')

        Row({ space: 12 }) {
          Column() {
            Text('Cover + NoRepeat')
              .fontSize(11)
              .fontColor('#43A047')
            Image($r('app.media.startIcon'))
              .width(180)
              .height(120)
              .objectFit(ImageFit.Cover)
              .objectRepeat(ImageRepeat.NoRepeat)
              .backgroundColor('#E8EAF6')
              .borderRadius(8)
          }

          Column() {
            Text('None + RepeatXY')
              .fontSize(11)
              .fontColor('#FF9800')
            Image($r('app.media.startIcon'))
              .width(180)
              .height(120)
              .objectFit(ImageFit.None)
              .objectRepeat(ImageRepeat.XY)
              .backgroundColor('#E8EAF6')
              .borderRadius(8)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

      // RenderMode demonstration
      Column() {
        Text('Render Mode')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1976D2')
          .width('100%')

        Row({ space: 12 }) {
          Column() {
            Text('Original')
              .fontSize(11)
              .fontColor('#555555')
            Image($r('app.media.startIcon'))
              .width(100)
              .height(100)
              .objectFit(ImageFit.Cover)
              .borderRadius(8)
          }

          Column() {
            Text('Template')
              .fontSize(11)
              .fontColor('#555555')
            Image($r('app.media.startIcon'))
              .width(100)
              .height(100)
              .objectFit(ImageFit.Cover)
              .renderMode(ImageRenderMode.Template)
              .borderRadius(8)
              .fillColor('#1976D2')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 8 })
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
    }
    .padding({ left: 16, right: 16, bottom: 24 })
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  RepeatCard(title: string, description: string, repeat: ImageRepeat) {
    Column() {
      Text(title)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1976D2')
        .width('100%')

      Text(description)
        .fontSize(12)
        .fontColor('#888888')
        .margin({ top: 2 })
        .width('100%')

      Image($r('app.media.startIcon'))
        .width('100%')
        .height(100)
        .objectFit(ImageFit.None)
        .objectRepeat(repeat)
        .backgroundColor('#E8EAF6')
        .borderRadius(8)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}