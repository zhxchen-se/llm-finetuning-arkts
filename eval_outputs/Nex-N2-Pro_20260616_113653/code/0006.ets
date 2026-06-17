import {
  Button,
  Column,
  FlexAlign,
  FontWeight,
  HorizontalAlign,
  Text,
  TextAlign
} from '@kit.ArkUI';

interface QuizQuestion {
  question: string;
  options: string[];
  correctIndex: number;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State score: number = 0;
  @State selectedOption: number = -1;
  @State showResult: boolean = false;

  questions: QuizQuestion[] = [
    {
      question: 'What is the capital of France?',
      options: ['London', 'Paris', 'Berlin', 'Madrid'],
      correctIndex: 1
    },
    {
      question: 'Which planet is known as the Red Planet?',
      options: ['Earth', 'Venus', 'Mars', 'Jupiter'],
      correctIndex: 2
    },
    {
      question: 'What is 5 + 7?',
      options: ['10', '11', '12', '13'],
      correctIndex: 2
    }
  ];

  selectOption(optionIndex: number): void {
    const currentQuestion: QuizQuestion = this.questions[this.currentIndex];

    if (optionIndex === currentQuestion.correctIndex) {
      this.score += 1;
    }

    if (this.currentIndex === this.questions.length - 1) {
      this.showResult = true;
      this.selectedOption = -1;
    } else {
      this.currentIndex += 1;
      this.selectedOption = -1;
    }
  }

  restartQuiz(): void {
    this.currentIndex = 0;
    this.score = 0;
    this.selectedOption = -1;
    this.showResult = false;
  }

  build() {
    Column() {
      if (this.showResult) {
        Column() {
          Text('Quiz Completed!')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
            .margin({ bottom: 12 })

          Text(`Your score: ${this.score} out of ${this.questions.length}`)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2563EB')
            .margin({ bottom: 20 })

          Text('Correct Answers')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
            .width('100%')
            .margin({ bottom: 12 })

          ForEach(this.questions, (item: QuizQuestion, index: number) => {
            Column() {
              Text(`${index + 1}. ${item.question}`)
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0F172A')
                .width('100%')

              Text(`Answer: ${item.options[item.correctIndex]}`)
                .fontSize(14)
                .fontColor('#15803D')
                .width('100%')
                .margin({ top: 4 })
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#F0FDF4')
            .borderRadius(12)
            .margin({ bottom: 8 })
          }, (item: QuizQuestion, index: number) => index.toString())

          Button('Restart Quiz')
            .width('220')
            .height(52)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor('#2563EB')
            .borderRadius(14)
            .margin({ top: 24 })
            .onClick(() => {
              this.restartQuiz();
            })
        }
        .width('92%')
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
      } else {
        const currentQuestion: QuizQuestion = this.questions[this.currentIndex];

        Column() {
          Text('Quiz App')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
            .margin({ bottom: 32 })

          Column() {
            Text(`Question ${this.currentIndex + 1} of ${this.questions.length}`)
              .fontSize(16)
              .fontColor('#64748B')
              .margin({ bottom: 8 })

            Text(currentQuestion.question)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
              .fontColor('#0F172A')
              .margin({ bottom: 24 })

            ForEach(currentQuestion.options, (option: string, index: number) => {
              Button(option)
                .width('100%')
                .height(56)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.selectedOption === index ? '#FFFFFF' : '#1F2937')
                .backgroundColor(this.selectedOption === index ? '#2563EB' : '#FFFFFF')
                .borderRadius(14)
                .border({
                  width: 1,
                  color: this.selectedOption === index ? '#2563EB' : '#CBD5E1'
                })
                .margin({ bottom: 12 })
                .onClick(() => {
                  this.selectOption(index);
                })
            }, (option: string, index: number) => index.toString())

            Text('Select an option to continue')
              .fontSize(14)
              .fontColor('#94A3B8')
              .margin({ top: 16 })
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
        }
        .width('92%')
      }
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#F8FAFC')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}