import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State weight: string = '';
  @State height: string = '';
  @State bmiResult: string = '';
  @State bmiCategory: string = '';
  @State showResult: boolean = false;

  // Calculate BMI
  calculateBMI() {
    const w = parseFloat(this.weight);
    const h = parseFloat(this.height);

    if (isNaN(w) || isNaN(h) || w <= 0 || h <= 0) {
      promptAction.showToast({ message: 'Please enter valid positive numbers' });
      return;
    }

    // Convert height from cm to meters
    const heightInMeters = h / 100;
    const bmi = w / (heightInMeters * heightInMeters);
    const bmiFixed = bmi.toFixed(1);

    let category = '';
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      category = 'Normal weight';
    } else if (bmi >= 25 && bmi < 30) {
      category = 'Overweight';
    } else {
      category = 'Obese';
    }

    this.bmiResult = bmiFixed;
    this.bmiCategory = category;
    this.showResult = true;
  }

  // Clear inputs and result
  clearAll() {
    this.weight = '';
    this.height = '';
    this.bmiResult = '';
    this.bmiCategory = '';
    this.showResult = false;
  }

  build() {
    Column() {
      // Title
      Text('BMI Calculator')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })
        .textAlign(TextAlign.Center)

      // Weight input
      Text('Weight (kg)')
        .fontSize(18)
        .margin({ bottom: 5 })
        .width('100%')
      TextInput({ placeholder: 'Enter weight in kg', text: this.weight })
        .type(InputType.Number)
        .onChange((value: string) => {
          this.weight = value;
        })
        .width('100%')
        .margin({ bottom: 20 })

      // Height input
      Text('Height (cm)')
        .fontSize(18)
        .margin({ bottom: 5 })
        .width('100%')
      TextInput({ placeholder: 'Enter height in cm', text: this.height })
        .type(InputType.Number)
        .onChange((value: string) => {
          this.height = value;
        })
        .width('100%')
        .margin({ bottom: 30 })

      // Buttons row
      Row() {
        Button('Calculate')
          .width('45%')
          .fontSize(18)
          .onClick(() => {
            this.calculateBMI();
          })

        Button('Clear')
          .width('45%')
          .fontSize(18)
          .backgroundColor('#FF6347')
          .onClick(() => {
            this.clearAll();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 30 })

      // Result display
      if (this.showResult) {
        Column() {
          Text(`Your BMI: ${this.bmiResult}`)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 10 })

          Text(`Category: ${this.bmiCategory}`)
            .fontSize(20)
            .fontColor(this.getCategoryColor())
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#F0F0F0')
        .borderRadius(10)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
  }

  // Helper to get color based on category
  getCategoryColor(): string {
    switch (this.bmiCategory) {
      case 'Underweight':
        return '#FFA500'; // Orange
      case 'Normal weight':
        return '#32CD32'; // LimeGreen
      case 'Overweight':
        return '#FFD700'; // Gold
      case 'Obese':
        return '#FF4500'; // OrangeRed
      default:
        return '#000000';
    }
  }
}