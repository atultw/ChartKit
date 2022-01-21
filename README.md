# ChartKit

Pure SwiftUI chart library. 

## Principles
* Unopinionated: Full customization, no assumptions
* Idiomatic: Rely on SwiftUI layout system as much as possible, minimum hard-coded dimensions
* Extensible: Protocols for everything

## Why?

This isn't the first SwiftUI chart library. Here's what makes ChartKit better:

### No funky layout
Some libraries require you to set a fixed size in px. SwiftUI views should fill the whole container.

### Single accepted data type
With ChartKit, no need to `map` your item collections before charting each time. Conform to the *-`Visualizable` protocols so you can write clean code like:

```swift
// Use easily!
var sales: [DaySummary]
BarChart(data: sales)

struct DaySummary: BarVisualizable { 
  var day: Date
  var saleCount: Double
  
  // ChartKit part
  func numericX() -> Double {
      date.timeIntervalSince1970
  }

  func numericY() -> Double {
      Double(newUsers)
  }

  func label() -> String {
      date.formatted() + ": " + String(newUsers)
  }

  var id: Date {
      self.date
  }
}
```
