import promptAction from '@ohos.promptAction';

class Product {
  id: number
  name: string
  price: number
  image: Resource
  description: string

  constructor(id: number, name: string, price: number, image: Resource, description: string) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.image = image;
    this.description = description;
  }
}

@Entry
@Component
struct Index {
  @State products: Product[] = [
    new Product(1, 'Smartphone', 699, $r('app.media.icon'), 'A high-performance smartphone with an amazing camera and long battery life.'),
    new Product(2, 'Laptop', 1299, $r('app.media.icon'), 'Ultra-thin laptop with powerful processing capabilities for professionals.'),
    new Product(3, 'Headphones', 199, $r('app.media.icon'), 'Noise-cancelling over-ear headphones with superior sound quality.'),
    new Product(4, 'Smartwatch', 349, $r('app.media.icon'), 'Track your fitness and stay connected with this sleek smartwatch.'),
    new Product(5, 'Tablet', 499, $r('app.media.icon'), 'A versatile tablet perfect for both work and entertainment.'),
    new Product(6, 'Speaker', 149, $r('app.media.icon'), 'Portable Bluetooth speaker with 360-degree immersive sound.')
  ];
  @State selectedProduct: Product | null = null;

  build() {
    Column() {
      if (this.selectedProduct === null) {
        Text('Products')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 10 })
          .width('100%')
          .textAlign(TextAlign.Center)

        Grid() {
          ForEach(this.products, (item: Product) => {
            GridItem() {
              Column() {
                Image(item.image)
                  .width('100%')
                  .height(120)
                  .objectFit(ImageFit.Contain)
                  .backgroundColor('#F0F0F0')
                  .borderRadius({ topLeft: 8, topRight: 8 })

                Column() {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .margin({ top: 8 })

                  Text(`$${item.price.toFixed(2)}`)
                    .fontSize(14)
                    .fontColor('#E53935')
                    .fontWeight(FontWeight.Bold)
                    .margin({ top: 4, bottom: 8 })
                }
                .padding({ left: 8, right: 8 })
                .alignItems(HorizontalAlign.Start)
              }
              .backgroundColor(Color.White)
              .borderRadius(8)
              .shadow({ radius: 4, color: '#888888', offsetY: 2 })
              .onClick(() => {
                this.selectedProduct = item;
              })
            }
            .padding(4)
          }, (item: Product) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(8)
        .columnsGap(8)
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 8, right: 8, bottom: 8 })
      } else {
        Column() {
          Row() {
            Button('< Back')
              .backgroundColor(Color.Transparent)
              .fontColor('#007DFF')
              .onClick(() => {
                this.selectedProduct = null;
              })
            Blank()
            Text('Product Details')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
            Blank()
            Row().width(60)
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 12, bottom: 12 })
          .backgroundColor(Color.White)
          .shadow({ radius: 2, color: '#CCCCCC', offsetY: 1 })

          Scroll() {
            Column() {
              Image(this.selectedProduct.image)
                .width('90%')
                .height(250)
                .objectFit(ImageFit.Contain)
                .backgroundColor('#F0F0F0')
                .borderRadius(12)
                .margin({ top: 20 })

              Text(this.selectedProduct.name)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 20 })

              Text(`$${this.selectedProduct.price.toFixed(2)}`)
                .fontSize(22)
                .fontColor('#E53935')
                .fontWeight(FontWeight.Bold)
                .margin({ top: 8 })

              Text(this.selectedProduct.description)
                .fontSize(16)
                .fontColor('#666666')
                .lineHeight(24)
                .margin({ top: 16 })
                .width('90%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
          }
          .layoutWeight(1)

          Button('Add to Cart')
            .width('90%')
            .height(50)
            .fontSize(18)
            .fontColor(Color.White)
            .backgroundColor('#FF5722')
            .borderRadius(25)
            .margin({ bottom: 30, top: 10 })
            .onClick(() => {
              promptAction.showToast({
                message: `${this.selectedProduct!.name} added to cart!`,
                duration: 2000
              });
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F5')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}