import {
  Button,
  Column,
  Divider,
  FlexAlign,
  FontState,
  FontWeight,
  HorizontalAlign,
  InputType,
  Row,
  Scroll,
  Text,
  TextAlign,
  TextInput,
  VerticalAlign
} from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State heightCm: string = '';
  @State weightKg: string = '';
  @State bmiText: string = '0.0';
  @State categoryText: string = '等待计算';
  @State categoryDesc: string = '请输入身高和体重，点击“计算 BMI”查看结果。';
  @State categoryColor: string = '#666666';
  @State hasResult: boolean = false;
  @State showError: boolean = false;
  @State errorText: string = '';

  private setError(message: string): void {
    this.showError = true;
    this.errorText = message;
    this.bmiText = '0.0';
    this.categoryText = '等待计算';
    this.categoryDesc = '请修正输入后重新计算。';
    this.categoryColor = '#666666';
    this.hasResult = false;
  }

  private clearResult(message: string): void {
    this.showError = false;
    this.errorText = '';
    this.bmiText = '0.0';
    this.categoryText = '等待计算';
    this.categoryDesc = message;
    this.categoryColor = '#666666';
    this.hasResult = false;
  }

  calculateBMI(): void {
    const heightText: string = this.heightCm.trim();
    const weightText: string = this.weightKg.trim();
    const numberPattern: RegExp = /^\d+(\.\d+)?$/;

    if (heightText === '' || weightText === '') {
      this.setError('请输入身高和体重后再计算。');
      return;
    }

    if (!numberPattern.test(heightText) || !numberPattern.test(weightText)) {
      this.setError('请输入有效的数字。');
      return;
    }

    const heightValue: number = Number(heightText);
    const weightValue: number = Number(weightText);

    if (heightValue < 50 || heightValue > 250) {
      this.setError('身高范围建议在 50 - 250 cm 之间。');
      return;
    }

    if (weightValue < 2 || weightValue > 300) {
      this.setError('体重范围建议在 2 - 300 kg 之间。');
      return;
    }

    const heightM: number = heightValue / 100;
    const bmi: number = weightValue / Math.pow(heightM, 2);

    this.bmiText = bmi.toFixed(1);
    this.hasResult = true;
    this.showError = false;
    this.errorText = '';

    if (bmi < 18.5) {
      this.categoryText = '偏瘦';
      this.categoryDesc = '体重略低，建议关注营养摄入和规律运动。';
      this.categoryColor = '#3B82F6';
    } else if (bmi < 24) {
      this.categoryText = '正常';
      this.categoryDesc = '体重处于正常范围，请继续保持均衡饮食和规律运动。';
      this.categoryColor = '#10B981';
    } else if (bmi < 28) {
      this.categoryText = '超重';
      this.categoryDesc = '体重略高，建议适当控制饮食并增加运动。';
      this.categoryColor = '#F59E0B';
    } else {
      this.categoryText = '肥胖';
      this.categoryDesc = '体重偏高，建议关注健康风险，必要时咨询医生。';
      this.categoryColor = '#EF4444';
    }
  }

  resetBMI(): void {
    this.heightCm = '';
    this.weightKg = '';
    this.clearResult('请输入身高和体重，点击“计算 BMI”查看结果。');
  }

  @Builder
  InputCard() {
    Column() {
      Row() {
        Text('身体数据')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827');

        Text('必填')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(10)
          .backgroundColor('#3B82F6');
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      Row() {
        Column() {
          Text('身高')
            .fontSize(14)
            .fontColor('#374151')
            .fontWeight(FontWeight.Medium);
        }
        .width(70);

        TextInput({ text: this.heightCm, placeholder: '例如：170', type: InputType.Number })
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#F6F7FB')
          .borderRadius(12)
          .padding({ left: 14, right: 14 })
          .placeholderColor('#AAB2C0')
          .onChange((value: string): void => {
            this.heightCm = value;
            this.clearResult('数据已修改，请重新计算。');
          });

        Text('cm')
          .fontSize(14)
          .fontColor('#6B7280')
          .margin({ left: 8 });
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ top: 16, bottom: 12 });

      Row() {
        Column() {
          Text('体重')
            .fontSize(14)
            .fontColor('#374151')
            .fontWeight(FontWeight.Medium);
        }
        .width(70);

        TextInput({ text: this.weightKg, placeholder: '例如：65', type: InputType.Number })
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#F6F7FB')
          .borderRadius(12)
          .padding({ left: 14, right: 14 })
          .placeholderColor('#AAB2C0')
          .onChange((value: string): void => {
            this.weightKg = value;
            this.clearResult('数据已修改，请重新计算。');
          });

        Text('kg')
          .fontSize(14)
          .fontColor('#6B7280')
          .margin({ left: 8 });
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ top: 12, bottom: 4 });

      if (this.showError) {
        Text(this.errorText)
          .fontSize(14)
          .fontColor('#EF4444')
          .width('100%')
          .margin({ top: 8 });
      }

      Row() {
        Button('计算 BMI')
          .width('48%')
          .height(48)
          .backgroundColor('#3B82F6')
          .borderRadius(14)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.calculateBMI();
          });

        Button('清空')
          .width('48%')
          .height(48)
          .backgroundColor('#FFFFFF')
          .borderRadius(14)
          .fontColor('#3B82F6')
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.resetBMI();
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 16 });
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 12, color: 'rgba(15, 23, 42, 0.06)', offsetX: 0, offsetY: 8 });
  }

  @Builder
  MeasureItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(12)
        .fontColor('#9CA3AF');

      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .margin({ top: 6 });
    }
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  ResultCard() {
    Column() {
      Row() {
        Text('BMI 结果')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827');

        if (this.hasResult) {
          Text(this.categoryText)
            .fontSize(13)
            .fontColor(this.categoryColor)
            .padding({ left: 10, right: 10, top: 5, bottom: 5 })
            .borderRadius(14)
            .backgroundColor('#F3F4F6');
        } else {
          Text('待计算')
            .fontSize(13)
            .fontColor('#9CA3AF')
            .padding({ left: 10, right: 10, top: 5, bottom: 5 })
            .borderRadius(14)
            .backgroundColor('#F3F4F6');
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      if (this.hasResult) {
        Text(this.bmiText)
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.categoryColor)
          .margin({ top: 20, bottom: 4 });

        Text('你的 BMI 指数为 ' + this.bmiText)
          .fontSize(14)
          .fontColor('#6B7280');
      } else {
        Text('暂无结果')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D1D5DB')
          .margin({ top: 20, bottom: 4 });

        Text('请输入身高和体重后开始计算')
          .fontSize(14)
          .fontColor('#9CA3AF');
      }

      if (this.hasResult) {
        Text(this.categoryDesc)
          .fontSize(14)
          .fontColor('#6B7280')
          .textAlign(TextAlign.Center)
          .margin({ top: 8 });

        Divider()
          .color('#EEEEEE')
          .margin({ top: 18, bottom: 18 });

        Row() {
          this.MeasureItem('身高', this.heightCm + ' cm');
          this.MeasureItem('体重', this.weightKg + ' kg');
          this.MeasureItem('BMI', this.bmiText);
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround);
      } else {
        Text('结果会根据中国成人 BMI 分类标准展示。')
          .fontSize(14)
          .fontColor('#9CA3AF')
          .textAlign(TextAlign.Center)
          .margin({ top: 8 });
      }
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 12, color: 'rgba(15, 23, 42, 0.06)', offsetX: 0, offsetY: 8 });
  }

  @Builder
  RangeItem(name: string, value: string) {
    Row() {
      Text(name)
        .fontSize(14)
        .fontColor('#374151');

      Text(value)
        .fontSize(14)
        .fontColor('#6B7280');
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ top: 10, bottom: 10 });
  }

  @Builder
  ReferenceCard() {
    Column() {
      Row() {
        Text('参考分类')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827');

        Text('中国成人')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(10)
          .backgroundColor('#10B981');
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      this.RangeItem('偏瘦', '< 18.5');
      Divider().color('#EEEEEE');
      this.RangeItem('正常', '18.5 - 23.9');
      Divider().color('#EEEEEE');
      this.RangeItem('超重', '24.0 - 27.9');
      Divider().color('#EEEEEE');
      this.RangeItem('肥胖', '≥ 28.0');

      Text('提示：BMI 仅用于成人初步筛查，不能替代医生诊断。')
        .fontSize(12)
        .fontColor('#9CA3AF')
        .margin({ top: 12 });
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 12, color: 'rgba(15, 23, 42, 0.06)', offsetX: 0, offsetY: 8 });
  }

  build() {
    Scroll() {
      Column() {
        Column() {
          Text('BMI 计算器')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827');

          Text('快速了解你的体重健康状况')
            .fontSize(15)
            .fontColor('#6B7280')
            .margin({ top: 8 });
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ top: 16, bottom: 24 });

        this.InputCard();

        this.ResultCard()
          .margin({ top: 16 });

        this.ReferenceCard()
          .margin({ top: 16 });

        Text('本工具仅供参考，如有健康疑问请咨询专业医生。')
          .fontSize(12)
          .fontColor('#9CA3AF')
          .textAlign(TextAlign.Center)
          .margin({ top: 18, bottom: 12 });
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({ left: 24, right: 24, top: 32, bottom: 32 });
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FA');
  }
}