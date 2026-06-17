@Entry
@Component
struct Index {
  @State heightInput: string = ''
  @State weightInput: string = ''
  @State bmiResult: string = ''
  @State bmiCategory: string = ''
  @State resultColor: ResourceColor = '#000000'

  calculateBMI() {
    const heightCm = parseFloat(this.heightInput)
    const weightKg = parseFloat(this.weightInput)

    if (isNaN(heightCm) || isNaN(weightKg) || heightCm <= 0 || weightKg <= 0) {
      this.bmiResult = 'Invalid input'
      this.bmiCategory = 'Please enter valid numbers'
      this.resultColor = '#FF0000'
      return
    }

    const heightM = heightCm / 100
    const bmi = weightKg / (heightM * heightM)
    this.bmiResult = `BMI: ${bmi.toFixed(2)}`

    if (bmi < 18.5) {
      this.bmiCategory = 'Underweight'
      this.resultColor = '#3498DB'
    } else if (bmi < 25) {
      this.bmiCategory = 'Normal'
      this.resultColor = '#2ECC71'
    } else if (bmi < 30) {
      this.bmiCategory = 'Overweight'
      this.resultColor = '#F39C12'
    } else {
      this.bmiCategory = 'Obese'
      this.resultColor = '#E74C3C'
    }
  }

  build() {
    Column() {
      Text('BMI Calculator')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 40 })

      // Height Input
      Row() {
        Text('Height (cm)')
          .fontSize(18)
          .width('35%')
          .fontWeight(FontWeight.Medium)
        
        TextInput({ placeholder: 'e.g. 175' })
          .type(InputType.Number)
          .width('65%')
          .height(45)
          .borderRadius(10)
          .backgroundColor('#F0F0F0')
          .padding({ left: 15 })
          .onChange((value: string) => {
            this.heightInput = value
          })
      }
      .width('90%')
      .margin({ bottom: 20 })

      // Weight Input
      Row() {
        Text('Weight (kg)')
          .fontSize(18)
          .width('35%')
          .fontWeight(FontWeight.Medium)
        
        TextInput({ placeholder: 'e.g. 70' })
          .type(InputType.Number)
          .width('65%')
          .height(45)
          .borderRadius(10)
          .backgroundColor('#F0F0F0')
          .padding({ left: 15 })
          .onChange((value: string) => {
            this.weightInput = value
          })
      }
      .width('90%')
      .margin({ bottom: 40 })

      // Calculate Button
      Button('Calculate')
        .width('90%')
        .height(50)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .backgroundColor('#007DFF')
        .borderRadius(10)
        .onClick(() => {
          this.calculateBMI()
        })

      // Result Display
      Column() {
        if (this.bmiResult) {
          Text(this.bmiResult)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 10 })
          
          Text(this.bmiCategory)
            .fontSize(22)
            .fontColor(this.resultColor)
            .fontWeight(FontWeight.Medium)
        }
      }
      .margin({ top: 40 })
      .width('90%')
      .alignItems(HorizontalAlign.Center)

      // BMI Categories Info
      Column() {
        Text('BMI Categories:')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 8 })
        
        Text('Underweight: < 18.5')
          .fontSize(14)
          .fontColor('#3498DB')
          .margin({ bottom: 4 })
        
        Text('Normal: 18.5 – 24.9')
          .fontSize(14)
          .fontColor('#2ECC71')
          .margin({ bottom: 4 })
        
        Text('Overweight: 25 – 29.9')
          .fontSize(14)
          .fontColor('#F39C12')
          .margin({ bottom: 4 })
        
        Text('Obese: ≥ 30')
          .fontSize(14)
          .fontColor('#E74C3C')
      }
      .width('90%')
      .margin({ top: 40 })
      .padding(15)
      .borderRadius(10)
      .backgroundColor('#F9F9F9')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .padding({ top: 60 })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}