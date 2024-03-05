import Foundation
import SwiftUI

struct CalendarView: View {
    @State private var currentMonth = 0
    
    var body: some View {
        VStack {
            // Month navigation
            HStack {
                Button(action: {
                    currentMonth -= 1
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text("\(currentMonthOffset().monthYearText)")
                
                Spacer()
                
                Button(action: {
                    currentMonth += 1
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
            
            // Days of the week
            let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(width: 32, height: 32) // Ensure this size fits your design
                        .font(.system(size: 15))
                }
            }
            
            // Dates grid
            let days = generateDaysInMonth(currentMonthOffset())
            let rows = days.chunked(into: 7)
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(rows[rowIndex], id: \.self) { day in
                        if day > 0 {
                            Text("\(day)")
                                .frame(width: 32, height: 32)
                                .foregroundColor(isToday(day, forMonthDate: currentMonthOffset()) ? .white :
                                    (isSpecialDate(day, forMonthDate: currentMonthOffset()) ? .white : .black))
                                .background(isToday(day, forMonthDate: currentMonthOffset()) ? Circle().fill(Color.red) :
                                    (isSpecialDate(day, forMonthDate: currentMonthOffset()) ? Circle().fill(Color.blue) : Circle().fill(Color.clear)))
                                .padding(.vertical, 4)
                        } else {
                            Text("")
                                .frame(width: 32, height: 32)
                        }
                    }
                }
            }


        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
    // Adjust the current month based on user navigation
    func currentMonthOffset() -> Date {
        let calendar = Calendar.current
        guard let offsetMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else {
            return Date()
        }
        return offsetMonth
    }
    
    // Generate days for the calendar
    func generateDaysInMonth(_ forDate: Date) -> [Int] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: forDate)!
        
        let components = calendar.dateComponents([.year, .month], from: forDate)
        let startOfMonth = calendar.date(from: components)!
        
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        
        var days: [Int] = Array(repeating: 0, count: firstWeekday - 1)
        days += range.map { $0 }
        
        // Pad the end of the array to make its length a multiple of 7
        while days.count % 7 != 0 {
            days.append(0)
        }
        
        return days
    }
    
    let specialDates: [String] = ["2024-03-04","2024-03-14","2024-03-15","2024-04-30"] // Example dates

    func isSpecialDate(_ day: Int, forMonthDate monthDate: Date) -> Bool {
        let calendar = Calendar.current
        guard let dateToCheck = calendar.date(bySetting: .day, value: day, of: monthDate),
              let dayComponent = calendar.dateComponents([.year, .month, .day], from: dateToCheck).day,
              let monthComponent = calendar.dateComponents([.year, .month, .day], from: dateToCheck).month,
              let yearComponent = calendar.dateComponents([.year, .month, .day], from: dateToCheck).year,
              dayComponent == day else {
            return false
        }

        let dateString = "\(yearComponent)-\(String(format: "%02d", monthComponent))-\(String(format: "%02d", dayComponent))"
        return specialDates.contains(dateString)
    }
    func isToday(_ day: Int, forMonthDate monthDate: Date) -> Bool {
        let calendar = Calendar.current
        let today = Date()
        guard let dateToCheck = calendar.date(bySetting: .day, value: day, of: monthDate) else { return false }

        return calendar.isDate(today, inSameDayAs: dateToCheck)
    }

}

extension Date {
    var monthYearText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
