import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State displayText: string = '0';
  @State currentInput: string = '';
  @State previousInput: string = '';
  @State operator: string = '';
  @State waitingForOperand: boolean = true;

  private buttonLabels: string[][] = [
    ['C', '±', '%', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['0', '.', '=', '']
  ];

  handleButtonPress(label: string) {
    if (label >= '0' && label <= '9') {
      if (this.waitingForOperand) {
        this.currentInput = label;
        this.waitingForOperand = false;
      } else {
        this.currentInput += label;
      }
      this.displayText = this.currentInput;
    } else if (label === '.') {
      if (this.waitingForOperand) {
        this.currentInput = '0.';
        this.waitingForOperand = false;
      } else if (this.currentInput.indexOf('.') === -1) {
        this.currentInput += '.';
      }
      this.displayText = this.currentInput;
    } else if (label === 'C') {
      this.currentInput = '';
      this.previousInput = '';
      this.operator = '';
      this.displayText = '0';
      this.waitingForOperand = true;
    } else if (label === '±') {
      if (this.currentInput !== '') {
        if (this.currentInput.startsWith('-')) {
          this.currentInput = this.currentInput.substring(1);
        } else {
          this.currentInput = '-' + this.currentInput;
        }
        this.displayText = this.currentInput;
      }
    } else if (label === '%') {
      if (this.currentInput !== '') {
        let value = parseFloat(this.currentInput) / 100;
        this.currentInput = value.toString();
        this.displayText = this.currentInput;
      }
    } else if (label === '=') {
      if (this.operator && !this.waitingForOperand) {
        let result = this.calculate(parseFloat(this.previousInput), parseFloat(this.currentInput), this.operator);
        this.displayText = result.toString();
        this.currentInput = result.toString();
        this.previousInput = '';
        this.operator = '';
        this.waitingForOperand = true;
      }
    } else {
      // operator: +, -, ×, ÷
      if (this.operator && !this.waitingForOperand) {
        let result = this.calculate(parseFloat(this.previousInput), parseFloat(this.currentInput), this.operator);
        this.displayText = result.toString();
        this.currentInput = result.toString();
      }
      this.previousInput = this.currentInput;
      this.operator = label;
      this.waitingForOperand = true;
    }
  }

  calculate(a: number, b: number, op: string): number {
    switch (op) {
      case '+': return a + b;
      case '-': return a - b;
      case '×': return a * b;
      case '÷':
        if (b === 0) {
          promptAction.showToast({ message: 'Cannot divide by zero' });
          return 0;
        }
        return a / b;
      default: return b;
    }
  }

  build() {
    Column() {
      // Display
      Text(this.displayText)
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.End)
        .width('100%')
        .padding({ right: 20, top: 40, bottom: 20 })
        .backgroundColor('#f0f0f0')
        .borderRadius(10)
        .margin({ bottom: 10 })

      // Button grid
      Grid() {
        ForEach(this.buttonLabels, (row: string[]) => {
          ForEach(row, (label: string) => {
            GridItem() {
              if (label !== '') {
                Button(label)
                  .width('100%')
                  .height(70)
                  .fontSize(24)
                  .backgroundColor(this.getButtonColor(label))
                  .borderRadius(8)
                  .onClick(() => this.handleButtonPress(label))
              } else {
                // Empty placeholder for last cell in row 5 (0, ., =, empty)
                Button('')
                  .width('100%')
                  .height(70)
                  .backgroundColor(Color.Transparent)
                  .enabled(false)
              }
            }
          })
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(8)
      .columnsGap(8)
      .width('100%')
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffffff')
    .padding(20)
  }

  getButtonColor(label: string): ResourceColor {
    if (label === 'C' || label === '±' || label === '%') {
      return '#a5a5a5';
    } else if (label === '÷' || label === '×' || label === '-' || label === '+' || label === '=') {
      return '#ff9f0a';
    } else {
      return '#333333';
    }
  }
}