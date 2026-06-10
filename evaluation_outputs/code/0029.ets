import { promptAction } from '@kit.ArkUI';

interface Product {
  id: number;
  name: string;
  price: number;
  description: string;
}

@Entry
@Component
struct Index {
  @State products: Product[] = [
    { id: 1, name: 'Wireless Headphones', price: 79.99, description: 'High-quality sound with noise cancellation. 20-hour battery life.' },
    { id: 2, name: 'Smart Watch', price: 199.99, description: 'Fitness tracking, heart rate monitor, and GPS. Water resistant.' },
    { id: 3, name: 'Bluetooth Speaker', price: 49.99, description: 'Portable speaker with deep bass. IPX7 waterproof.' },
    { id: 4, name: 'Laptop Stand', price: 29.99, description: 'Adjustable aluminum stand. Ergonomic design for better posture.' },
    { id: 5, name: 'USB-C Hub', price: 34.99, description: '7-in-1 adapter with HDMI, USB 3.0, SD card reader.' },
    { id: 6, name: 'Mechanical Keyboard', price: 89.99, description: 'RGB backlit, Cherry MX switches. Durable aluminum frame.' }
  ];
  @State selectedProduct: Product | null = null;
  @State cartCount: number = 0;

  build() {
    if (this.selectedProduct === null) {
      // Product grid view
      Column() {
        Text('Products')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 16, bottom: 16 })
          .width('100%')
          .textAlign(TextAlign.Center)

        Grid() {
          ForEach(this.products, (product: Product) => {
            GridItem() {
              Column() {
                // Product image placeholder
                Stack() {
                  Column()
                    .width('100%')
                    .height(120)
                    .backgroundColor('#E0E0E0')
                    .borderRadius(8)
                  Text(product.name.charAt(0).toUpperCase())
                    .fontSize(32)
                    .fontColor('#FFFFFF')
                    .fontWeight(FontWeight.Bold)
                }
                .width('100%')
                .height(120)
                .alignContent(Alignment.Center)

                Text(product.name)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ top: 8 })
                  .width('100%')
                  .textAlign(TextAlign.Center)

                Text(`$${product.price.toFixed(2)}`)
                  .fontSize(16)
                  .fontColor('#FF6B6B')
                  .fontWeight(FontWeight.Bold)
                  .margin({ top: 4 })
              }
              .padding(8)
              .borderRadius(12)
              .backgroundColor('#FFFFFF')
              .shadow({ radius: 4, color: '#00000020', offsetX: 0, offsetY: 2 })
              .onClick(() => {
                this.selectedProduct = product;
              })
            }
            .width('100%')
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .padding(16)
        .width('100%')
        .layoutWeight(1)

        // Cart indicator
        Row() {
          Text(`Cart (${this.cartCount})`)
            .fontSize(16)
            .fontColor('#FFFFFF')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .backgroundColor('#FF6B6B')
            .borderRadius(20)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    } else {
      // Product detail view
      Column() {
        // Back button
        Row() {
          Button() {
            Text('← Back')
              .fontSize(16)
              .fontColor('#FF6B6B')
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.selectedProduct = null;
          })
        }
        .width('100%')
        .padding(16)
        .justifyContent(FlexAlign.Start)

        // Product image placeholder (larger)
        Stack() {
          Column()
            .width('100%')
            .height(200)
            .backgroundColor('#E0E0E0')
            .borderRadius(12)
          Text(this.selectedProduct.name.charAt(0).toUpperCase())
            .fontSize(48)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height(200)
        .alignContent(Alignment.Center)
        .margin({ left: 16, right: 16 })

        // Product name
        Text(this.selectedProduct.name)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 16, left: 16, right: 16 })
          .width('100%')
          .textAlign(TextAlign.Start)

        // Price
        Text(`$${this.selectedProduct.price.toFixed(2)}`)
          .fontSize(20)
          .fontColor('#FF6B6B')
          .fontWeight(FontWeight.Bold)
          .margin({ top: 8, left: 16, right: 16 })
          .width('100%')
          .textAlign(TextAlign.Start)

        // Description
        Text(this.selectedProduct.description)
          .fontSize(16)
          .fontColor('#666666')
          .margin({ top: 12, left: 16, right: 16 })
          .width('100%')
          .textAlign(TextAlign.Start)

        // Add to Cart button
        Button() {
          Text('Add to Cart')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold)
        }
        .width('90%')
        .height(48)
        .backgroundColor('#FF6B6B')
        .borderRadius(24)
        .margin({ top: 24, bottom: 32 })
        .onClick(() => {
          this.cartCount++;
          promptAction.showToast({
            message: `${this.selectedProduct.name} added to cart!`,
            duration: 2000
          });
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
  }
}