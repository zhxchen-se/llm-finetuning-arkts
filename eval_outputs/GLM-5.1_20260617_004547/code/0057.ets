@Entry
@Component
struct Index {
  @State imageUrl: string = 'https://picsum.photos/800/800'
  @State timeoutValue: string = '5'
  @State currentUrl: string = ''
  @State isTimeout: boolean = false
  @State isLoading: boolean = false
  private timerId: number = -1

  build() {
    Column({ space: 20 }) {
      TextInput({ text: this.imageUrl, placeholder: 'Enter image URL' })
        .width('90%')
        .onChange((value: string) => {
          this.imageUrl = value
        })

      Row({ space: 10 }) {
        TextInput({ text: this.timeoutValue, placeholder: 'Timeout (s)' })
          .type(InputType.Number)
          .width('60%')
          .onChange((value: string) => {
            this.timeoutValue = value
          })
        Text('seconds')
          .fontSize(16)
      }
      .width('90%')

      Button('Load Image')
        .width('90%')
        .onClick(() => {
          this.startLoading()
        })

      if (this.isTimeout) {
        Text('Loading timed out!')
          .fontColor(Color.Red)
          .fontSize(16)
      } else if (this.isLoading) {
        LoadingProgress()
          .width(40)
          .height(40)
          .color(Color.Blue)
      }

      Image(this.currentUrl)
        .alt($r('app.media.icon'))
        .width(300)
        .height(300)
        .objectFit(ImageFit.Contain)
        .borderRadius(12)
        .backgroundColor(Color.Black)
        .onStart(() => {
          this.isLoading = true
          this.isTimeout = false
        })
        .onComplete(() => {
          this.isLoading = false
          clearTimeout(this.timerId)
        })
        .onError(() => {
          this.isLoading = false
          clearTimeout(this.timerId)
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }

  private startLoading() {
    clearTimeout(this.timerId)
    this.isTimeout = false
    this.currentUrl = this.imageUrl

    const timeout = parseInt(this.timeoutValue, 10)
    if (!isNaN(timeout) && timeout > 0) {
      this.timerId = setTimeout(() => {
        if (this.isLoading) {
          this.isTimeout = true
          this.currentUrl = ''
        }
      }, timeout * 1000)
    }
  }
}