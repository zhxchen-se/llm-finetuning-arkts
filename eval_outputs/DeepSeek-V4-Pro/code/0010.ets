import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State allNames: string[] = [
    "Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Hank", "Ivy", "Jack",
    "Kate", "Leo", "Mia", "Noah", "Olivia", "Peter", "Quinn", "Rose", "Sam", "Tina",
    "Uma", "Victor", "Wendy", "Xander", "Yara", "Zane", "Anna", "Ben", "Cathy", "Dan",
    "Ella", "Fred", "Gina", "Harry", "Iris", "Jake", "Kara", "Liam", "Mona", "Nate",
    "Oscar", "Pam", "Quincy", "Rita", "Steve", "Tracy", "Ulysses", "Vera", "Will", "Xena"
  ];
  @State filteredNames: string[] = [];

  aboutToAppear(): void {
    this.filteredNames = this.allNames; // initially show all
  }

  filterByLetter(letter: string): void {
    if (letter === '') {
      this.filteredNames = this.allNames;
    } else {
      this.filteredNames = this.allNames.filter((name: string) =>
        name.charAt(0).toUpperCase() === letter.toUpperCase()
      );
    }
  }

  build() {
    Column() {
      // Filter buttons row
      Row() {
        Button('Show All')
          .onClick(() => {
            this.filterByLetter('');
          })
          .margin(5)
        Button('Filter A')
          .onClick(() => {
            this.filterByLetter('A');
          })
          .margin(5)
        // Optional: add more buttons for other letters if desired
        // For demonstration, just A and Show All
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(10)

      // List of names
      List() {
        ForEach(this.filteredNames, (name: string, index: number) => {
          ListItem() {
            Text(name)
              .fontSize(20)
              .width('100%')
              .padding(10)
              .textAlign(TextAlign.Start)
          }
        }, (name: string) => name)
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 1, color: Color.Gray })
    }
    .width('100%')
    .height('100%')
  }
}