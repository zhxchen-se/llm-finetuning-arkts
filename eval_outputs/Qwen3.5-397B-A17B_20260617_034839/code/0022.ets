import { FontWeight, InputType } from '@ohos.base';

@Entry
@Component
struct Index {
  @State weight: string = '';
  @State height: string = '';
  @State bmiResult: string = '';
  @State category: string = '';
  @State showResult: boolean = false;

  build() {
    Column() {
      Text('BMI Calculator')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50, bottom: 40 })
        .fontColor('#333333')

      Column() {
        Row() {
          Text('Weight (kg)')
            .fontSize(18)
            .width(120)
            .fontColor('#555555')
          TextInput({ placeholder: 'e.g. 70' })
            .onChange((value: string) => {
              this.weight = value;
            })
            .type(InputType.Number)
            .layoutWeight(1)
            .padding(10)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }
        .width('90%')
        .margin({ bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Height (cm)')
            .fontSize(18)
            .width(120)
            .fontColor('#555555')
          TextInput({ placeholder: 'e.g. 175' })
            .onChange((value: string) => {
              this.height = value;
            })
            .type(InputType.Number)
            .layoutWeight(1)
            .padding(10)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }
        .width('90%')
        .margin({ bottom: 30 })
        .alignItems(VerticalAlign.Center)

        Button('Calculate BMI')
          .width('90%')
          .height(50)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#007DFF')
          .borderRadius(25)
          .onClick(() => {
            this.calculateBMI();
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      if (this.showResult) {
        Column() {
          Text('Your BMI')
            .fontSize(20)
            .fontColor('#666666')
            .margin({ bottom: 10 })
          Text(this.bmiResult)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#007DFF')
            .margin({ bottom: 10 })
          Text(this.category)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .padding({ top: 10, bottom: 10, left: 20, right: 20 })
            .backgroundColor('#E6F7FF')
            .borderRadius(10)
        }
        .margin({ top: 40 })
        .alignItems(HorizontalAlign.Center)
        .animation({
          duration: 500,
          curve: Curve.Ease
        })
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
  }

  calculateBMI() {
    const weightVal = parseFloat(this.weight);
    const heightVal = parseFloat(this.height);

    if (isNaN(weightVal) || isNaN(heightVal) || weightVal <= 0 || heightVal <= 0) {
      this.bmiResult = 'Invalid Input';
      this.category = 'Please enter valid numbers';
      this.showResult = true;
      return;
    }

    const heightInMeters = heightVal / 100;
    const bmi = weightVal / (heightInMeters * heightInMeters);
    this.bmiResult = bmi.toFixed(2);

    if (bmi < 18.5) {
      this.category = 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      this.category = 'Normal Weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      this.category = 'Overweight';
    } else {
      this.category = 'Obese';
    }
    this.showResult = true;
  }
}