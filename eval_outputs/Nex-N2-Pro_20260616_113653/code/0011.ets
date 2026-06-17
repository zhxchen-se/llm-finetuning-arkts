@Entry
@Component
struct Index {
  aboutToAppear(): void {
    console.info('hello world');
  }

  build() {
    Column() {
      Text('hello world')
    }
    .width('100%')
    .height('100%')
  }
}