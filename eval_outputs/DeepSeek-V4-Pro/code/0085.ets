// entry/src/main/ets/pages/Index.ets
import { Swiper } from '@ohos/arkui';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Swiper() {
        // First image (using app.media.icon)
        Image($r('app.media.icon'))
          .objectFit(ImageFit.Contain)
          .width('100%')
          .height('100%')

        // Second image (using the same resource for demonstration)
        Image($r('app.media.icon'))
          .objectFit(ImageFit.Contain)
          .width('100%')
          .height('100%')
      }
      .loop(true)               // Enable infinite loop swiping
      .autoPlay(false)          // Disable auto-play, user swipes manually
      .indicator(true)          // Show page indicator dots
      .indicatorStyle({
        left: '50%',
        bottom: 20,
        transform: [{ translate: { x: '-50%', y: 0 } }]
      })
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}