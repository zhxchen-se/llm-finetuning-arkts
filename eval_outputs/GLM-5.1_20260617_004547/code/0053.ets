@Entry
@Component
struct Index {
  @State dragResult: string = 'Waiting for drag and drop...';
  private resolvePromise: ((value: string) => void) | null = null;

  @Builder
  dragPreviewBuilder() {
    Column() {
      Text('Dragging Item')
        .fontColor(Color.White)
        .fontSize(14)
    }
    .width(120)
    .height(60)
    .backgroundColor(Color.Orange)
    .justifyContent(FlexAlign.Center)
    .borderRadius(10)
    .opacity(0.8)
  }

  build() {
    Column({ space: 20 }) {
      Text('Drag and Drop with Promise')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      Row({ space: 40 }) {
        // Draggable Item
        Column() {
          Text('Drag Me')
            .fontColor(Color.White)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
        }
        .width(120)
        .height(120)
        .backgroundColor(Color.Blue)
        .justifyContent(FlexAlign.Center)
        .borderRadius(12)
        .onDragStart((event: DragEvent) => {
          // Pass the object to be dragged and carry dragging information
          const dragData = JSON.stringify({ id: 'ITEM_001', name: 'HarmonyOS Item' });
          event.setData('text/plain', dragData);

          // Actively initiate Promise to return the result
          const dropPromise = new Promise<string>((resolve) => {
            this.resolvePromise = resolve;
          });

          dropPromise.then((result) => {
            this.dragResult = result;
          });

          // Return the custom drag preview
          return this.dragPreviewBuilder;
        })

        // Drop Target
        Column() {
          Text('Drop Here')
            .fontColor(Color.White)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
        }
        .width(120)
        .height(120)
        .backgroundColor(Color.Green)
        .justifyContent(FlexAlign.Center)
        .borderRadius(12)
        .onDrop((event: DragEvent) => {
          // Retrieve the dragging information
          const receivedData = event.getData('text/plain');
          
          // Resolve the Promise with the result
          if (this.resolvePromise) {
            this.resolvePromise(`Drop successful! Received: ${receivedData}`);
            this.resolvePromise = null;
          }
        })
      }
      .margin({ top: 40 })

      // Result Display
      Text(this.dragResult)
        .fontSize(16)
        .fontColor(Color.Black)
        .margin({ top: 40 })
        .padding(20)
        .backgroundColor('#F0F0F0')
        .borderRadius(8)
        .maxLines(3)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }
}