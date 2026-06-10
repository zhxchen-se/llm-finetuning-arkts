import { Log } from '@ohos/log';

@Entry
@Component
struct Index {
  aboutToAppear() {
    console.log('hello world');
  }

  build() {
    Column() {
      Text('Hello World')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}