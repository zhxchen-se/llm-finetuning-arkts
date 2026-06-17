@Entry
@Component
struct Index {
  aboutToAppear() {
    console.log('hello world');
  }

  build() {
    Column() {
      Text('Hello')
    }
    .width('100%')
    .height('100%')
  }
}