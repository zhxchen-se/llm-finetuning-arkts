import dragAndDrop from '@ohos.dragAndDrop';

interface DragPayload {
  id: string;
  title: string;
  source: string;
  uid: string;
  startedAt: string;
  startPoint: {
    x: number;
    y: number;
  };
}

interface DragInfo {
  uid: string;
  data: { [key: string]: DragPayload };
}

interface DragOptions {
  x: number;
  y: number;
}

@Entry
@Component
struct Index {
  private readonly dragType: string = 'application/x.harmony.active-drag';
  private touchX: number = 0;
  private touchY: number = 0;

  @State resultText: string = '触摸上方卡片主动发起拖拽，投放到下方区域。startDrag 的结果会通过 Promise 返回。';
  @State dropText: string = '尚未投放';

  private createDragObject(uid: string, source: string): DragPayload {
    return {
      id: `card-${uid}`,
      title: 'ArkTS 拖拽对象',
      source,
      uid,
      startedAt: Date.now().toString(),
      startPoint: {
        x: this.touchX,
        y: this.touchY
      }
    };
  }

  private createDragData(objectToDrag: DragPayload): { [key: string]: DragPayload } {
    const data: { [key: string]: DragPayload } = {};
    data[this.dragType] = objectToDrag;
    return data;
  }

  private async startActiveDrag(): Promise<boolean> {
    const uid: string = `active-${Date.now()}`;
    const objectToDrag: DragPayload = this.createDragObject(uid, 'startDrag');
    const dragInfo: DragInfo = {
      uid,
      data: this.createDragData(objectToDrag)
    };
    const dragOptions: DragOptions = {
      x: this.touchX,
      y: this.touchY
    };

    this.resultText = `startDrag 已发起，等待 Promise 返回；uid=${uid}`;
    return dragAndDrop.startDrag(dragInfo, dragOptions);
  }

  private handleDrop(event: DropEvent, zoneName: string): void {
    const received = event.getDataByType(this.dragType);
    let receivedText: string;

    if (received === undefined) {
      receivedText = 'undefined';
    } else if (typeof received === 'string') {
      receivedText = received;
    } else {
      const stringified = JSON.stringify(received);
      receivedText = stringified === undefined ? 'undefined' : stringified;
    }

    this.dropText = `${zoneName} 收到拖拽数据：${receivedText}`;
  }

  @Builder SourceCard() {
    Column() {
      Text('主动拖拽源')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)

      Text('在 onTouch(TouchType.Down) 中调用 startDrag')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 8 })

      Text(`拖拽信息携带 uid 与 data 对象；起点 x=${this.touchX}, y=${this.touchY}`)
        .fontSize(13)
        .fontColor('#333333')
        .margin({ top: 16 })
    }
    .width('86%')
    .height(150)
    .padding(16)
    .borderRadius(18)
    .backgroundColor('#E3F2FD')
    .border({ width: 1, color: '#1E88E5' })
    .draggable(true)
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down && event.touches.length > 0) {
        this.touchX = event.touches[0].x;
        this.touchY = event.touches[0].y;

        this.startActiveDrag()
          .then((result: boolean) => {
            this.resultText = `${this.resultText}\nPromise resolved：${result ? '成功' : '失败'}`;
          })
          .catch((err) => {
            this.resultText = `${this.resultText}\nPromise rejected：${JSON.stringify(err)}`;
          });
      }
    })
    .onDragStart((event: DragEvent) => {
      const uid: string = event.getUid();
      const objectToDrag: DragPayload = this.createDragObject(uid, 'onDragStart');
      this.resultText = `onDragStart 已返回待拖拽对象；uid=${uid}`;
      return this.createDragData(objectToDrag);
    })
    .onDragEnd((event: DragEvent) => {
      this.resultText = `${this.resultText}\nonDragEnd uid=${event.getUid()}`;
    })
  }

  @Builder DropZone(zoneName: string, bgColor: string, borderColor: string) {
    Column() {
      Text(zoneName)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Text('释放到此处触发 onDrop')
        .fontSize(14)
        .fontColor('#555555')
        .margin({ top: 8 })

      Text(this.dropText)
        .fontSize(13)
        .fontColor('#333333')
        .margin({ top: 12 })
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('86%')
    .height(116)
    .padding(14)
    .borderRadius(16)
    .backgroundColor(bgColor)
    .border({ width: 1, color: borderColor })
    .dropTargetArea(DropTargetArea.SELF_AND_CHILD)
    .onDrop((event: DropEvent) => {
      this.handleDrop(event, zoneName);
    })
  }

  build() {
    Column() {
      Text('主动拖拽 + 投放 + Promise 结果')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      this.SourceCard()

      Text(this.resultText)
        .width('86%')
        .padding(12)
        .borderRadius(12)
        .backgroundColor('#F5F5F5')
        .fontSize(13)
        .fontColor('#333333')
        .margin({ top: 16 })
        .maxLines(5)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text('投放区')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 8 })
        .alignSelf(HorizontalAlign.Start)

      this.DropZone('投放区 A', '#E8F5E9', '#4CAF50')
      this.DropZone('投放区 B', '#FFF3E0', '#FF9800')
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}