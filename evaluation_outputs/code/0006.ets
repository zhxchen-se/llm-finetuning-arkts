import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State currentQuestionIndex: number = 0;
  @State score: number = 0;
  @State quizCompleted: boolean = false;
  @State selectedAnswer: number = -1; // track selected option for feedback (optional)

  // Quiz data
  private questions: Array<{
    question: string;
    options: Array<string>;
    correct: number;
  }> = [
    {
      question: 'What is the capital of France?',
      options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correct: 2
    },
    {
      question: 'Which planet is known as the Red Planet?',
      options: ['Earth', 'Mars', 'Jupiter', 'Venus'],
      correct: 1
    },
    {
      question: 'What is 2 + 2?',
      options: ['3', '4', '5', '6'],
      correct: 1
    }
  ];

  // Handle option selection
  handleAnswer(selectedIndex: number) {
    if (this.quizCompleted) return;

    this.selectedAnswer = selectedIndex;
    const currentQ = this.questions[this.currentQuestionIndex];
    if (selectedIndex === currentQ.correct) {
      this.score++;
    }

    // Move to next question or finish
    if (this.currentQuestionIndex < this.questions.length - 1) {
      // Delay to show feedback? For simplicity, immediate transition.
      this.currentQuestionIndex++;
      this.selectedAnswer = -1;
    } else {
      this.quizCompleted = true;
    }
  }

  // Restart quiz
  restartQuiz() {
    this.currentQuestionIndex = 0;
    this.score = 0;
    this.quizCompleted = false;
    this.selectedAnswer = -1;
  }

  build() {
    Column() {
      if (!this.quizCompleted) {
        // Question display
        Text(this.questions[this.currentQuestionIndex].question)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 20 })
          .textAlign(TextAlign.Center)

        // Options
        ForEach(this.questions[this.currentQuestionIndex].options, (option: string, index: number) => {
          Button(option)
            .width('80%')
            .height(50)
            .fontSize(18)
            .margin({ bottom: 10 })
            .backgroundColor(this.selectedAnswer === index ? '#007AFF' : '#E0E0E0')
            .fontColor(this.selectedAnswer === index ? Color.White : Color.Black)
            .onClick(() => {
              this.handleAnswer(index);
            })
        }, (option: string, index: number) => index.toString())

        // Progress indicator
        Text(`Question ${this.currentQuestionIndex + 1} of ${this.questions.length}`)
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ top: 20 })
      } else {
        // Quiz completed: show score
        Column() {
          Text('Quiz Completed!')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 20 })

          Text(`Your Score: ${this.score} / ${this.questions.length}`)
            .fontSize(24)
            .margin({ bottom: 30 })

          Button('Restart Quiz')
            .width('60%')
            .height(50)
            .fontSize(20)
            .backgroundColor('#007AFF')
            .fontColor(Color.White)
            .onClick(() => {
              this.restartQuiz();
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F5F5')
  }
}