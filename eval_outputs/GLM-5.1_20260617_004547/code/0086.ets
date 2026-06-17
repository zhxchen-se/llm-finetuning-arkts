@Entry
@Component
struct Index {
  @State currentInput: string = '0';
  @State previousInput: string = '';
  @State operator: string = '';
  @State isResultShown: boolean = false;

  @Builder
  CalcButton(text: string, type: string) {
    Button(text)
      .layoutWeight(type === 'zero' ? 2 : 1)
      .height(70)
      .fontSize(28)
      .fontWeight(FontWeight.Medium)
      .fontColor(type === 'top' ? '#000000' : '#FFFFFF')
      .backgroundColor(type === 'number' || type === 'zero' ? '#333333' : type === 'top' ? '#A5A5A5' : '#FF9F0A')
      .borderRadius(35)
      .onClick(() => this.handleButtonClick(text))
  }

  handleButtonClick(value: string) {
    if ('0123456789'.includes(value)) {
      if (this.isResultShown) {
        this.currentInput = value;
        this.isResultShown = false;
      } else {
        this.currentInput = this.currentInput === '0' ? value : this.currentInput + value;
      }
    } else if (['+', '-', '*', '/'].includes(value)) {
      this.setOperator(value);
    } else if (value === '=') {
      this.calculate();
    } else if (value === 'C') {
      this.clear();
    } else if (value === '.') {
      if (!this.currentInput.includes('.')) {
        this.currentInput += '.';
      }
    } else if (value === '+/-') {
      if (this.currentInput !== '0') {
        this.currentInput = this.currentInput.startsWith('-') ?
          this.currentInput.substring(1) : '-' + this.currentInput;
      }
    } else if (value === '%') {
      this.currentInput = (parseFloat(this.currentInput) / 100).toString();
    }
  }

  setOperator(op: string) {
    if (this.currentInput === '0' && this.operator) {
      this.operator = op;
      return;
    }
    if (this.operator && !this.isResultShown) {
      this.calculate();
    }
    this.previousInput = this.currentInput;
    this.operator = op;
    this.currentInput = '0';
    this.isResultShown = false;
  }

  calculate() {
    if (!this.operator || this.previousInput === '') return;

    let prev = parseFloat(this.previousInput);
    let current = parseFloat(this.currentInput);
    let res = 0;

    switch (this.operator) {
      case '+':
        res = prev + current;
        break;
      case '-':
        res = prev - current;
        break;
      case '*':
        res = prev * current;
        break;
      case '/':
        res = current !== 0 ? prev / current : 0;
        break;
    }

    let resStr = res.toString();
    if (resStr.includes('.') && resStr.length > 10) {
      res = parseFloat(res.toFixed(8));
    }
    this.currentInput = res.toString();
    this.operator = '';
    this.previousInput = '';
    this.isResultShown = true;
  }

  clear() {
    this.currentInput = '0';
    this.operator = '';
    this.previousInput = '';
    this.isResultShown = false;
  }

  build() {
    Column() {
      Column() {
        Text(this.previousInput + ' ' + this.operator)
          .fontSize(24)
          .fontColor('#AAAAAA')
          .width('100%')
          .textAlign(TextAlign.End)
          .margin({ bottom: 10 })

        Text(this.currentInput)
          .fontSize(60)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.End)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 20, right: 20 })
      .justifyContent(FlexAlign.End)

      Column({ space: 15 }) {
        Row({ space: 15 }) {
          this.CalcButton('C', 'top')
          this.CalcButton('+/-', 'top')
          this.CalcButton('%', 'top')
          this.CalcButton('/', 'operator')
        }

        Row({ space: 15 }) {
          this.CalcButton('7', 'number')
          this.CalcButton('8', 'number')
          this.CalcButton('9', 'number')
          this.CalcButton('*', 'operator')
        }

        Row({ space: 15 }) {
          this.CalcButton('4', 'number')
          this.CalcButton('5', 'number')
          this.CalcButton('6', 'number')
          this.CalcButton('-', 'operator')
        }

        Row({ space: 15 }) {
          this.CalcButton('1', 'number')
          this.CalcButton('2', 'number')
          this.CalcButton('3', 'number')
          this.CalcButton('+', 'operator')
        }

        Row({ space: 15 }) {
          this.CalcButton('0', 'zero')
          this.CalcButton('.', 'number')
          this.CalcButton('=', 'operator')
        }
      }
      .width('100%')
      .layoutWeight(2)
      .padding({ left: 20, right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}