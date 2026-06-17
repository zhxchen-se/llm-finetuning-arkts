import http from '@ohos.net.http'
import image from '@ohos.multimedia.image'
import { BusinessError } from '@ohos.base'

// Ensure ohos.permission.INTERNET is configured in module.json5

@Entry
@Component
struct Index {
  @State pixelMap: image.PixelMap | null = null
  @State loading: boolean = false
  @State errorMsg: string = ''

  async loadImage() {
    this.loading = true
    this.errorMsg = ''

    // Release previous pixelMap to prevent memory leaks
    if (this.pixelMap) {
      try {
        await this.pixelMap.release()
      } catch (err) {
        console.error('Failed to release old pixelMap', (err as BusinessError).message)
      }
      this.pixelMap = null
    }

    let httpRequest = http.createHttp()
    try {
      const response = await httpRequest.request(
        'https://placehold.co/600x400/png',
        {
          method: http.HttpMethod.GET,
          expectType: http.HttpDataType.ARRAY_BUFFER,
          connectTimeout: 5000,
          readTimeout: 5000
        }
      )

      if (response.responseCode === 200) {
        const imageData = response.result as ArrayBuffer
        const imageSource = image.createImageSource(imageData)
        try {
          this.pixelMap = await imageSource.createPixelMap()
        } finally {
          await imageSource.release()
        }
      } else {
        this.errorMsg = `Request failed: ${response.responseCode}`
      }
    } catch (err) {
      this.errorMsg = `Error: ${(err as BusinessError).message}`
    } finally {
      httpRequest.destroy()
      this.loading = false
    }
  }

  build() {
    Column() {
      Button(this.loading ? 'Loading...' : 'Load Image')
        .width('80%')
        .height(50)
        .fontSize(18)
        .enabled(!this.loading)
        .onClick(() => {
          this.loadImage()
        })

      if (this.errorMsg) {
        Text(this.errorMsg)
          .fontSize(14)
          .fontColor('red')
          .margin({ top: 10 })
      }

      if (this.pixelMap) {
        Image(this.pixelMap)
          .width(300)
          .height(200)
          .objectFit(ImageFit.Contain)
          .margin({ top: 20 })
      } else if (!this.loading && !this.errorMsg) {
        Text('Click button to load image')
          .fontSize(16)
          .fontColor('gray')
          .margin({ top: 20 })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(ItemAlign.Center)
    .padding(20)
  }
}