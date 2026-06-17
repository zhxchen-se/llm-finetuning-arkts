// entry/src/main/ets/pages/Index.ets
import { ImageFit } from '@ohos/arkui';

@Entry
@Component
struct Index {
  // Define a data model for resizing examples
  private resizeExamples: ResizeCase[] = [
    {
      title: 'Fill (Distortion)',
      description: 'Stretches image to fill container. Aspect ratio not preserved.',
      fit: ImageFit.Fill,
      containerWidth: 200,
      containerHeight: 100,
      category: 'Distortion Allowed'
    },
    {
      title: 'Cover (Crop)',
      description: 'Scales to fill, keeps aspect ratio. Parts may be cropped.',
      fit: ImageFit.Cover,
      containerWidth: 200,
      containerHeight: 100,
      category: 'Aspect Ratio Maintained'
    },
    {
      title: 'Contain (Letterbox)',
      description: 'Scales to fit, keeps aspect ratio. Empty space may appear.',
      fit: ImageFit.Contain,
      containerWidth: 200,
      containerHeight: 100,
      category: 'Aspect Ratio Maintained'
    },
    {
      title: 'FitCenter',
      description: 'Similar to Contain, centered within the container.',
      fit: ImageFit.FitCenter,
      containerWidth: 200,
      containerHeight: 100,
      category: 'Aspect Ratio Maintained'
    },
    {
      title: 'FitStart',
      description: 'Aligns to start (top/left), keeps aspect ratio.',
      fit: ImageFit.FitStart,
      containerWidth: 200,
      containerHeight: 100,
      category: 'Aspect Ratio Maintained'
    },
    {
      title: 'FitEnd',
      description: 'Aligns to end (bottom/right), keeps aspect ratio.',
      fit: ImageFit.FitEnd,
      containerWidth: 200,
      containerHeight: 100,
      category: 'Aspect Ratio Maintained'
    },
    {
      title: 'None (Original)',
      description: 'Displays image at original size. May overflow or underfill.',
      fit: ImageFit.None,
      containerWidth: 100,
      containerHeight: 100,
      category: 'Original Size'
    },
    {
      title: 'Vertical Stretch (Fill)',
      description: 'Container taller than wide. Fill distorts vertically.',
      fit: ImageFit.Fill,
      containerWidth: 100,
      containerHeight: 200,
      category: 'Directional Demo'
    },
    {
      title: 'Vertical Crop (Cover)',
      description: 'Container taller than wide. Cover crops sides.',
      fit: ImageFit.Cover,
      containerWidth: 100,
      containerHeight: 200,
      category: 'Directional Demo'
    }
  ];

  build() {
    Column() {
      Text('Image Resizing Techniques')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      List() {
        ForEach(this.resizeExamples, (item: ResizeCase) => {
          ListItem() {
            Column() {
              // Category Label
              Text(item.category)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 5 })

              // Example Title
              Text(item.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .alignSelf(ItemAlign.Start)

              // Description
              Text(item.description)
                .fontSize(12)
                .fontColor('#888888')
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 10 })

              // Visual Demo Container
              Row() {
                // Container Border Box
                Box() {
                  Image($r('app.media.icon'))
                    .width('100%')
                    .height('100%')
                    .objectFit(item.fit)
                }
                .width(item.containerWidth)
                .height(item.containerHeight)
                .backgroundColor('#F0F0F0')
                .border({ width: 2, color: '#007DFF', style: BorderStyle.Dashed })
                .position({ x: 0, y: 0 }) // Ensure consistent positioning

                // Dimension Labels
                Column() {
                  Text(`Container: ${item.containerWidth}x${item.containerHeight}`)
                    .fontSize(10)
                    .fontColor('#007DFF')
                  Text(`Fit: ${item.fit.toString()}`)
                    .fontSize(10)
                    .fontColor('#007DFF')
                }
                .margin({ left: 10 })
                .justifyContent(FlexAlign.Center)
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
              .padding(10)
            }
            .width('100%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 10 })
            .shadow({ radius: 4, color: '#10000000', offsetX: 0, offsetY: 2 })
          }
        })
      }
      .width('100%')
      .padding(10)
    }
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}

// Interface definition for resizing cases
interface ResizeCase {
  title: string;
  description: string;
  fit: ImageFit;
  containerWidth: number;
  containerHeight: number;
  category: string;
}