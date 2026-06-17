import { promptAction } from '@kit.ArkUI';

interface Song {
  title: string;
  artist: string;
  duration: number;
  color: string;
}

@Entry
@Component
struct Index {
  @State songList: Song[] = [
    { title: 'Harmony Dreams', artist: 'Ark Orchestra', duration: 185, color: '#369' },
    { title: 'TS Nights', artist: 'Code Beats', duration: 210, color: '#936' },
    { title: 'UI Flow', artist: 'Design Synth', duration: 195, color: '#693' },
    { title: 'State Manage', artist: 'Reactive Band', duration: 240, color: '#396' }
  ];

  @State currentSongIndex: number = 0;
  @State isPlaying: boolean = false;
  @State progress: number = 0;
  @State currentTime: string = '00:00';
  @State totalTime: string = '00:00';

  private timer: number = -1;

  aboutToAppear() {
    this.updateTotalTime();
    this.startTimer();
  }

  aboutToDisappear() {
    if (this.timer !== -1) {
      clearInterval(this.timer);
      this.timer = -1;
    }
  }

  startTimer() {
    if (this.timer !== -1) {
      clearInterval(this.timer);
    }
    this.timer = setInterval(() => {
      if (this.isPlaying) {
        if (this.progress < this.songList[this.currentSongIndex].duration) {
          this.progress++;
          this.updateCurrentTime();
        } else {
          this.nextSong();
        }
      }
    }, 1000);
  }

  updateTotalTime() {
    this.totalTime = this.formatTime(this.songList[this.currentSongIndex].duration);
  }

  updateCurrentTime() {
    this.currentTime = this.formatTime(this.progress);
  }

  formatTime(seconds: number): string {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins < 10 ? '0' : ''}${mins}:${secs < 10 ? '0' : ''}${secs}`;
  }

  togglePlay() {
    this.isPlaying = !this.isPlaying;
    if (this.isPlaying) {
      this.startTimer();
    }
  }

  nextSong() {
    this.progress = 0;
    this.currentSongIndex = (this.currentSongIndex + 1) % this.songList.length;
    this.updateTotalTime();
    this.updateCurrentTime();
    if (!this.isPlaying) {
      this.isPlaying = true;
      this.startTimer();
    }
  }

  prevSong() {
    this.progress = 0;
    this.currentSongIndex = (this.currentSongIndex - 1 + this.songList.length) % this.songList.length;
    this.updateTotalTime();
    this.updateCurrentTime();
    if (!this.isPlaying) {
      this.isPlaying = true;
      this.startTimer();
    }
  }

  onProgressChange(value: number) {
    this.progress = Math.floor(value);
    this.updateCurrentTime();
  }

  build() {
    Column() {
      // Album Art
      Box() {
        Text('🎵')
          .fontSize(60)
          .fontColor('#FFFFFF')
      }
      .width(240)
      .height(240)
      .borderRadius(120)
      .backgroundColor(this.songList[this.currentSongIndex].color)
      .margin({ top: 40, bottom: 30 })
      .shadow({ radius: 20, color: '#1A000000', offsetX: 0, offsetY: 10 })

      // Song Info
      Column() {
        Text(this.songList[this.currentSongIndex].title)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .margin({ bottom: 8 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.songList[this.currentSongIndex].artist)
          .fontSize(16)
          .fontColor('#CCCCCC')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: 30 })

      // Progress Bar
      Column() {
        Slider({ value: this.progress, min: 0, max: this.songList[this.currentSongIndex].duration })
          .width('90%')
          .height(6)
          .onChange((value: number) => {
            this.onProgressChange(value);
          })
          .blockColor('#FFFFFF')
          .trackColor({ background: '#444444', selected: '#FFFFFF' })

        Row() {
          Text(this.currentTime)
            .fontSize(12)
            .fontColor('#AAAAAA')
            .width(50)
            .textAlign(TextAlign.Start)

          Text(this.totalTime)
            .fontSize(12)
            .fontColor('#AAAAAA')
            .width(50)
            .textAlign(TextAlign.End)
        }
        .width('90%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 10 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: 40 })

      // Controls
      Row() {
        Text('⏮')
          .fontSize(32)
          .fontColor('#FFFFFF')
          .padding(15)
          .onClick(() => {
            this.prevSong();
          })

        Text(this.isPlaying ? '⏸' : '▶')
          .fontSize(48)
          .fontColor('#FFFFFF')
          .padding(15)
          .onClick(() => {
            this.togglePlay();
          })

        Text('⏭')
          .fontSize(32)
          .fontColor('#FFFFFF')
          .padding(15)
          .onClick(() => {
            this.nextSong();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#121212')
    .justifyContent(FlexAlign.Start)
  }
}