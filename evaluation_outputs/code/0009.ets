import display from '@ohos.display';

@Entry
@Component
struct Index {
  @State displayWidthVp: number = 0;
  @State displayHeightVp: number = 0;
  private ctx: CanvasRenderingContext2D | null = null;
  private isDrawing: boolean = false;
  private lastX: number = 0;
  private lastY: number = 0;

  aboutToAppear() {
    const defaultDisplay = display.getDefaultDisplaySync();
    const densityPixels = defaultDisplay.densityPixels; // dpi
    // Convert px to vp: vp = px * 160 / densityPixels
    this.displayWidthVp = defaultDisplay.width * 160 / densityPixels;
    this.displayHeightVp = defaultDisplay.height * 160 / densityPixels;
  }

  build() {
    Stack() {
      Canvas(this.ctx)
        .width(this.displayWidthVp)
        .height(this.displayHeightVp)
        .onReady(() => {
          this.ctx = (this as any).getContext('2d', { antialias: true });
          if (this.ctx) {
            this.ctx.strokeStyle = '#ff0000';
            this.ctx.lineWidth = 5;
            this.ctx.lineCap = 'round';
            this.ctx.lineJoin = 'round';
          }
        })
        .onTouch((event: TouchEvent) => {
          if (event.touches.length === 0) return;
          const touch = event.touches[0];
          const x = touch.x; // vp coordinates
          const y = touch.y;

          switch (event.type) {
            case TouchType.Down:
              this.isDrawing = true;
              this.ctx?.beginPath();
              this.ctx?.moveTo(x, y);
              this.lastX = x;
              this.lastY = y;
              break;
            case TouchType.Move:
              if (this.isDrawing && this.ctx) {
                this.ctx.lineTo(x, y);
                this.ctx.stroke();
                this.lastX = x;
                this.lastY = y;
              }
              break;
            case TouchType.Up:
            case TouchType.Cancel:
              this.isDrawing = false;
              break;
          }
        })

      // Overlay showing screen dimensions
      Text(`Screen: ${this.displayWidthVp.toFixed(0)} x ${this.displayHeightVp.toFixed(0)} vp`)
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor('#88000000')
        .padding(8)
        .borderRadius(4)
        .position({ x: 10, y: 10 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }
}