@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State score: number = 0
  @State isFinished: boolean = false

  private questions: Array<{ question: string, options: string[], answer: number }> = [
    {
      question: "What is the capital of France?",
      options: ["Berlin", "Madrid", "Paris", "Rome"],
      answer: 2
    },
    {
      question: "Which language is used for HarmonyOS app development?",
      options: ["Java", "ArkTS", "Python", "C++"],
      answer: 1
    },
    {
      question: "What is 2 + 2?",
      options: ["3", "4", "5", "6"],
      answer: 1
    }
  ]

  build() {
    Column() {
      if (!this.isFinished) {
        Text(this.questions[this.currentIndex].question)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 30 })
          .textAlign(TextAlign.Center)
          .width('90%')

        ForEach(this.questions[this.currentIndex].options, (option: string, index: number) => {
          Button(option)
            .width('80%')
            .height(50)
            .margin({ top: 10 })
            .backgroundColor('#007DFF')
            .fontSize(18)
            .onClick(() => {
              this.handleOptionSelect(index)
            })
        }, (item: string, index: number) => index.toString())
      } else {
        Text("Quiz Completed!")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 20 })

        Text(`Your Score: ${this.score} / ${this.questions.length}`)
          .fontSize(22)
          .margin({ bottom: 30 })

        Button("Restart Quiz")
          .width('60%')
          .height(50)
          .backgroundColor('#007DFF')
          .onClick(() => {
            this.currentIndex = 0
            this.score = 0
            this.isFinished = false
          })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  handleOptionSelect(selectedIndex: number) {
    if (selectedIndex === this.questions[this.currentIndex].answer) {
      this.score++
    }
    if (this.currentIndex < this.questions.length - 1) {
      this.currentIndex++
    } else {
      this.isFinished = true
    }
  }
}