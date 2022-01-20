import SwiftUI
import ChartKit

@available(macOS 12.0, *)
@available(iOS 15.0, *)
struct BarChartExample: PreviewProvider {
    struct Day: BarVisualizable {
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
        
        var newUsers: Int
        var date: Date
        
    }
    static var previews: some View {
        LazyVGrid(columns:Array.init(repeating: .init(.flexible()), count: 2)) {
            BarChart(data: [
                Day(newUsers: Int.random(in: 0...400), date: Date().addingTimeInterval((86400))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((-86400*2))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((-86400*5))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((86400*6))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((-86400*7))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((-86400*8))),
            ], xScale: .pretty, accentColor: Color.blue)
                .frame(height: 400)
            BarChart(data: [
                Day(newUsers: Int.random(in: 0...400), date: Date().addingTimeInterval((86400))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((-86400*2))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((-86400*5))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((86400*6))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((-86400*7))),
                Day(newUsers: Int.random(in: 0...200), date: Date().addingTimeInterval((-86400*8))),
            ], xLabel: "Date",
                        yLabel: "New Users",
                        xScale: .real,
                        accentColor: Color.cyan)
                .frame(height: 400)
            Text("Example chart with \"pretty\" formatting and no labels")
            Text("Example chart with accurate formatting and x/y axis labels")
        }
    }
    
}
