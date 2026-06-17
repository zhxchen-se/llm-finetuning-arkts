import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Row() {
      Column() {
        Text('Home Page')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 20 })

        Button('Go to Second Page')
          .width('80%')
          .height(50)
          .fontSize(18)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Second'
            })
              .then(() => {
                console.info('Succeeded in jumping to the second page.');
              })
              .catch((error) => {
                console.error(`Failed to jump to the second page. Code: ${error.code}, message: ${error.message}`);
              });
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}