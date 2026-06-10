import { ImageFit } from '@ohos.multimedia.image';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Image in Frame Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      // Row 1: Different alignments with objectFit Contain
      Row() {
        Column() {
          Text('Center')
            .fontSize(14)
            .margin({ bottom: 5 })
          Frame({ align: Alignment.Center }) {
            Image($r('app.media.icon'))
              .objectFit(ImageFit.Contain)
              .width('100%')
              .height('100%')
          }
          .width(120)
          .height(120)
          .border({ width: 2, color: '#333' })
          .backgroundColor('#F0F0F0')
        }
        .margin({ right: 10 })

        Column() {
          Text('TopStart')
            .fontSize(14)
            .margin({ bottom: 5 })
          Frame({ align: Alignment.TopStart }) {
            Image($r('app.media.icon'))
              .objectFit(ImageFit.Contain)
              .width('100%')
              .height('100%')
          }
          .width(120)
          .height(120)
          .border({ width: 2, color: '#333' })
          .backgroundColor('#F0F0F0')
        }
        .margin({ right: 10 })

        Column() {
          Text('BottomEnd')
            .fontSize(14)
            .margin({ bottom: 5 })
          Frame({ align: Alignment.BottomEnd }) {
            Image($r('app.media.icon'))
              .objectFit(ImageFit.Contain)
              .width('100%')
              .height('100%')
          }
          .width(120)
          .height(120)
          .border({ width: 2, color: '#333' })
          .backgroundColor('#F0F0F0')
        }
      }
      .margin({ bottom: 20 })

      // Row 2: Different objectFit modes with center alignment
      Row() {
        Column() {
          Text('Contain')
            .fontSize(14)
            .margin({ bottom: 5 })
          Frame({ align: Alignment.Center }) {
            Image($r('app.media.icon'))
              .objectFit(ImageFit.Contain)
              .width('100%')
              .height('100%')
          }
          .width(120)
          .height(120)
          .border({ width: 2, color: '#333' })
          .backgroundColor('#F0F0F0')
        }
        .margin({ right: 10 })

        Column() {
          Text('Cover')
            .fontSize(14)
            .margin({ bottom: 5 })
          Frame({ align: Alignment.Center }) {
            Image($r('app.media.icon'))
              .objectFit(ImageFit.Cover)
              .width('100%')
              .height('100%')
          }
          .width(120)
          .height(120)
          .border({ width: 2, color: '#333' })
          .backgroundColor('#F0F0F0')
        }
        .margin({ right: 10 })

        Column() {
          Text('Fill')
            .fontSize(14)
            .margin({ bottom: 5 })
          Frame({ align: Alignment.Center }) {
            Image($r('app.media.icon'))
              .objectFit(ImageFit.Fill)
              .width('100%')
              .height('100%')
          }
          .width(120)
          .height(120)
          .border({ width: 2, color: '#333' })
          .backgroundColor('#F0F0F0')
        }
      }
      .margin({ bottom: 20 })

      // Row 3: Image without explicit size (intrinsic size) and clipping
      Row() {
        Column() {
          Text('No size (clipped)')
            .fontSize(14)
            .margin({ bottom: 5 })
          Frame({ align: Alignment.Center }) {
            Image($r('app.media.icon'))
              .objectFit(ImageFit.None)
          }
          .width(120)
          .height(120)
          .border({ width: 2, color: '#333' })
          .backgroundColor('#F0F0F0')
        }
        .margin({ right: 10 })

        Column() {
          Text('No size (no clip)')
            .fontSize(14)
            .margin({ bottom: 5 })
          Frame({ align: Alignment.Center }) {
            Image($r('app.media.icon'))
              .objectFit(ImageFit.None)
          }
          .width(120)
          .height(120)
          .border({ width: 2, color: '#333' })
          .backgroundColor('#F0F0F0')
          .clip(false) // allow overflow
        }
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
  }
}