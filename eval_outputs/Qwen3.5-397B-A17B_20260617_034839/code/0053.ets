import { DragInfo, DragEvent, DropInfo, DropEvent } from '@ohos.dragAndDrop';
import { promptAction } from '@ohos.promptAction';

interface DragData {
  id: number;
  content: string;
  timestamp: number;
}

class DragPromiseManager {
  private static instance: DragPromiseManager;
  private resolveFunc: ((value: string) => void) | null = null;
  private rejectFunc: ((reason: any) => void) | null = null;

  private constructor() {}

  static getInstance(): DragPromiseManager {
    if (!DragPromiseManager.instance) {
      DragPromiseManager.instance = new DragPromiseManager();
    }
    return DragPromiseManager.instance;
  }

  createPromise(): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      this.resolveFunc = resolve;
      this.rejectFunc = reject;
    });
  }

  resolveResult(result: string): void {
    if (this.resolveFunc) {
      this.resolveFunc(result);
      this.reset();
    }
  }

  rejectResult(reason: any): void {
    if (this.rejectFunc) {
      this.rejectFunc(reason);
      this.reset();
    }
  }

  private reset(): void {
    this.resolveFunc = null;
    this.rejectFunc = null;
  }
}

@Entry
@Component
struct Index {
  @State dragResult: string = 'Waiting for drag operation...';
  @State isDragging: boolean = false;
  private dragPromiseManager: DragPromiseManager = DragPromiseManager.getInstance();

  aboutToAppear() {
  }

  build() {
    Column() {
      Text('Drag and Drop with Promise')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      Text(this.dragResult)
        .fontSize(16)
        .fontColor('#666666')
        .margin({ bottom: 30 })
        .width('90%')
        .textAlign(TextAlign.Center)

      Row() {
        Column() {
          Text('Draggable Item')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .padding(10)
            .backgroundColor('#007DFF')
            .borderRadius(8)
            .onDragStart((event: DragEvent): DragInfo => {
              this.isDragging = true;
              this.dragResult = 'Drag initiated...';

              const dragData: DragData = {
                id: 1001,
                content: 'Hello HarmonyOS',
                timestamp: Date.now()
              };

              const dragInfo = new DragInfo();
              dragInfo.setData('dragObject', dragData);
              dragInfo.setData('status', 'active');

              this.handleDragStartPromise();

              return dragInfo;
            })
            .onDragEnd(() => {
              this.isDragging = false;
              if (this.dragResult === 'Drag initiated...') {
                this.dragResult = 'Drag cancelled';
              }
            })
        }
        .width(150)
        .height(150)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
        .borderRadius(10)
        .margin({ right: 20 })

        Column() {
          Text('Drop Zone')
            .fontSize(18)
            .fontColor('#333333')
            .onDrop((event: DropEvent): boolean => {
              const dragInfo = event.getDragInfo();
              const data = dragInfo.getData('dragObject') as DragData;
              const status = dragInfo.getData('status') as string;

              if (data && status === 'active') {
                const resultMessage = `Dropped: ${data.content} (ID: ${data.id})`;
                this.dragResult = resultMessage;
                this.dragPromiseManager.resolveResult(resultMessage);
                return true;
              }
              return false;
            })
            .onDragEnter(() => {
              // Optional visual feedback
            })
            .onDragLeave(() => {
              // Optional visual feedback
            })
        }
        .width(150)
        .height(150)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#E8E8E8')
        .borderRadius(10)
        .border({ width: 2, color: '#CCCCCC', style: BorderStyle.Dashed })
      }
      .margin({ top: 20 })

      Button('Check Promise Result')
        .onClick(async () => {
          if (this.isDragging) {
            this.dragResult = 'Waiting for drop...';
            return;
          }
          try {
            const promise = this.dragPromiseManager.createPromise();
            this.dragResult = 'New promise created. Drag item to resolve.';
            // In a real scenario, you might await this elsewhere.
            // Here we just demonstrate the promise chain capability.
            promise.then((res) => {
              console.info('Promise resolved with: ' + res);
            }).catch((err) => {
              console.error('Promise rejected: ' + err);
            });
          } catch (error) {
            this.dragResult = 'Error creating promise';
          }
        })
        .margin({ top: 40 })
        .backgroundColor('#007DFF')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }

  private async handleDragStartPromise(): Promise<void> {
    try {
      const promise = this.dragPromiseManager.createPromise();
      const result = await promise;
      this.dragResult = `Async Result: ${result}`;
    } catch (error) {
      this.dragResult = 'Drag operation failed';
    }
  }
}