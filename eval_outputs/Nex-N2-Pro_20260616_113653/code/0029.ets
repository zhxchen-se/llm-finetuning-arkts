import {
  Alignment,
  Button,
  Column,
  FlexAlign,
  ForEach,
  FontColor,
  FontWeight,
  Grid,
  GridItem,
  Image,
  ImageFit,
  Row,
  Scroll,
  Stack,
  TextAlign,
  Text,
  VerticalAlign
} from '@kit.ArkUI';

interface Product {
  id: number;
  name: string;
  price: number;
  image: string;
  description: string;
  category: string;
  rating: number;
  stock: number;
}

@Entry
@Component
struct Index {
  @State selectedProductIndex: number = -1;
  @State cartCount: number = 0;
  @State addedProductId: number = -1;

  products: Product[] = [
    {
      id: 1,
      name: 'Wireless Headphones',
      price: 89.99,
      image: 'https://picsum.photos/seed/arkts-headphones/600/600',
      description: 'Premium noise-cancelling wireless headphones with deep bass, soft ear cushions, and all-day battery life.',
      category: 'Electronics',
      rating: 4.8,
      stock: 18
    },
    {
      id: 2,
      name: 'Smart Watch',
      price: 149.99,
      image: 'https://picsum.photos/seed/arkts-watch/600/600',
      description: 'A sleek smart watch with fitness tracking, heart-rate monitoring, notifications, and water resistance.',
      category: 'Wearables',
      rating: 4.6,
      stock: 12
    },
    {
      id: 3,
      name: 'Running Shoes',
      price: 74.50,
      image: 'https://picsum.photos/seed/arkts-shoes/600/600',
      description: 'Lightweight running shoes designed for comfort, breathability, and reliable support during daily workouts.',
      category: 'Sports',
      rating: 4.7,
      stock: 24
    },
    {
      id: 4,
      name: 'Leather Backpack',
      price: 119.00,
      image: 'https://picsum.photos/seed/arkts-backpack/600/600',
      description: 'A durable leather backpack with padded laptop storage, multiple compartments, and a modern design.',
      category: 'Bags',
      rating: 4.9,
      stock: 9
    },
    {
      id: 5,
      name: 'Coffee Maker',
      price: 64.99,
      image: 'https://picsum.photos/seed/arkts-coffee/600/600',
      description: 'Compact coffee maker with fast brewing, reusable filter, and simple one-touch operation.',
      category: 'Home',
      rating: 4.5,
      stock: 15
    },
    {
      id: 6,
      name: 'Desk Lamp',
      price: 39.99,
      image: 'https://picsum.photos/seed/arkts-lamp/600/600',
      description: 'Adjustable LED desk lamp with multiple brightness levels, eye-friendly lighting, and a slim profile.',
      category: 'Home Office',
      rating: 4.4,
      stock: 21
    }
  ];

  build() {
    Column() {
      if (this.selectedProductIndex === -1) {
        this.ProductList()
      } else {
        this.ProductDetail(this.products[this.selectedProductIndex])
      }
    }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F7FA')
  }

