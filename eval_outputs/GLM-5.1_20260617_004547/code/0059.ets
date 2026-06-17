@Entry
@Component
struct Index {
  @State clickCount: number = 0
  @State isHovered: boolean = false
  @State interactionMessage: string = 'Interact with the image below!'
  @State imageScale: number = 1.0
  @State imageOpacity: number = 1.0
  @State touchState: string = 'No Touch'

  build() {
    Column({ space: 20 }) {
      Text('Image Event Handlers')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Image('https://harmonyos.com/resource/logo/logo.png')
        .width(200)
        .height(200)
        .objectFit(ImageFit.Contain)
        .scale({ x: this.imageScale, y: this.imageScale })
        .opacity(this.imageOpacity)
        .border({
          width: this.isHovered ? 4 : 0,
          color: Color.Blue,
          style: BorderStyle.Solid,
          radius: 16
        })
        .shadow({
          radius: this.isHovered ? 20 : 0,
          color: Color.Gray,
          offsetX: 0,
          offsetY: 5
        })
        .animation({ duration: 300, curve: Curve.EaseInOut })
        .onClick((event: ClickEvent) => {
          this.clickCount++
          this.interactionMessage = `Image clicked at X: ${event.x.toFixed(0)}, Y: ${event.y.toFixed(0)}\nTotal clicks: ${this.clickCount}`
        })
        .onHover((isHover: boolean) => {
          this.isHovered = isHover
          if (isHover) {
            this.imageScale = 1.1
            this.imageOpacity = 0.8
            this.interactionMessage = 'Mouse is hovering over the image.'
          } else {
            this.imageScale = 1.0
            this.imageOpacity = 1.0
            this.interactionMessage = 'Mouse left the image.'
          }
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.touchState = 'Touch Down'
          } else if (event.type === TouchType.Up) {
            this.touchState = 'Touch Up'
          } else if (event.type === TouchType.Move) {
            this.touchState = 'Touch Move'
          } else if (event.type === TouchType.Cancel) {
            this.touchState = 'Touch Cancel'
          }
        })

      Column({ space: 10 }) {
        Text(this.interactionMessage)
          .fontSize(18)
          .fontColor(Color.Orange)
          .textAlign(TextAlign.Center)
          .minHeight(50)

        Row({ space: 20 }) {
          Text(`Clicks: ${this.clickCount}`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Text(`Hovering: ${this.isHovered ? 'Yes' : 'No'}`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Text(`Touch: ${this.touchState}`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
      }
      .margin({ top: 20 })
      .padding(15)
      .border({ width: 1, color: Color.Gray, radius: 10, style: BorderStyle.Dashed })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
    .backgroundColor('#F1F3F5')
  }
}