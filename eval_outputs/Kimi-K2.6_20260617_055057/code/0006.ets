import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State currentQuestionIndex: number = 0
  @State selectedOptionIndex: number = -1
  @State userAnswers: number[] = [-1, -1, -1]
  @State score: number = 0
  @State showResult: boolean = false
  @State isAnswered: boolean = false
  @State showFeedback: boolean = false
  @State isCorrect: boolean = false

  private questions: Array<{
    question: string,
    options: string[],
    correctAnswer: number
  }> = [
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

  private getOptionLetter(index: number): string {
    return String.fromCharCode(65 + index)
  }

  private getOptionColor(index: number): ResourceColor {
    if (!this.showFeedback) {
      if (this.selectedOptionIndex === index) {
        return '#6366F1'
      }
      return '#FFFFFF'
    }

    if (index === this.questions[this.currentQuestionIndex].correctAnswer) {
      return '#10B981'
    }

    if (this.selectedOptionIndex === index && index !== this.questions[this.currentQuestionIndex].correctAnswer) {
      return '#EF4444'
    }

    return '#FFFFFF'
  }

  private getOptionTextColor(index: number): ResourceColor {
    if (!this.showFeedback) {
      if (this.selectedOptionIndex === index) {
        return '#FFFFFF'
      }
      return '#1F2937'
    }

    if (index === this.questions[this.currentQuestionIndex].correctAnswer) {
      return '#FFFFFF'
    }

    if (this.selectedOptionIndex === index && index !== this.questions[this.currentQuestionIndex].correctAnswer) {
      return '#FFFFFF'
    }

    return '#1F2937'
  }

  private getOptionBorderColor(index: number): ResourceColor {
    if (!this.showFeedback) {
      if (this.selectedOptionIndex === index) {
        return '#6366F1'
      }
      return '#E5E7EB'
    }

    if (index === this.questions[this.currentQuestionIndex].correctAnswer) {
      return '#10B981'
    }

    if (this.selectedOptionIndex === index && index !== this.questions[this.currentQuestionIndex].correctAnswer) {
      return '#EF4444'
    }

    return '#E5E7EB'
  }

  private selectOption(index: number) {
    if (this.showFeedback) {
      return
    }
    this.selectedOptionIndex = index
    this.isAnswered = true
  }

  private submitAnswer() {
    if (this.selectedOptionIndex === -1) {
      return
    }

    const currentQuestion = this.questions[this.currentQuestionIndex]
    this.isCorrect = this.selectedOptionIndex === currentQuestion.correctAnswer
    this.userAnswers[this.currentQuestionIndex] = this.selectedOptionIndex

    if (this.isCorrect) {
      this.score++
    }

    this.showFeedback = true
  }

  private nextQuestion() {
    if (this.currentQuestionIndex < this.questions.length - 1) {
      this.currentQuestionIndex++
      this.selectedOptionIndex = -1
      this.isAnswered = false
      this.showFeedback = false
      this.isCorrect = false
    } else {
      this.showResult = true
    }
  }

  private restartQuiz() {
    this.currentQuestionIndex = 0
    this.selectedOptionIndex = -1
    this.userAnswers = [-1, -1, -1]
    this.score = 0
    this.showResult = false
    this.isAnswered = false
    this.showFeedback = false
    this.isCorrect = false
  }

  @Builder
  QuizView() {
    Column() {
      // Header
      Row() {
        Text('Quiz App')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F2937')

        Blank()

        Text(`${this.currentQuestionIndex + 1}/${this.questions.length}`)
          .fontSize(16)
          .fontColor('#6B7280')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#F3F4F6')
          .borderRadius(20)
      }
      .width('100%')
      .padding(20)

      // Progress Bar
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(6)
          .backgroundColor('#E5E7EB')
          .borderRadius(3)

        Row()
          .width(`${((this.currentQuestionIndex + 1) / this.questions.length) * 100}%`)
          .height(6)
          .backgroundColor('#6366F1')
          .borderRadius(3)
          .animation({
            duration: 300,
            curve: Curve.EaseInOut
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })

      // Question Card
      Column() {
        Text(`Question ${this.currentQuestionIndex + 1}`)
          .fontSize(14)
          .fontColor('#6366F1')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 12 })

        Text(this.questions[this.currentQuestionIndex].question)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F2937')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.06)',
        offsetY: 4
      })
      .margin({ top: 20, left: 20, right: 20 })

      // Options
      List() {
        ForEach(this.questions[this.currentQuestionIndex].options, (option: string, index: number) => {
          ListItem() {
            Row() {
              Text(this.getOptionLetter(index))
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getOptionTextColor(index))
                .width(36)
                .height(36)
                .textAlign(TextAlign.Center)
                .backgroundColor(this.showFeedback && index === this.questions[this.currentQuestionIndex].correctAnswer ? 'rgba(255,255,255,0.3)' : (this.selectedOptionIndex === index && !this.showFeedback ? 'rgba(255,255,255,0.3)' : '#F3F4F6'))
                .borderRadius(10)

              Text(option)
                .fontSize(16)
                .fontColor(this.getOptionTextColor(index))
                .layoutWeight(1)
                .margin({ left: 12 })

              if (this.showFeedback && index === this.questions[this.currentQuestionIndex].correctAnswer) {
                Text('✓')
                  .fontSize(20)
                  .fontColor('#FFFFFF')
              } else if (this.showFeedback && this.selectedOptionIndex === index && !this.isCorrect) {
                Text('✗')
                  .fontSize(20)
                  .fontColor('#FFFFFF')
              }
            }
            .width('100%')
            .padding(16)
            .backgroundColor(this.getOptionColor(index))
            .borderRadius(12)
            .borderWidth(2)
            .borderColor(this.getOptionBorderColor(index))
          }
          .onClick(() => {
            this.selectOption(index)
          })
          .margin({ bottom: 12 })
        })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .margin({ top: 16 })

      // Feedback Message
      if (this.showFeedback) {
        Column() {
          Text(this.isCorrect ? 'Correct! 🎉' : 'Incorrect')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isCorrect ? '#10B981' : '#EF4444')

          if (!this.isCorrect) {
            Text(`The correct answer is: ${this.questions[this.currentQuestionIndex].options[this.questions[this.currentQuestionIndex].correctAnswer]}`)
              .fontSize(14)
              .fontColor('#6B7280')
              .margin({ top: 4 })
          }
        }
        .width('100%')
        .padding(16)
        .backgroundColor(this.isCorrect ? '#ECFDF5' : '#FEF2F2')
        .borderRadius(12)
        .margin({ left: 20, right: 20, bottom: 12 })
      }

      // Action Button
      Button(this.showFeedback ? (this.currentQuestionIndex < this.questions.length - 1 ? 'Next Question' : 'See Results') : 'Submit Answer')
        .width('100%')
        .height(52)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor(this.isAnswered ? '#6366F1' : '#9CA3AF')
        .borderRadius(12)
        .margin({ left: 20, right: 20, bottom: 24 })
        .enabled(this.isAnswered)
        .onClick(() => {
          if (this.showFeedback) {
            this.nextQuestion()
          } else {
            this.submitAnswer()
          }
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }

  @Builder
  ResultView() {
    Column() {
      // Header
      Text('Quiz Complete!')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .margin({ top: 40 })

      // Score Circle
      Stack() {
        Column() {
          Text(`${this.score}`)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#6366F1')

          Text(`out of ${this.questions.length}`)
            .fontSize(16)
            .fontColor('#6B7280')
        }
      }
      .width(160)
      .height(160)
      .backgroundColor('#EEF2FF')
      .borderRadius(80)
      .margin({ top: 32 })

      // Score Message
      Text(this.score === this.questions.length ? 'Perfect Score! 🏆' :
        this.score >= this.questions.length / 2 ? 'Good Job! 👍' : 'Keep Practicing! 💪')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.score === this.questions.length ? '#10B981' :
          this.score >= this.questions.length / 2 ? '#6366F1' : '#F59E0B')
        .margin({ top: 24 })

      // Review Section
      Text('Review Answers')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ top: 32, bottom: 16 })
        .padding({ left: 20, right: 20 })

      List() {
        ForEach(this.questions, (question: {
          question: string,
          options: string[],
          correctAnswer: number
        }, index: number) => {
          ListItem() {
            Column() {
              Row() {
                Text(`Q${index + 1}`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#6366F1')
                  .width(32)
                  .height(32)
                  .textAlign(TextAlign.Center)
                  .backgroundColor('#EEF2FF')
                  .borderRadius(8)

                Text(question.question)
                  .fontSize(15)
                  .fontColor('#1F2937')
                  .layoutWeight(1)
                  .margin({ left: 12 })
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('100%')

              Column() {
                Text(`Correct: ${question.options[question.correctAnswer]}`)
                  .fontSize(14)
                  .fontColor('#10B981')
                  .fontWeight(FontWeight.Medium)

                if (this.userAnswers[index] !== question.correctAnswer) {
                  Text(`Your answer: ${this.userAnswers[index] !== -1 ? question.options[this.userAnswers[index]] : 'Not answered'}`)
                    .fontSize(14)
                    .fontColor('#EF4444')
                    .margin({ top: 4 })
                }
              }
              .width('100%')
              .margin({ top: 12 })
              .padding(12)
              .backgroundColor(this.userAnswers[index] === question.correctAnswer ? '#ECFDF5' : '#FEF2F2')
              .borderRadius(8)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({
              radius: 4,
              color: 'rgba(0, 0, 0, 0.04)',
              offsetY: 2
            })
          }
          .margin({ bottom: 12, left: 20, right: 20 })
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Restart Button
      Button('Restart Quiz')
        .width('100%')
        .height(52)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor('#6366F1')
        .borderRadius(12)
        .margin({ left: 20, right: 20, bottom: 24 })
        .onClick(() => {
          this.restartQuiz()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }

  build() {
    if (this.showResult) {
      this.ResultView()
    } else {
      this.QuizView()
    }
  }
}