  @Builder
  ProductList() {
    Scroll() {
      Column() {
        Row() {
          Column() {
            Text('Product Store')
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')

            Text('Discover products and add them to your cart')
              .fontSize(14)
              .fontColor('#6B7280')
              .margin({ top: 6 })
          }
            .layoutWeight(1)

          Text('Cart ' + this.cartCount)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')
            .padding({ left: 14, right: 14, top: 10, bottom: 10 })
            .backgroundColor('#FFFFFF')
            .borderRadius(18)
            .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.08)', offsetX: 0, offsetY: 4 })
        }
          .width('100%')
          .padding({ left: 20, right: 20, top: 18, bottom: 14 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

        Grid() {
          ForEach(this.products, (product: Product, index: number) => {
            GridItem() {
              this.ProductCard(product, index)
            }
              .height(260)
          }, (product: Product) => product.id)
        }
          .width('100%')
          .columnsCount(2)
          .columnsGap(14)
          .rowsGap(14)
          .padding({ left: 16, right: 16, bottom: 24 })
      }
        .width('100%')
    }
      .width('100%')
      .height('100%')
  }

  @Builder
  ProductCard(product: Product, index: number) {
    Column() {
      Image(product.image)
        .width('100%')
        .height(132)
        .objectFit(ImageFit.Cover)
        .borderRadius(16)

      Column() {
        Text(product.name)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .maxLines(2)

        Text(product.category)
          .fontSize(12)
          .fontColor('#6B7280')
          .margin({ top: 4 })
      }
        .width('100%')

      Row() {
        Text('$' + product.price.toFixed(2))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#EA580C')

        Text('Details')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .padding({ left: 10, right: 10, top: 6, bottom: 6 })
          .backgroundColor('#111827')
          .borderRadius(14)
      }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
    }
      .width('100%')
      .height('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')
      .borderRadius(20)
      .shadow({ radius: 12, color: 'rgba(0, 0, 0, 0.08)', offsetX: 0, offsetY: 8 })
      .onClick(() => {
        this.selectedProductIndex = index
      })
  }

  @Builder
  ProductDetail(product: Product) {
    Scroll() {
      Column() {
        Stack({ alignContent: Alignment.Top }) {
          Image(product.image)
            .width('100%')
            .height(280)
            .objectFit(ImageFit.Cover)

          Row() {
            Row() {
              Button() {
                Text('←')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#111827')
              }
                .width(44)
                .height(44)
                .borderRadius(22)
                .backgroundColor('#FFFFFF')
                .onClick(() => {
                  this.selectedProductIndex = -1
                })

              Text('Product Details')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ left: 12 })
            }

            Text('Cart ' + this.cartCount)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .padding({ left: 14, right: 14, top: 10, bottom: 10 })
              .backgroundColor('rgba(255, 255, 255, 0.22)')
              .borderRadius(18)
          }
            .width('100%')
            .padding({ left: 16, right: 16, top: 14, bottom: 14 })
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
        }
          .width('100%')
          .height(280)

        Column() {
          Row() {
            Column() {
              Text(product.name)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111827')

              Text(product.category)
                .fontSize(14)
                .fontColor('#6B7280')
                .margin({ top: 6 })
            }
              .layoutWeight(1)

            Text('$' + product.price.toFixed(2))
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#EA580C')
              .textAlign(TextAlign.End)
          }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

          Text(product.description)
            .fontSize(15)
            .lineHeight(24)
            .fontColor('#4B5563')
            .margin({ top: 18 })

          Row() {
            Column() {
              Text('Rating')
                .fontSize(12)
                .fontColor('#6B7280')

              Text('★★★★★ ' + product.rating.toFixed(1))
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111827')
                .textAlign(TextAlign.Center)
            }

            Column() {
              Text('Stock')
                .fontSize(12)
                .fontColor('#6B7280')

              Text(product.stock + ' available')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111827')
                .textAlign(TextAlign.Center)
            }

            Column() {
              Text('Shipping')
                .fontSize(12)
                .fontColor('#6B7280')

              Text('Free delivery')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111827')
                .textAlign(TextAlign.Center)
            }
          }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({ top: 18, bottom: 18 })

          Column() {
            Text('Additional information')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
              .margin({ bottom: 10 })

            Text('• 30-day return policy')
              .fontSize(14)
              .fontColor('#4B5563')
              .margin({ bottom: 6 })

            Text('• Premium materials and durable finish')
              .fontSize(14)
              .fontColor('#4B5563')
              .margin({ bottom: 6 })

            Text('• Secure checkout and fast dispatch')
              .fontSize(14)
              .fontColor('#4B5563')
              .margin({ bottom: 6 })

            Text('• 1-year manufacturer warranty')
              .fontSize(14)
              .fontColor('#4B5563')
          }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFF7ED')
            .borderRadius(16)
            .margin({ top: 8 })

          Button() {
            Text(this.addedProductId === product.id ? 'Added to Cart' : 'Add to Cart')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
            .width('100%')
            .height(52)
            .borderRadius(16)
            .backgroundColor('#FF6B00')
            .margin({ top: 22 })
            .onClick(() => {
              if (this.addedProductId !== product.id) {
                this.addedProductId = product.id
              }
              this.cartCount += 1
            })
        }
          .width('100%')
          .padding({ left: 20, right: 20, bottom: 30 })
          .backgroundColor('#FFFFFF')
          .borderRadius({ topLeft: 24, topRight: 24 })
          .margin({ top: -24 })
      }
    }
      .width('100%')
      .height('100%')
  }
}