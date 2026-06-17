@Entry
@Component
struct Index {
  @State displayValue: string = '0'
  @State previousValue: string = ''
  @State operator: string = ''
  @State waitingForOperand: boolean = false

  private colors = {
    background: '#000000',
    display: '#333333',
    numberBtn: '#333333',
    operatorBtn: '#FF9F0A',
    functionBtn: '#A5A5A5',
    textLight: '#FFFFFF',
    textDark: '#000000'
  }

  aboutToAppear() {
  }

  private inputDigit(digit: string) {
    if (this.waitingForOperand) {
      this.displayValue = digit
      this.waitingForOperand = false
    } else {
      this.displayValue = this.displayValue === '0' ? digit : this.displayValue + digit
    }
  }

  private inputDot() {
    if (this.waitingForOperand) {
      this.displayValue = '0.'
      this.waitingForOperand = false
    } else if (this.displayValue.indexOf('.') === -1) {
      this.displayValue += '.'
    }
  }

  private clearDisplay() {
    this.displayValue = '0'
    this.previousValue = ''
    this.operator = ''
    this.waitingForOperand = false
  }

  private performOperation(nextOperator: string) {
    const inputValue = parseFloat(this.displayValue)

    if (this.previousValue === '') {
      this.previousValue = this.displayValue
    } else if (this.operator) {
      const currentValue = parseFloat(this.previousValue)
      const newValue = this.calculate(currentValue, inputValue, this.operator)
      this.displayValue = String(newValue)
      this.previousValue = this.displayValue
    }

    this.waitingForOperand = true
    this.operator = nextOperator
  }

  private calculate(left: number, right: number, op: string): number {
    switch (op) {
      case '+': return left + right
      case '-': return left - right
      case '*': return left * right
      case '/': return right !== 0 ? left / right : 0
      default: return right
    }
  }

  private handleEqual() {
    if (this.operator && !this.waitingForOperand) {
      const inputValue = parseFloat(this.displayValue)
      const currentValue = parseFloat(this.previousValue)
      const newValue = this.calculate(currentValue, inputValue, this.operator)
      this.displayValue = String(newValue)
      this.previousValue = ''
      this.operator = ''
      this.waitingForOperand = true
    }
  }

  @Builder
  CalcButton(label: string, color: string, textColor: string, onClick: () => void) {
    Button() {
      Text(label)
        .fontSize(24)
        .fontColor(textColor)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(70)
    .backgroundColor(color)
    .borderRadius(35)
    .onClick(onClick)
  }

  build() {
    Column() {
      // Display Area
      Column() {
        Text(this.displayValue)
          .width('100%')
          .fontSize(48)
          .fontColor(this.colors.textLight)
          .textAlign(TextAlign.End)
          .padding({ right: 20, top: 20, bottom: 20 })
          .maxLines(1)
      }
      .width('100%')
      .height(150)
      .backgroundColor(this.colors.display)
      .borderRadius({ bottomLeft: 20, bottomRight: 20 })

      // Keypad Area
      Grid() {
        // Row 1
        GridItem() { this.CalcButton('C', this.colors.functionBtn, this.colors.textDark, () => this.clearDisplay()) }
        GridItem() { this.CalcButton('+/-', this.colors.functionBtn, this.colors.textDark, () => { this.displayValue = String(parseFloat(this.displayValue) * -1) }) }
        GridItem() { this.CalcButton('%', this.colors.functionBtn, this.colors.textDark, () => { this.displayValue = String(parseFloat(this.displayValue) / 100) }) }
        GridItem() { this.CalcButton('÷', this.colors.operatorBtn, this.colors.textLight, () => this.performOperation('/')) }

        // Row 2
        GridItem() { this.CalcButton('7', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('7')) }
        GridItem() { this.CalcButton('8', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('8')) }
        GridItem() { this.CalcButton('9', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('9')) }
        GridItem() { this.CalcButton('×', this.colors.operatorBtn, this.colors.textLight, () => this.performOperation('*')) }

        // Row 3
        GridItem() { this.CalcButton('4', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('4')) }
        GridItem() { this.CalcButton('5', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('5')) }
        GridItem() { this.CalcButton('6', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('6')) }
        GridItem() { this.CalcButton('−', this.colors.operatorBtn, this.colors.textLight, () => this.performOperation('-')) }

        // Row 4
        GridItem() { this.CalcButton('1', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('1')) }
        GridItem() { this.CalcButton('2', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('2')) }
        GridItem() { this.CalcButton('3', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('3')) }
        GridItem() { this.CalcButton('+', this.colors.operatorBtn, this.colors.textLight, () => this.performOperation('+')) }

        // Row 5
        GridItem() {
          this.CalcButton('0', this.colors.numberBtn, this.colors.textLight, () => this.inputDigit('0'))
            .width('100%')
            .borderRadius(35)
        }
        GridItem() { this.CalcButton('.', this.colors.numberBtn, this.colors.textLight, () => this.inputDot()) }
        GridItem() { this.CalcButton('=', this.colors.operatorBtn, this.colors.textLight, () => this.handleEqual()) }
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(15)
      .columnsGap(15)
      .padding(15)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}