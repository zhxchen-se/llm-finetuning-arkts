```typescript
// Basic types
let message: string = "Hello ArkTS"
let count: number = 42
let isActive: boolean = true
let nothing: null = null
let notDefined: undefined = undefined

// Union types
let mixed: string | number = "hello"
mixed = 100

// Type aliases
type ID = string | number
type Point = { x: number; y: number }

// Enum
enum Direction {
  Up = "UP",
  Down = "DOWN",
  Left = "LEFT",
  Right = "RIGHT"
}

// Interface
interface User {
  id: ID
  name: string
  age?: number
  readonly email: string
}

// Class with access modifiers
class Animal {
  private name: string
  protected speed: number
  public type: string

  constructor(name: string, speed: number, type: string) {
    this.name = name
    this.speed = speed
    this.type = type
  }

  getInfo(): string {
    return `${this.type}: ${this.name}, speed: ${this.speed}`
  }
}

class Dog extends Animal {
  breed: string

  constructor(name: string, speed: number, breed: string) {
    super(name, speed, "Dog")
    this.breed = breed
  }

  bark(): string {
    return "Woof!"
  }
}

// Generic function
function identity<T>(value: T): T {
  return value
}

// Generic interface
interface Repository<T> {
  items: T[]
  add(item: T): void
  getAll(): T[]
}

class ItemRepo<T> implements Repository<T> {
  items: T[] = []

  add(item: T): void {
    this.items.push(item)
  }

  getAll(): T[] {
    return this.items
  }
}

// Arrow function
const add = (a: number, b: number): number => a + b

// Optional parameters and default values
function greet(name: string, greeting: string = "Hello"): string {
  return `${greeting}, ${name}!`
}

// Rest parameters
function sum(...numbers: number[]): number {
  return numbers.reduce((acc, n) => acc + n, 0)
}

// Destructuring
const point: Point = { x: 10, y: 20 }
const { x, y } = point
const numbers: number[] = [1, 2, 3]
const [first, second] = numbers

// Spread operator
const arr1 = [1, 2, 3]
const arr2 = [...arr1, 4, 5]
const obj1 = { a: 1, b: 2 }
const obj2 = { ...obj1, c: 3 }

// Optional chaining & nullish coalescing
interface Config {
  server?: {
    port?: number
  }
}
const config: Config = {}
const port = config.server?.port ?? 3000

// Map & Set
const roleMap: Map<string, string> = new Map()
roleMap.set("admin", "Full access")
roleMap.set("user", "Read only")

const tagSet: Set<string> = new Set(["arkts", "harmony", "ets"])

// Async / Promise
async function fetchData(): Promise<string> {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve("Data loaded")
    }, 1000)
  })
}

// Custom component with @Prop
@Component
struct UserCard {
  @Prop userName: string = ""
  @Prop userAge: number = 0

  build() {
    Row() {
      Text(this.userName)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
      Text(`Age: ${this.userAge}`)
        .fontSize(14)
        .fontColor("#888888")
    }
    .width("100%")
    .padding(12)
    .borderRadius(8)
    .backgroundColor("#F5F5F5")
  }
}

// Main entry
@Entry
@Component
struct Index {
  @State currentCount: number = 0
  @State direction: Direction = Direction.Up
  @State items: string[] = ["Item A", "Item B", "Item C"]
  @State showDetails: boolean = false
  @State statusText: string = "Idle"
  @State dogInfo: string = ""
  @State repoItems: string[] = []
  @State mapEntries: string[] = []

  aboutToAppear() {
    // Class usage
    const dog = new Dog("Buddy", 30, "Golden Retriever")
    this.dogInfo = `${dog.getInfo()}, breed: ${dog.breed}, says: ${dog.bark()}`

    // Generic repo usage
    const repo = new ItemRepo<string>()
    repo.add("Apple")
    repo.add("Banana")
    repo.add("Cherry")
    this.repoItems = repo.getAll()

    // Map usage
    roleMap.forEach((value, key) => {
      this.mapEntries.push(`${key}: ${value}`)
    })

    // Async call
    this.loadAsyncData()
  }

  async loadAsyncData() {
    this.statusText = "Loading..."
    const result = await fetchData()
    this.statusText = result
  }

  // Loop: for
  buildForLoop(): string {
    let result = ""
    for (let i = 0; i < 3; i++) {
      result += `Loop${i} `
    }
    return result.trim()
  }

  // Loop: while
  buildWhileResult(): number {
    let total = 0
    let i = 1
    while (i <= 5) {
      total += i
      i++
    }
    return total
  }

  // Switch
  getDirectionLabel(dir: Direction): string {
    switch (dir) {
      case Direction.Up:
        return "⬆ Up"
      case Direction.Down:
        return "⬇ Down"
      case Direction.Left:
        return "⬅ Left"
      case Direction.Right:
        return "➡ Right"
      default:
        return "Unknown"
    }
  }

  // Try-catch
  safeParse(jsonStr: string): string {
    try {
      const parsed = JSON.parse(jsonStr) as Record<string, Object>
      return Object.keys(parsed).join(", ")
    } catch (e) {
      return `Error: ${e}`
    }
  }

  build() {
    Scroll() {
      Column({ space: 16 }) {
        // Title
        Text("ArkTS Syntax Showcase")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor("#1A1A1A")
          .width("100%")
          .textAlign(TextAlign.Center)
          .padding({ top: 20, bottom: 10 })

        // 1. Basic Types
        this.SectionTitle("1. Basic Types")
        Text(`string: "${message}" | number: ${count} | boolean: ${isActive}`)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#E8F5E9")
          .borderRadius(8)

        // 2. Union Types & Type Aliases
        this.SectionTitle("2. Union Types & Type Aliases")
        Text(`mixed: ${mixed} | ID type: ${identity<ID>(42)} | Point: (${x}, ${y})`)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#E3F2FD")
          .borderRadius(8)

        // 3. Enum
        this.SectionTitle("3. Enum")
        Row({ space: 8 }) {
          ForEach([Direction.Up, Direction.Down, Direction.Left, Direction.Right], (dir: Direction) => {
            Button(this.getDirectionLabel(dir))
              .fontSize(12)
              .backgroundColor(this.direction === dir ? "#1976D2" : "#BBDEFB")
              .fontColor(this.direction === dir ? "#FFFFFF" : "#1976D2")
              .onClick(() => {
                this.direction = dir
              })
          })
        }
        .width("100%")
        .justifyContent(FlexAlign.Center)

        Text(`Selected: ${this.getDirectionLabel(this.direction)}`)
          .fontSize(14)
          .width("100%")
          .textAlign(TextAlign.Center)

        // 4. Interface & Class
        this.SectionTitle("4. Interface & Class")
        Text(this.dogInfo)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#FFF3E0")
          .borderRadius(8)

        // 5. Functions
        this.SectionTitle("5. Functions")
        Column({ space: 6 }) {
          Text(`Arrow: add(3,4) = ${add(3, 4)}`)
          Text(`Default param: ${greet("ArkTS")}`)
          Text(`Rest param: sum(1,2,3,4,5) = ${sum(1, 2, 3, 4, 5)}`)
          Text(`Generic identity: ${identity<string>("test")}`)
        }
        .fontSize(14)
        .width("100%")
        .padding(10)
        .backgroundColor("#F3E5F5")
        .borderRadius(8)

        // 6. Destructuring & Spread
        this.SectionTitle("6. Destructuring & Spread")
        Text(`first=${first}, second=${second} | spread arr=[${arr2}] | spread obj=${JSON.stringify(obj2)}`)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#FCE4EC")
          .borderRadius(8)

        // 7. Optional Chaining & Nullish Coalescing
        this.SectionTitle("7. Optional Chaining & ??")
        Text(`config.server?.port ?? 3000 = ${port}`)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#E0F7FA")
          .borderRadius(8)

        // 8. Map & Set
        this.SectionTitle("8. Map & Set")
        Column({ space: 4 }) {
          ForEach(this.mapEntries, (entry: string) => {
            Text(entry).fontSize(13)
          })
          Text(`Set: [${Array.from(tagSet).join(", ")}]`).fontSize(13).margin({ top: 4 })
        }
        .width("100%")
        .padding(10)
        .backgroundColor("#FFF8E1")
        .borderRadius(8)

        // 9. Loops
        this.SectionTitle("9. Loops")
        Text(`for: ${this.buildForLoop()} | while: 1+2+3+4+5 = ${this.buildWhileResult()}`)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#EFEBE9")
          .borderRadius(8)

        // 10. Array Methods
        this.SectionTitle("10. Array Methods")
        Column({ space: 4 }) {
          Text(`map: [${[1, 2, 3].map(n => n * 10).join(", ")}]`)
          Text(`filter: [${[1, 2, 3, 4, 5].filter(n => n % 2 === 0).join(", ")}]`)
          Text(`reduce: ${[1, 2, 3, 4, 5].reduce((a, b) => a + b, 0)}`)
          Text(`find: ${[1, 2, 3, 4].find(n => n > 2)}`)
          Text(`some: ${[1, 2, 3].some(n => n > 2)}`)
          Text(`every: ${[1, 2, 3].every(n => n > 0)}`)
        }
        .fontSize(14)
        .width("100%")
        .padding(10)
        .backgroundColor("#E8EAF6")
        .borderRadius(8)

        // 11. Try-Catch
        this.SectionTitle("11. Try-Catch")
        Text(`Valid JSON: ${this.safeParse('{"name":"Ark","ver":5}')}`)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#F1F8E9")
          .borderRadius(8)

        // 12. Async/Promise
        this.SectionTitle("12. Async / Promise")
        Text(`Status: ${this.statusText}`)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#FFF9C4")
          .borderRadius(8)

        // 13. @State & Event Handling
        this.SectionTitle("13. @State & Events")
        Row({ space: 12 }) {
          Button("-")
            .fontSize(20)
            .width(50)
            .height(50)
            .backgroundColor("#EF5350")
            .onClick(() => {
              this.currentCount--
            })

          Text(`${this.currentCount}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .width(60)
            .textAlign(TextAlign.Center)

          Button("+")
            .fontSize(20)
            .width(50)
            .height(50)
            .backgroundColor("#66BB6A")
            .onClick(() => {
              this.currentCount++
            })
        }
        .justifyContent(FlexAlign.Center)

        // 14. Conditional Rendering (if/else in UI)
        this.SectionTitle("14. Conditional Rendering")
        Button(this.showDetails ? "Hide Details" : "Show Details")
          .onClick(() => {
            this.showDetails = !this.showDetails
          })
          .backgroundColor("#7E57C2")

        if (this.showDetails) {
          Column() {
            Text("Hidden details revealed!")
              .fontSize(16)
              .fontColor("#4A148C")
            Text("This block is conditionally rendered using if/else in ArkTS UI.")
              .fontSize(12)
              .fontColor("#7B1FA2")
          }
          .width("100%")
          .padding(12)
          .backgroundColor("#EDE7F6")
          .borderRadius(8)
        } else {
          Text("Click the button to see details.")
            .fontSize(14)
            .fontColor("#9E9E9E")
            .width("100%")
            .textAlign(TextAlign.Center)
        }

        // 15. ForEach Rendering
        this.SectionTitle("15. ForEach Rendering")
        Column({ space: 8 }) {
          ForEach(this.items, (item: string, index?: number) => {
            Row() {
              Text(`${index !== undefined ? index + 1 : ""}. ${item}`)
                .fontSize(14)
                .layoutWeight(1)
              Button("✕")
                .fontSize(12)
                .width(30)
                .height(30)
                .backgroundColor("#EF5350")
                .onClick(() => {
                  if (index !== undefined) {
                    this.items.splice(index, 1)
                  }
                })
            }
            .width("100%")
            .padding(8)
            .backgroundColor("#FFFFFF")
            .borderRadius(6)
            .shadow({ radius: 2, color: "#00000010", offsetY: 1 })
          })
        }
        .width("100%")

        Row({ space: 8 }) {
          TextInput({ placeholder: "New item" })
            .id("newItemInput")
            .layoutWeight(1)
            .height(40)
            .onSubmit((value: string) => {
              if (value.trim()) {
                this.items.push(value.trim())
              }
            })
          Button("Add")
            .height(40)
            .backgroundColor("#43A047")
            .onClick(() => {
              const input = this.getUIContext().getComponentByKey("newItemInput") as TextInput
              if (input && input.text && input.text.trim()) {
                this.items.push(input.text.trim())
              }
            })
        }
        .width("100%")

        // 16. Custom Component with @Prop
        this.SectionTitle("16. Custom Component (@Prop)")
        UserCard({ userName: "Alice", userAge: 28 })
        UserCard({ userName: "Bob", userAge: 35 })

        // 17. Generic Repository
        this.SectionTitle("17. Generic Repository")
        Text(`Repo items: [${this.repoItems.join(", ")}]`)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#E0F2F1")
          .borderRadius(8)

        // 18. Type Assertion & as
        this.SectionTitle("18. Type Assertion")
        Text(`as Record: ${this.safeParse('{"lang":"ArkTS","version":5}')}`)
          .fontSize(14)
          .width("100%")
          .padding(10)
          .backgroundColor("#FBE9E7")
          .borderRadius(8)

        // Footer
        Text("— End of ArkTS Syntax Showcase —")
          .fontSize(12)
          .fontColor("#BDBDBD")
          .margin({ top: 20, bottom: 40 })
      }
      .width("100%")
      .padding({ left: 16, right: 16 })
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#FAFAFA")
  }

  @Builder
  SectionTitle(title: string) {
    Text(title)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor("#424242")
      .width("100%")
      .margin({ top: 8 })
  }
}