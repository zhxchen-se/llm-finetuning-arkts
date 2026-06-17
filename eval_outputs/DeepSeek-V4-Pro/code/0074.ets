import { SliderChangeMode } from '@kit.ArkUI';

interface Song {
  title: string;
  artist: string;
  duration: number; // seconds
}

@Entry
@Component
struct Index {
  private songs: Song[] = [
    { title: 'Song One', artist: 'Artist A', duration: 210 },
    { title: 'Song Two', artist: 'Artist B', duration: 180 },
    { title: 'Song Three', artist: 'Artist C', duration: 240 }
  ];

  @State currentIndex: number = 0;
  @State isPlaying: boolean = false;
  @State currentTime: number = 0;
  @State duration: number = 0;
  @State sliderValue: number = 0;
  @State isSeeking: boolean = false;

  private timerId: number = -1;

  aboutToAppear(): void {
    this.duration = this.songs[this.currentIndex].duration;
    this.currentTime = 0;
    this.sliderValue = 0;
  }

  aboutToDisappear(): void {
    this.stopTimer();
  }

  formatTime(seconds: number): string {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
  }

  startTimer(): void {
    this.stopTimer();
    this.timerId = setInterval(() => {
      if (!this.isSeeking && this.isPlaying) {
        if (this.currentTime < this.duration) {
          this.currentTime++;
          this.sliderValue = this.currentTime;
        } else {
          // Song ended, play next
          this.nextTrack();
        }
      }
    }, 1000);
  }

  stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  togglePlayPause(): void {
    if (this.isPlaying) {
      this.stopTimer();
      this.isPlaying = false;
    } else {
      this.isPlaying = true;
      this.startTimer();
    }
  }

  nextTrack(): void {
    this.stopTimer();
    let nextIndex = this.currentIndex + 1;
    if (nextIndex >= this.songs.length) {
      nextIndex = 0; // loop back to first
    }
    this.currentIndex = nextIndex;
    this.currentTime = 0;
    this.sliderValue = 0;
    this.duration = this.songs[this.currentIndex].duration;
    this.isPlaying = true;
    this.startTimer();
  }

  prevTrack(): void {
    this.stopTimer();
    let prevIndex = this.currentIndex - 1;
    if (prevIndex < 0) {
      prevIndex = this.songs.length - 1;
    }
    this.currentIndex = prevIndex;
    this.currentTime = 0;
    this.sliderValue = 0;
    this.duration = this.songs[this.currentIndex].duration;
    this.isPlaying = true;
    this.startTimer();
  }

  onSliderChange(value: number, mode: SliderChangeMode): void {
    if (mode === SliderChangeMode.Begin || mode === SliderChangeMode.Moving) {
      this.isSeeking = true;
      this.sliderValue = value;
    } else if (mode === SliderChangeMode.End) {
      this.isSeeking = false;
      this.currentTime = value;
      this.sliderValue = value;
    }
  }

  build() {
    Column() {
      // Title
      Text('Now Playing')
        .fontSize(20)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Bold)
        .margin({ top: 30, bottom: 20 })
        .width('100%')
        .textAlign(TextAlign.Center)

      // Album art placeholder
      Stack() {
        Column() {
          Text('🎵')
            .fontSize(60)
            .fontColor('#FFFFFF')
        }
        .width(200)
        .height(200)
        .borderRadius(100)
        .backgroundColor('#333333')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .margin({ bottom: 30 })

      // Song info
      Text(this.songs[this.currentIndex].title)
        .fontSize(24)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 8 })

      Text(this.songs[this.currentIndex].artist)
        .fontSize(18)
        .fontColor('#BBBBBB')
        .margin({ bottom: 30 })

      // Progress bar
      Row() {
        Text(this.formatTime(this.currentTime))
          .fontSize(14)
          .fontColor('#AAAAAA')
          .width(50)
          .textAlign(TextAlign.Center)

        Slider({
          value: this.sliderValue,
          min: 0,
          max: this.duration,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor('#FFFFFF')
          .trackColor('#555555')
          .selectedColor('#1DB954')
          .trackThickness(4)
          .layoutWeight(1)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.onSliderChange(value, mode);
          })

        Text(this.formatTime(this.duration))
          .fontSize(14)
          .fontColor('#AAAAAA')
          .width(50)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .margin({ bottom: 40 })

      // Control buttons
      Row() {
        Button() {
          Text('⏮')
            .fontSize(30)
            .fontColor('#FFFFFF')
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor('#333333')
        .onClick(() => this.prevTrack())

        Button() {
          Text(this.isPlaying ? '⏸' : '▶')
            .fontSize(30)
            .fontColor('#FFFFFF')
        }
        .width(70)
        .height(70)
        .borderRadius(35)
        .backgroundColor('#1DB954')
        .margin({ left: 30, right: 30 })
        .onClick(() => this.togglePlayPause())

        Button() {
          Text('⏭')
            .fontSize(30)
            .fontColor('#FFFFFF')
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor('#333333')
        .onClick(() => this.nextTrack())
      }
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#1a1a1a')
    .padding({ top: 20 })
  }
}