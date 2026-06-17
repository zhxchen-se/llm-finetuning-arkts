import display from '@ohos.display';
import { RenderingContext2D } from '@ohos.canvas';
import { window } from '@ohos.window';
import { promptAction } from '@ohos.promptAction';

@Entry
@Component
struct Index {
  private canvasContext: RenderingContext2D | null = null;
  @State private brushColor: string = '#000000';
  @State private brushSize: number = 5;
  @State private brushAlpha: number = 1.0;
  @State private displayInfo: string = 'Loading display info...';
  private lastPoint: { x: number, y: number } | null = null;
  private isDrawing: boolean = false;

  aboutToAppear() {
    this.initDisplayInfo();
  }

  async initDisplayInfo() {
    try {
      // Using @ohos.display to get brightness and influence brush opacity
      const brightness = await display.getBrightness();
      // Normalize brightness (0-255) to alpha (0.2 - 1.0)
      this.brushAlpha = Math.max(0.2, Math.min(1.0, brightness / 255));
      this.displayInfo = `Brightness: ${brightness} | Alpha: ${this.brushAlpha.toFixed(2)}`;
    } catch (error) {
      this.displayInfo = 'Display info unavailable (Permission?)';
      console.error('Failed to get display brightness', error);
    }
  }

  private startDrawing(x: number, y: number) {
    this.isDrawing = true;
    this.lastPoint = { x, y };
    if (this.canvasContext) {
      this.canvasContext.beginPath();
      this.canvasContext.moveTo(x, y);
    }
  }

  private moveDrawing(x: number, y: number) {
    if (!this.isDrawing || !this.canvasContext || !this.lastPoint) return;

    this.canvasContext.strokeStyle = this.brushColor;
    this.canvasContext.lineWidth = this.brushSize;
    this.canvasContext.lineCap = 'round';
    this.canvasContext.lineJoin = 'round';
    this.canvasContext.globalAlpha = this.brushAlpha;

    this.canvasContext.lineTo(x, y);
    this.canvasContext.stroke();
    this.lastPoint = { x, y };
  }

  private stopDrawing() {
    this.isDrawing = false;
    this.lastPoint = null;
    if (this.canvasContext) {
      this.canvasContext.closePath();
    }
  }

  build() {
    Column() {
      Text('ArkTS Display & Draw')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      Text(this.displayInfo)
        .fontSize(14)
        .fontColor('#666666')
        .margin({ bottom: 10 })

      Row() {
        Button('Clear')
          .onClick(() => {
            if (this.canvasContext) {
              this.canvasContext.clearRect(0, 0, 1000, 1000); // Approximate clear
            }
          })
          .margin({ right: 10 })

        Button('Color')
          .onClick(() => {
            const colors = ['#000000', '#FF0000', '#00FF00', '#0000FF', '#FFA500'];
            const currentIdx = colors.indexOf(this.brushColor);
            this.brushColor = colors[(currentIdx + 1) % colors.length];
          })
      }
      .margin({ bottom: 10 })

      Canvas()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#CCCCCC' })
        .onReady((canvas: RenderingContext2D) => {
          this.canvasContext = canvas;
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.startDrawing(event.touches[0].x, event.touches[0].y);
          } else if (event.type === TouchType.Move) {
            this.moveDrawing(event.touches[0].x, event.touches[0].y);
          } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
            this.stopDrawing();
          }
        })
        .layoutWeight(1)
        .margin({ left: 10, right: 10 })
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }
}