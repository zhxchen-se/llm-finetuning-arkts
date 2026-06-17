import display from '@ohos.display'

@Entry
@Component
struct Index {
  @State screenWidth: number = 360
  @State screenHeight: number = 640
  @State lineWidth: number = 5
  @State strokeColor: string = '#FF0000'
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear() {
    try {
      let displayInfo = display.getDefaultDisplaySync()
      this.screenWidth = px2vp(displayInfo.width)
      this.screenHeight = px2vp(displayInfo.height)
    } catch (error) {
      console.error('Failed to get display info: ' + JSON.stringify(error))
    }
  }

  build() {
    Column() {
      // Toolbar
      Row() {
        Button('Clear')
          .height(40)
          .fontSize(14)
          .onClick(() => {
            this.context.clearRect(0, 0, this.screenWidth, this.screenHeight)
          })
          .margin({ right: 10 })

        Text('Size:')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)

        Slider({
          value: this.lineWidth,
          min: 1,
          max: 30
        })
          .width(100)
          .onChange((value: number) => {
            this.lineWidth = value
          })

        // Color Pickers
        Row() {
          Circle({ width: 28, height: 28 })
            .fill('#FF0000')
            .border({ width: this.strokeColor === '#FF0000' ? 2 : 0, color: '#000000' })
            .onClick(() => this.strokeColor = '#FF0000')
          
          Circle({ width: 28, height: 28 })
            .fill('#00FF00')
            .border({ width: this.strokeColor === '#00FF00' ? 2 : 0, color: '#000000' })
            .onClick(() => this.strokeColor = '#00FF00')
          
          Circle({ width: 28, height: 28 })
            .fill('#0000FF')
            .border({ width: this.strokeColor === '#0000FF' ? 2 : 0, color: '#000000' })
            .onClick(() => this.strokeColor = '#0000FF')
          
          Circle({ width: 28, height: 28 })
            .fill('#000000')
            .border({ width: this.strokeColor === '#000000' ? 2 : 0, color: '#FFFFFF' })
            .onClick(() => this.strokeColor = '#000000')
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .layoutWeight(1)
      }
      .width('100%')
      .height(70)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#F1F3F5')
      .alignItems(VerticalAlign.Center)

      // Canvas
      Canvas(this.context)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#FFFFFF')
        .onReady(() => {
          this.context.lineWidth = this.lineWidth
          this.context.strokeStyle = this.strokeColor
          this.context.lineCap = 'round'
          this.context.lineJoin = 'round'
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.context.beginPath()
            this.context.lineWidth = this.lineWidth
            this.context.strokeStyle = this.strokeColor
            this.context.lineCap = 'round'
            this.context.lineJoin = 'round'
            this.context.moveTo(event.touches[0].x, event.touches[0].y)
          } else if (event.type === TouchType.Move) {
            this.context.lineTo(event.touches[0].x, event.touches[0].y)
            this.context.stroke()
          } else if (event.type === TouchType.Up) {
            this.context.closePath()
          }
        })
    }
    .width('100%')
    .height('100%')
  }
}