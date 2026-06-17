@Entry
@Component
struct Index {
  @State clickCount: number = 0
  @State clickScale: number = 1
  @State clickBorderColor: string = '#38BDF8'
  @State clickStatus: string = 'Click the first image to trigger onClick.'

  @State hoverCount: number = 0
  @State hoverActive: boolean = false
  @State hoverScale: number = 1
  @State hoverBorderColor: string = '#F59E0B'
  @State hoverStatus: string = 'Move a mouse pointer over the second image to trigger onHover.'

  @State lastEvent: string = 'Waiting for interaction...'

  @Builder
  StatRow(title: string, value: string) {
    Row() {
      Text(title)
        .fontSize(14)
        .fontColor('#94A3B8')

      Text(value)
        .fontSize(14)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(ItemAlign.Center)
    .padding({ top: 8, bottom: 8 })
  }

  build() {
    Scroll() {
      Column() {
        Text('Image Event Handlers')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ bottom: 8 })

        Text('Add onClick and onHover directly to Image components, then update state to respond to users.')
          .fontSize(15)
          .fontColor('#CBD5E1')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 24 })

        Column() {
          Image($r('app.media.icon'))
            .width(220)
            .height(220)
            .objectFit(ImageFit.Contain)
            .backgroundColor('#F8FAFC')
            .borderRadius(32)
            .border({ width: 3, color: this.clickBorderColor, radius: 32 })
            .scale({ x: this.clickScale, y: this.clickScale })
            .animation({ duration: 180, curve: Curve.EaseInOut })
            .shadow({ radius: 14, color: '#20000000', offsetX: 0, offsetY: 8 })
            .onClick(() => {
              this.clickCount = this.clickCount + 1
              this.clickScale = this.clickScale === 1 ? 1.08 : 1
              this.clickBorderColor = this.clickCount % 2 === 0 ? '#A78BFA' : '#38BDF8'
              this.clickStatus = `onClick fired ${this.clickCount} time${this.clickCount === 1 ? '' : 's'}.`
              this.lastEvent = 'Last event: onClick on the first image'
            })
            .onHover((event) => {
              if (event.isHovering) {
                this.clickScale = 1.08
                this.clickBorderColor = '#22C55E'
                this.clickStatus = 'onHover entered: the image is highlighted.'
                this.lastEvent = 'Last event: onHover enter on the first image'
              } else {
                this.clickScale = 1
                this.clickBorderColor = '#38BDF8'
                this.clickStatus = 'onHover exited: the image returned to normal.'
                this.lastEvent = 'Last event: onHover exit on the first image'
              }
            })

          Text('Click + hover image')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ top: 16, bottom: 8 })

          Text(this.clickStatus)
            .fontSize(15)
            .fontColor('#CBD5E1')
            .textAlign(TextAlign.Center)
        }
        .width('92%')
        .padding({ left: 20, right: 20, top: 24, bottom: 24 })
        .borderRadius(28)
        .backgroundColor('#1E293B')
        .border({ width: 1, color: '#334155', radius: 28 })
        .shadow({ radius: 18, color: '#10000000', offsetX: 0, offsetY: 10 })
        .margin({ bottom: 18 })

        Column() {
          Image($r('app.media.icon'))
            .width(220)
            .height(220)
            .objectFit(ImageFit.Contain)
            .backgroundColor('#F8FAFC')
            .borderRadius(32)
            .border({ width: 3, color: this.hoverBorderColor, radius: 32 })
            .scale({ x: this.hoverScale, y: this.hoverScale })
            .animation({ duration: 180, curve: Curve.EaseInOut })
            .shadow({ radius: 14, color: '#20000000', offsetX: 0, offsetY: 8 })
            .onHover((event) => {
              if (event.isHovering) {
                this.hoverCount = this.hoverCount + 1
                this.hoverActive = true
                this.hoverScale = 1.12
                this.hoverBorderColor = '#22C55E'
                this.hoverStatus = `onHover entered ${this.hoverCount} time${this.hoverCount === 1 ? '' : 's'}.`
                this.lastEvent = 'Last event: onHover enter on the second image'
              } else {
                this.hoverActive = false
                this.hoverScale = 1
                this.hoverBorderColor = '#F59E0B'
                this.hoverStatus = 'onHover exited: hover state cleared.'
                this.lastEvent = 'Last event: onHover exit on the second image'
              }
            })

          Text('Hover-only image')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ top: 16, bottom: 8 })

          Text(this.hoverStatus)
            .fontSize(15)
            .fontColor('#CBD5E1')
            .textAlign(TextAlign.Center)
        }
        .width('92%')
        .padding({ left: 20, right: 20, top: 24, bottom: 24 })
        .borderRadius(28)
        .backgroundColor('#1E293B')
        .border({ width: 1, color: '#334155', radius: 28 })
        .shadow({ radius: 18, color: '#10000000', offsetX: 0, offsetY: 10 })
        .margin({ bottom: 18 })

        Column() {
          Text('State updated by events')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)

          Divider()
            .width('100%')
            .margin({ top: 12, bottom: 12 })
            .backgroundColor('#334155')

          Text('Latest interaction')
            .fontSize(14)
            .fontColor('#94A3B8')

          Text(this.lastEvent)
            .width('100%')
            .fontSize(16)
            .fontColor('#E2E8F0')
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .margin({ top: 8, bottom: 8 })

          this.StatRow('Click count', `${this.clickCount}`)
          this.StatRow('Hover count', `${this.hoverCount}`)
          this.StatRow('Hover active', this.hoverActive ? 'Yes' : 'No')
        }
        .width('92%')
        .padding(20)
        .borderRadius(24)
        .backgroundColor('#111827')
        .border({ width: 1, color: '#334155', radius: 24 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 32, bottom: 32 })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Auto)
    .backgroundColor('#0F172A')
  }
}