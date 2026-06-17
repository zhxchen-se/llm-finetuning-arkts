interface Song {
  title: string;
  artist: string;
  duration: number;
}

@Entry
@Component
struct Index {
  @State isPlaying: boolean = false;
  @State currentTrackIndex: number = 0;
  @State currentTime: number = 0;
  private timer: number = -1;

  private songs: Song[] = [
    { title: "Harmony Breeze", artist: "Ark Orchestra", duration: 213 },
    { title: "Midnight Code", artist: "Dev Beats", duration: 185 },
    { title: "Sunset Widget", artist: "UI Waves", duration: 240 },
    { title: "Digital Horizon", artist: "Pixel Sound", duration: 198 }
  ];

  aboutToDisappear() {
    this.stopTimer();
  }

  formatTime(seconds: number): string {
    const min = Math.floor(seconds / 60);
    const sec = Math.floor(seconds % 60);
    return `${min}:${sec < 10 ? '0' + sec : sec}`;
  }

  startTimer() {
    this.stopTimer();
    this.timer = setInterval(() => {
      if (this.currentTime >= this.songs[this.currentTrackIndex].duration) {
        this.nextTrack();
      } else {
        this.currentTime++;
      }
    }, 1000);
  }

  stopTimer() {
    if (this.timer !== -1) {
      clearInterval(this.timer);
      this.timer = -1;
    }
  }

  togglePlay() {
    this.isPlaying = !this.isPlaying;
    if (this.isPlaying) {
      this.startTimer();
    } else {
      this.stopTimer();
    }
  }

  nextTrack() {
    this.stopTimer();
    this.currentTrackIndex = (this.currentTrackIndex + 1) % this.songs.length;
    this.currentTime = 0;
    if (this.isPlaying) {
      this.startTimer();
    }
  }

  prevTrack() {
    this.stopTimer();
    if (this.currentTime > 3) {
      this.currentTime = 0;
    } else {
      this.currentTrackIndex = (this.currentTrackIndex - 1 + this.songs.length) % this.songs.length;
      this.currentTime = 0;
    }
    if (this.isPlaying) {
      this.startTimer();
    }
  }

  build() {
    Column() {
      // Header
      Text('Music Player')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40, bottom: 20 })
        .fontColor('#333333')

      // Album Art Placeholder
      Column() {
        Text('♪')
          .fontSize(80)
          .fontColor('#FFFFFF')
      }
      .width(240)
      .height(240)
      .borderRadius(20)
      .backgroundColor('#FF6B6B')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .shadow({ radius: 20, color: '#FF6B6B', offsetY: 10 })
      .margin({ bottom: 30 })

      // Song Info
      Text(this.songs[this.currentTrackIndex].title)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ bottom: 8 })

      Text(this.songs[this.currentTrackIndex].artist)
        .fontSize(16)
        .fontColor('#888888')
        .margin({ bottom: 30 })

      // Progress Bar
      Column() {
        Slider({
          value: this.currentTime,
          min: 0,
          max: this.songs[this.currentTrackIndex].duration,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor('#FF6B6B')
          .trackColor('#DDDDDD')
          .selectedColor('#FF6B6B')
          .showSteps(false)
          .trackThickness(4)
          .blockThickness(16)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.currentTime = value;
          })

        Row() {
          Text(this.formatTime(this.currentTime))
            .fontSize(12)
            .fontColor('#999999')
          
          Blank()
          
          Text(this.formatTime(this.songs[this.currentTrackIndex].duration))
            .fontSize(12)
            .fontColor('#999999')
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .width('85%')
      .margin({ bottom: 40 })

      // Controls
      Row() {
        // Previous Button
        Button() {
          Text('⏮')
            .fontSize(28)
            .fontColor('#333333')
        }
        .width(60)
        .height(60)
        .backgroundColor('#EEEEEE')
        .borderRadius(30)
        .type(ButtonType.Circle)
        .onClick(() => this.prevTrack())

        // Play/Pause Button
        Button() {
          Text(this.isPlaying ? '⏸' : '▶')
            .fontSize(36)
            .fontColor('#FFFFFF')
            .margin({ left: this.isPlaying ? 0 : 4 })
        }
        .width(80)
        .height(80)
        .backgroundColor('#FF6B6B')
        .borderRadius(40)
        .type(ButtonType.Circle)
        .margin({ left: 30, right: 30 })
        .onClick(() => this.togglePlay())

        // Next Button
        Button() {
          Text('⏭')
            .fontSize(28)
            .fontColor('#333333')
        }
        .width(60)
        .height(60)
        .backgroundColor('#EEEEEE')
        .borderRadius(30)
        .type(ButtonType.Circle)
        .onClick(() => this.nextTrack())
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 40 })

      // Track List Preview
      Column() {
        ForEach(this.songs, (song: Song, index: number) => {
          Row() {
            Text(song.title)
              .fontSize(16)
              .fontColor(index === this.currentTrackIndex ? '#FF6B6B' : '#333333')
              .fontWeight(index === this.currentTrackIndex ? FontWeight.Bold : FontWeight.Normal)
            
            Blank()
            
            Text(song.artist)
              .fontSize(14)
              .fontColor(index === this.currentTrackIndex ? '#FF6B6B' : '#888888')
          }
          .width('100%')
          .height(50)
          .padding({ left: 20, right: 20 })
          .borderRadius(10)
          .backgroundColor(index === this.currentTrackIndex ? '#FFF0F0' : '#FFFFFF')
          .margin({ bottom: 8 })
          .onClick(() => {
            this.stopTimer();
            this.currentTrackIndex = index;
            this.currentTime = 0;
            if (this.isPlaying) {
              this.startTimer();
            }
          })
        }, (song: Song, index: number) => index.toString())
      }
      .width('85%')
      
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .alignItems(HorizontalAlign.Center)
  }
}