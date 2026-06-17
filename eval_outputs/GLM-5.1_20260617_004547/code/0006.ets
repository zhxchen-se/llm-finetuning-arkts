import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State currentQuestionIndex: number = 0
  @State selectedOption: number = -1
  @State score: number = 0
  @State quizFinished: boolean = false
  @State showFeedback: boolean = false
  @State isCorrect: boolean = false
  @State answered: boolean = false

  private questions: Array<QuestionData> = [
    {
      question: 'What is the capital of France?',
      options: ['London', 'Berlin', 'Paris', 'Madrid'],
      correctAnswer: 2
    },
    {
      question: 'Which planet is known as the Red Planet?',
      options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      correctAnswer: 1
    },
    {
      question: 'What is the largest ocean on Earth?',
      options: ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
      correctAnswer: 3
    }
  ]

  build() {
    Column() {
      // Header
      Text('Quiz App')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ top: 50, bottom: 10 })

      Text(`Question ${this.currentQuestionIndex + 1} of ${this.questions.length}`)
        .fontSize(16)
        .fontColor('#BBBBBB')
        .margin({ bottom: 30 })

      if (!this.quizFinished) {
        // Progress Bar
        Row() {
          ForEach(this.questions, (_: QuestionData, index?: number) => {
            Row()
              .width(0)
              .flexGrow(1)
              .height(6)
              .borderRadius(3)
              .backgroundColor(
                index! < this.currentQuestionIndex ? '#4CAF50' :
                index! === this.currentQuestionIndex ? '#2196F3' : '#444444'
              )
              .margin({ left: 4, right: 4 })
          }, (item: QuestionData, index?: number) => index!.toString())
        }
        .width('85%')
        .margin({ bottom: 30 })

        // Score Display
        Row() {
          Text(`Score: ${this.score}`)
            .fontSize(18)
            .fontColor('#FFD700')
            .fontWeight(FontWeight.Bold)
        }
        .width('85%')
        .margin({ bottom: 20 })

        // Question Card
        Column() {
          Text(this.questions[this.currentQuestionIndex].question)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 30 })

          // Options
          ForEach(this.questions[this.currentQuestionIndex].options, (option: string, index?: number) => {
            Row() {
              Text(`${String.fromCharCode(65 + index!)}.  ${option}`)
                .fontSize(18)
                .fontColor(
                  this.selectedOption === index ?
                    (this.isCorrect ? '#4CAF50' : '#F44336') :
                    '#FFFFFF'
                )
                .fontWeight(this.selectedOption === index ? FontWeight.Bold : FontWeight.Normal)
            }
            .width('100%')
            .padding({ left: 20, right: 20, top: 16, bottom: 16 })
            .borderRadius(12)
            .backgroundColor(
              this.selectedOption === index ?
                (this.isCorrect ? 'rgba(76,175,80,0.2)' : 'rgba(244,67,54,0.2)') :
                '#2A2A2A'
            )
            .border({
              width: this.selectedOption === index ? 2 : 1,
              color: this.selectedOption === index ?
                (this.isCorrect ? '#4CAF50' : '#F44336') :
                '#444444',
              style: BorderStyle.Solid,
              radius: 12
            })
            .margin({ bottom: 12 })
            .onClick(() => {
              if (!this.answered) {
                this.handleOptionSelect(index!)
              }
            })
          }, (option: string, index?: number) => index!.toString())
        }
        .width('85%')
        .padding(24)
        .borderRadius(20)
        .backgroundColor('#1E1E1E')
        .alignItems(HorizontalAlign.Center)

        // Feedback Text
        if (this.showFeedback) {
          Text(this.isCorrect ? '✓ Correct!' : '✗ Wrong!')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isCorrect ? '#4CAF50' : '#F44336')
            .margin({ top: 20 })
        }

        // Next Button
        if (this.answered) {
          Button(this.currentQuestionIndex < this.questions.length - 1 ? 'Next Question' : 'See Results')
            .width('85%')
            .height(56)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor('#2196F3')
            .borderRadius(16)
            .margin({ top: 20 })
            .onClick(() => {
              if (this.currentQuestionIndex < this.questions.length - 1) {
                this.currentQuestionIndex++
                this.selectedOption = -1
                this.showFeedback = false
                this.isCorrect = false
                this.answered = false
              } else {
                this.quizFinished = true
              }
            })
        }
      } else {
        // Results Screen
        Column() {
          Text('🎉')
            .fontSize(64)
            .margin({ bottom: 20 })

          Text('Quiz Complete!')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ bottom: 20 })

          Text(`Your Score`)
            .fontSize(18)
            .fontColor('#BBBBBB')
            .margin({ bottom: 8 })

          Text(`${this.score} / ${this.questions.length}`)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFD700')
            .margin({ bottom: 10 })

          // Score message
          Text(this.getScoreMessage())
            .fontSize(18)
            .fontColor('#BBBBBB')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 30 })

          // Score Bar
          Row() {
            Row()
              .width(`${(this.score / this.questions.length) * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor('#4CAF50')
          }
          .width('80%')
          .height(8)
          .borderRadius(4)
          .backgroundColor('#444444')
          .margin({ bottom: 40 })

          // Review Answers
          ForEach(this.questions, (question: QuestionData, index?: number) => {
            Row() {
              Column() {
                Text(`Q${index! + 1}: ${question.question}`)
                  .fontSize(14)
                  .fontColor('#FFFFFF')
                  .margin({ bottom: 4 })
                Text(`Answer: ${question.options[question.correctAnswer]}`)
                  .fontSize(13)
                  .fontColor('#4CAF50')
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('85%')
            .padding(16)
            .borderRadius(12)
            .backgroundColor('#1E1E1E')
            .margin({ bottom: 8 })
          }, (question: QuestionData, index?: number) => index!.toString())

          // Restart Button
          Button('Restart Quiz')
            .width('85%')
            .height(56)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor('#2196F3')
            .borderRadius(16)
            .margin({ top: 20, bottom: 30 })
            .onClick(() => {
              this.currentQuestionIndex = 0
              this.selectedOption = -1
              this.score = 0
              this.quizFinished = false
              this.showFeedback = false
              this.isCorrect = false
              this.answered = false
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#121212')
    .alignItems(HorizontalAlign.Center)
  }

  private handleOptionSelect(index: number): void {
    this.selectedOption = index
    this.answered = true
    this.showFeedback = true
    this.isCorrect = index === this.questions[this.currentQuestionIndex].correctAnswer
    if (this.isCorrect) {
      this.score++
    }
  }

  private getScoreMessage(): string {
    const percentage = this.score / this.questions.length
    if (percentage === 1) {
      return 'Perfect! You got every question right!'
    } else if (percentage >= 0.66) {
      return 'Great job! You know your stuff!'
    } else if (percentage >= 0.33) {
      return 'Not bad, but there\'s room for improvement!'
    } else {
      return 'Keep learning! You\'ll do better next time!'
    }
  }
}

interface QuestionData {
  question: string
  options: Array<string>
  correctAnswer: number
}