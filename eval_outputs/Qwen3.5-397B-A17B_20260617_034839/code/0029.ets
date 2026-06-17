import {
  Entry,
  Component,
  State,
  Grid,
  GridItem,
  Column,
  Row,
  Text,
  Image,
  Button,
  Flex,
  FlexDirection,
  AlignItems,
  JustifyContent,
  Position,
  Display,
  Width,
  Height,
  Padding,
  Margin,
  BackgroundColor,
  FontSize,
  FontColor,
  TextAlign,
  BorderRadius,
  Shadow,
  ObjectFit,
  Stack,
  AlignContent
} from '@kit.ArkUI';

interface Product {
  id: number;
  name: string;
  price: number;
  description: string;
  imageUrl: string;
  category: string;
}

@Entry
@Component
struct Index {
  @State products: Product[] = [
    {
      id: 1,
      name: 'Wireless Headphones',
      price: 199.99,
      description: 'High-quality wireless headphones with noise cancellation and 20h battery life.',
      imageUrl: 'https://placehold.co/150x150/2196F3/FFFFFF?text=Headphones',
      category: 'Electronics'
    },
    {
      id: 2,
      name: 'Smart Watch',
      price: 299.50,
      description: 'Feature-rich smartwatch with health monitoring and GPS tracking.',
      imageUrl: 'https://placehold.co/150x150/4CAF50/FFFFFF?text=Watch',
      category: 'Wearables'
    },
    {
      id: 3,
      name: 'Running Shoes',
      price: 89.99,
      description: 'Lightweight running shoes designed for comfort and performance.',
      imageUrl: 'https://placehold.co/150x150/FF5722/FFFFFF?text=Shoes',
      category: 'Sports'
    },
    {
      id: 4,
      name: 'Backpack',
      price: 49.99,
      description: 'Durable backpack with laptop compartment and water-resistant material.',
      imageUrl: 'https://placehold.co/150x150/9C27B0/FFFFFF?text=Backpack',
      category: 'Accessories'
    },
    {
      id: 5,
      name: 'Coffee Maker',
      price: 120.00,
      description: 'Automatic coffee maker with programmable settings and thermal carafe.',
      imageUrl: 'https://placehold.co/150x150/795548/FFFFFF?text=Coffee',
      category: 'Home'
    },
    {
      id: 6,
      name: 'Desk Lamp',
      price: 35.00,
      description: 'LED desk lamp with adjustable brightness and color temperature.',
      imageUrl: 'https://placehold.co/150x150/FFC107/FFFFFF?text=Lamp',
      category: 'Home'
    }
  ];

  @State selectedProduct: Product | null = null;
  @State cartCount: number = 0;
  @State isDetailVisible: boolean = false;

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Text('Product Store')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
          Blank()
          Text(`Cart: ${this.cartCount}`)
            .fontSize(16)
            .fontColor('#2196F3')
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#10000000', offsetX: 0, offsetY: 2 })

        // Grid
        Grid() {
          ForEach(this.products, (product: Product) => {
            GridItem() {
              ProductCard({
                product: product,
                onClick: () => {
                  this.selectedProduct = product;
                  this.isDetailVisible = true;
                }
              })
            }
          }, (product: Product) => product.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('auto')
        .padding(16)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // Detail Overlay
      if (this.isDetailVisible && this.selectedProduct) {
        Column() {
          Stack() {
            Column() {
              Image(this.selectedProduct.imageUrl)
                .width('100%')
                .height(250)
                .objectFit(ObjectFit.Cover)
                .borderRadius({ topLeft: 0, topRight: 0, bottomLeft: 16, bottomRight: 16 })

              Column() {
                Text(this.selectedProduct.name)
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                  .margin({ top: 16, bottom: 8 })

                Text(`$${this.selectedProduct.price.toFixed(2)}`)
                  .fontSize(20)
                  .fontColor('#2196F3')
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 16 })

                Text('Category')
                  .fontSize(14)
                  .fontColor('#888888')
                Text(this.selectedProduct.category)
                  .fontSize(16)
                  .fontColor('#333333')
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 16 })

                Text('Description')
                  .fontSize(14)
                  .fontColor('#888888')
                Text(this.selectedProduct.description)
                  .fontSize(16)
                  .fontColor('#555555')
                  .lineHeight(24)
                  .margin({ bottom: 24 })

                Button('Add to Cart')
                  .width('100%')
                  .height(50)
                  .backgroundColor('#2196F3')
                  .fontColor('#FFFFFF')
                  .fontSize(18)
                  .borderRadius(25)
                  .onClick(() => {
                    this.cartCount++;
                    this.isDetailVisible = false;
                    this.selectedProduct = null;
                  })
              }
              .padding(24)
              .backgroundColor('#FFFFFF')
              .width('100%')
              .layoutWeight(1)
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius({ topLeft: 16, topRight: 16, bottomLeft: 16, bottomRight: 16 })
            .shadow({ radius: 10, color: '#20000000', offsetX: 0, offsetY: 5 })

            // Close Button
            Button() {
              Text('✕')
                .fontSize(20)
                .fontColor('#FFFFFF')
            }
            .width(40)
            .height(40)
            .backgroundColor('#888888')
            .borderRadius(20)
            .position({ x: 20, y: 20 })
            .onClick(() => {
              this.isDetailVisible = false;
              this.selectedProduct = null;
            })
          }
          .width('90%')
          .height('85%')
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 20, color: '#40000000', offsetX: 0, offsetY: 10 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0, 0, 0, 0.5)')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ProductCard {
  @Link product: Product;
  onClick: () => void = () => {};

  build() {
    Column() {
      Image(this.product.imageUrl)
        .width('100%')
        .aspectRatio(1)
        .objectFit(ObjectFit.Cover)
        .borderRadius(12)
        .margin({ bottom: 8 })

      Text(this.product.name)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .textAlign(TextAlign.Start)

      Text(`$${this.product.price.toFixed(2)}`)
        .fontSize(14)
        .fontColor('#2196F3')
        .fontWeight(FontWeight.Bold)
        .margin({ top: 4 })
        .width('100%')
        .textAlign(TextAlign.Start)
    }
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#10000000', offsetX: 0, offsetY: 2 })
    .width('100%')
    .height('100%')
    .onClick(() => {
      this.onClick();
    })
  }
}