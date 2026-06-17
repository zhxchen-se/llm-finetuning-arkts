@Entry
@Component
struct Index {
  @State count: number = 0;
  @State message: string = 'Hello ArkTS';
  @State isChecked: boolean = false;

  private numbers: number[] = [1, 2, 3, 4, 5];
  private users: string[] = ['Alice', 'Bob', 'Charlie'];
  private calculator: Calculator = new Calculator();

  build() {
    Column() {
      Text('ArkTS Syntax Examples')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      this.showVariableSyntax()
      this.showDataTypeSyntax()
      this.showConditionalSyntax()
      this.showLoopSyntax()
      this.showFunctionSyntax()
      this.showClassSyntax()
      this.showInterfaceSyntax()
      this.showEnumSyntax()
      this.showArraySyntax()
      this.showForEachSyntax()
      this.showStateSyntax()
      this.showEventSyntax()
      this.showTemplateLiteralSyntax()
      this.showTryCatchSyntax()

      Text(this.message)
        .fontSize(18)
        .fontColor('#1890ff')
        .margin({ top: 20 })

      Button('Increase Count')
        .onClick(() => {
          this.count++
          this.message = `Count is ${this.count}`
        })
        .margin({ top: 12 })

      Button(this.isChecked ? 'Unchecked' : 'Checked')
        .type(this.isChecked ? ButtonType.Capsule : ButtonType.Normal)
        .onClick(() => {
          this.isChecked = !this.isChecked
        })
        .margin({ top: 12 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }

  @Builder
  showVariableSyntax() {
    Text('1. Variable Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    Text('let can change, const cannot change')
      .fontSize(15)
      .fontColor(Color.Gray)
  }

  @Builder
  showDataTypeSyntax() {
    Text('2. Data Type Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    Text('number, string, boolean, void, any')
      .fontSize(15)
      .fontColor(Color.Gray)
  }

  @Builder
  showConditionalSyntax() {
    Text('3. Conditional Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    if (this.count >= 3) {
      Text('Count is greater than or equal to 3')
        .fontSize(15)
        .fontColor(Color.Green)
    } else {
      Text('Count is less than 3')
        .fontSize(15)
        .fontColor(Color.Orange)
    }
  }

  @Builder
  showLoopSyntax() {
    Text('4. Loop Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    ForEach(this.numbers, (item: number) => {
      Text(`Number: ${item}`)
        .fontSize(15)
        .fontColor(Color.Black)
    })
  }

  @Builder
  showFunctionSyntax() {
    Text('5. Function Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    Text(`10 + 20 = ${this.addNumbers(10, 20)}`)
      .fontSize(15)
      .fontColor(Color.Black)
  }

  @Builder
  showClassSyntax() {
    Text('6. Class Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    Text(`Calculator result: ${this.calculator.add(7, 8)}`)
      .fontSize(15)
      .fontColor(Color.Black)
  }

  @Builder
  showInterfaceSyntax() {
    Text('7. Interface Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    const user: UserInfo = {
      name: 'ArkTS Developer',
      age: 25
    }

    Text(`${user.name}, ${user.age} years old`)
      .fontSize(15)
      .fontColor(Color.Black)
  }

  @Builder
  showEnumSyntax() {
    Text('8. Enum Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    const status: Status = Status.Success

    Text(`Status: ${status}`)
      .fontSize(15)
      .fontColor(Color.Green)
  }

  @Builder
  showArraySyntax() {
    Text('9. Array Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    ForEach(this.users, (user: string) => {
      Text(`User: ${user}`)
        .fontSize(15)
        .fontColor(Color.Black)
    })
  }

  @Builder
  showForEachSyntax() {
    Text('10. ArkUI ForEach Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    ForEach(this.numbers, (item: number) => {
      Text(`ForEach item: ${item}`)
        .fontSize(15)
        .fontColor(Color.Black)
    }, (item: number) => item.toString())
  }

  @Builder
  showStateSyntax() {
    Text('11. State Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    Text(`@State count: ${this.count}`)
      .fontSize(15)
      .fontColor(Color.Black)

    Text(`@State isChecked: ${this.isChecked}`)
      .fontSize(15)
      .fontColor(Color.Black)
  }

  @Builder
  showEventSyntax() {
    Text('12. Event Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    Text('Button .onClick() changes state')
      .fontSize(15)
      .fontColor(Color.Gray)
  }

  @Builder
  showTemplateLiteralSyntax() {
    Text('13. Template Literal Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    Text(`Current message: ${this.message}`)
      .fontSize(15)
      .fontColor(Color.Black)
  }

  @Builder
  showTryCatchSyntax() {
    Text('14. Try Catch Syntax')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 12 })

    Text('try { } catch { } is used for error handling')
      .fontSize(15)
      .fontColor(Color.Gray)
  }

  private addNumbers(a: number, b: number): number {
    return a + b
  }
}

interface UserInfo {
  name: string
  age: number
}

enum Status {
  Pending = 'Pending',
  Success = 'Success',
  Failed = 'Failed'
}

class Calculator {
  add(a: number, b: number): number {
    return a + b
  }
}