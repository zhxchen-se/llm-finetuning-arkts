import { ImageFit } from '@ohos.multimedia.image';

@Entry
@Component
struct Index {
  @State imageUrl: string = 'https://picsum.photos/id/237/200/300';

  private testCases: Array<{fit: ImageFit, width: number, height: number, label: string}> = [
    { fit: ImageFit.Contain, width: 150, height: 150, label: 'Contain 150x150' },
    { fit: ImageFit.Contain, width: 200, height: 100, label: 'Contain 200x100' },
    { fit: ImageFit.Contain, width: 100, height: 200, label: 'Contain 100x200' },
    { fit: ImageFit.Cover, width: 150, height: 150, label: 'Cover 150x150' },
    { fit: ImageFit.Cover, width: 200, height: 100, label: 'Cover 200x100' },
    { fit: ImageFit.Cover, width: 100, height: 200, label: 'Cover 100x200' },
    { fit: ImageFit.Fill, width: 150, height: 150, label: 'Fill 150x150' },
    { fit: ImageFit.Fill, width: 200, height: 100, label: 'Fill 200x100' },
    { fit: ImageFit.Fill, width: 100, height: 200, label: 'Fill 100x200' },
    { fit: ImageFit.None, width: 150, height: 150, label: 'None 150x150' },
    { fit: ImageFit.None, width: 200, height: 100, label: 'None 200x100' },
    { fit: ImageFit.None, width: 100, height: 200, label: 'None 100x200' },
    { fit: ImageFit.ScaleDown, width: 150, height: 150, label: 'ScaleDown 150x150' },
    { fit: ImageFit.ScaleDown, width: 200, height: 100, label: 'ScaleDown 200x100' },
    { fit: ImageFit.ScaleDown, width: 100, height: 200, label: 'ScaleDown 100x200' },
  ];

  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Image objectFit Demo')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 10 })
          .width('100%')
          .textAlign(TextAlign.Center)

        ForEach(this.testCases, (item: {fit: ImageFit, width: number, height: number, label: string}) => {
          Column() {
            Text(item.label)
              .fontSize(14)
              .margin({ bottom: 5 })
            Stack() {
              Image(this.imageUrl)
                .width('100%')
                .height('100%')
                .objectFit(item.fit)
            }
            .width(item.width)
            .height(item.height)
            .border({ width: 1, color: Color.Gray })
            .backgroundColor(Color.White)
          }
          .alignItems(HorizontalAlign.Center)
          .margin({ bottom: 10 })
        }, (item: {fit: ImageFit, width: number, height: number, label: string}) => item.label)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
  }
}