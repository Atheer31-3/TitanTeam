import Foundation
import SwiftData

@Model
final class Task1 {
    var id: UUID
    var name: String
    var steps: [Step]
    var date: Date
    var priority: Double
    
    init(name: String, steps: [Step], date: Date, priority: Double) {
        self.id = UUID()
        self.name = name
        self.steps = steps
        self.date = date
        self.priority = priority
    }
}

@Model
final class Step {
    var stepDescription: String
    var isCompleted: Bool
    
    init(stepDescription: String, isCompleted: Bool) {
        self.stepDescription = stepDescription
        self.isCompleted = isCompleted
    }
}

