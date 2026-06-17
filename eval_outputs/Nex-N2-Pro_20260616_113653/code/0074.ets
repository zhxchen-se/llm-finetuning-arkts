interface Song {
  title: string;
  artist: string;
  album: string;
  duration: number;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State isPlaying: boolean = false;
  @State currentProgress: number = 0;

  private timer: number = -1;

  private songs: Song[] = [
    {
      title: 'Midnight Drive',
      artist: 'Luna Wave',
      album: 'Neon Nights',
      duration: 214
    },
    {
      title: 'Golden Hour',
      artist: 'Skyline Kids',
      album: 'Summer Colors',
      duration: 186
    },
    {
      title: 'Ocean Breeze',
      artist: 'The Tides',
      album: 'Coastal Dreams',
      duration: 241
    },
    {
      title: 'City Lights',
      artist: 'Nova Pulse',
      album: 'After Dark',
      duration: 203
    }
  ];

  get currentSong(): Song {
    return this.songs[this.currentIndex];
  }

  aboutToDisappear(): void {
    this.stopTimer();
  }

  onPageShow(): void {
    if (this.isPlaying) {
      this.startTimer();
    }
  }

  onPageHide(): void {
    this.stopTimer();
  }

  build() {
    Column() {
      Text('Music Player')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .margin({ bottom: 28 })

      Column() {
        Text('♪')
          .fontSize(72)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width(190)
      .height(190)
      .borderRadius(40)
      .backgroundColor('#111827')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(this.currentSong.title)
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .width('85%')
          .maxLines(1)
          .ellipsis(true)

        Text(this.currentSong.artist)
          .fontSize(17)
          .fontColor('#4B5563')
          .margin({ top: 8 })

        Text(this.currentSong.album)
          .fontSize(14)
          .fontColor('#6B7280')
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 26, bottom: 24 })

      Column() {
        Text(`${this.formatTime(this.currentProgress)} / ${this.formatTime(this.currentSong.duration)}`)
          .width('90%')
          .fontSize(13)
          .fontColor('#6B7280')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })

        Progress({
          value: this.currentProgress,
          total: this.currentSong.duration,
          type: ProgressType.Linear
        })
        .width('90%')
        .height(8)
        .color('#2563EB')
        .backgroundColor('#E5E7EB')

        Text(this.isPlaying ? 'Playing' : 'Paused')
          .fontSize(14)
          .fontColor(this.isPlaying ? '#16A34A' : '#6B7280')
          .fontWeight(FontWeight.Medium)
          .margin({ top: 12 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Row() {
        Button() {
          Text('⏮')
            .fontSize(24)
            .fontColor('#FFFFFF')
        }
        .width(58)
        .height(58)
        .borderRadius(29)
        .backgroundColor('#2563EB')
        .onClick(() => {
          this.previous();
        })

        Button() {
          Text('▶')
            .fontSize(24)
            .fontColor('#FFFFFF')
        }
        .width(58)
        .height(58)
        .borderRadius(29)
        .backgroundColor('#16A34A')
        .onClick(() => {
          this.play();
        })

        Button() {
          Text('⏸')
            .fontSize(24)
            .fontColor('#FFFFFF')
        }
        .width(58)
        .height(58)
        .borderRadius(29)
        .backgroundColor('#DC2626')
        .onClick(() => {
          this.pause();
        })

        Button() {
          Text('⏭')
            .fontSize(24)
            .fontColor('#FFFFFF')
        }
        .width(58)
        .height(58)
        .borderRadius(29)
        .backgroundColor('#2563EB')
        .onClick(() => {
          this.next();
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 18, bottom: 24 })

      Text(`Track ${this.currentIndex + 1} of ${this.songs.length}`)
        .fontSize(14)
        .fontColor('#6B7280')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#F6F8FB')
  }

  private startTimer(): void {
    if (this.timer !== -1) {
      return;
    }

    this.timer = setInterval(() => {
      if (!this.isPlaying) {
        return;
      }

      if (this.currentProgress >= this.currentSong.duration) {
        this.next();
        return;
      }

      this.currentProgress += 1;
    }, 1000);
  }

  private stopTimer(): void {
    if (this.timer !== -1) {
      clearInterval(this.timer);
      this.timer = -1;
    }
  }

  private play(): void {
    if (this.currentProgress >= this.currentSong.duration) {
      this.currentProgress = 0;
    }

    this.isPlaying = true;
    this.startTimer();
  }

  private pause(): void {
    this.isPlaying = false;
    this.stopTimer();
  }

  private next(): void {
    this.currentIndex = (this.currentIndex + 1) % this.songs.length;
    this.currentProgress = 0;
  }

  private previous(): void {
    this.currentIndex = (this.currentIndex - 1 + this.songs.length) % this.songs.length;
    this.currentProgress = 0;
  }

  private formatTime(seconds: number): string {
    const safeSeconds: number = Math.max(0, Math.floor(seconds));
    const minutes: number = Math.floor(safeSeconds / 60);
    const remainder: number = safeSeconds % 60;

    return `${minutes}:${remainder < 10 ? '0' : ''}${remainder}`;
  }
}