import dragController from '@ohos.arkui.dragController';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State resultText: string = 'No result yet';
  @State dragData: string = 'Sample Item';

  // Custom drag preview builder
  @Builder
  DragPreviewBuilder() {
    Column() {
      Text(this.dragData)
        .fontSize(16)
        .fontColor(Color.White)
        .padding(10)
        .backgroundColor(Color.Blue)
        .borderRadius(8)
    }
    .width(100)
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  // Start drag programmatically
  async startDrag(pointerId: number) {
    try {
      const dragInfo: dragController.DragInfo = {
        pointerId: pointerId,
        data: this.dragData, // The object to be dragged
        previewOptions: {
          builder: this.DragPreviewBuilder.bind(this),
        }
      };

      // Initiate drag and wait for the drop result via Promise
      const result = await dragController.startDrag(dragInfo);
      if (result && result.result !== undefined) {
        this.resultText = `Drop result: ${result.result}`;
      } else {
        this.resultText = 'Drag cancelled or no result';
      }
    } catch (err) {
      this.resultText = `Drag failed: ${JSON.stringify(err)}`;
    }
  }

  build() {
    Column() {
      // Source area
      Column() {
        Text('Source Area')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10 })

        Button('Start Drag')
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down) {
              // Actively initiate dragging with the touch pointer ID
              this.startDrag(event.touches[0].id);
            }
          })
          .margin({ bottom: 10 })

        Text(`Dragged object: ${this.dragData}`)
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .width('90%')
      .padding(20)
      .backgroundColor('#F0F0F0')
      .borderRadius(12)
      .margin({ bottom: 20 })

      // Drop target area
      Column() {
        Text('Drop Target Area')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10 })

        Text('Drop here')
          .fontSize(16)
          .fontColor(Color.White)
      }
      .width('90%')
      .height(150)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFA500')
      .borderRadius(12)
      .onDrop((event: DragEvent) => {
        // Return a Promise that resolves with the result information
        return new Promise<string>((resolve) => {
          // Simulate asynchronous processing
          setTimeout(() => {
            resolve('Drop successful!');
          }, 500);
        });
      })
      .onDragEnter(() => {
        // Visual feedback when drag enters
        promptAction.showToast({ message: 'Drag entered' });
      })

      // Result display
      Text(this.resultText)
        .fontSize(16)
        .fontColor(Color.Black)
        .margin({ top: 20 })
        .padding(10)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}