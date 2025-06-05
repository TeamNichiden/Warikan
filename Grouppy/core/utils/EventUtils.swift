import Foundation

class EventUtils {
    /// 根据updatedAt时间获取最近的三个事件
    /// - Parameter events: 事件数组
    /// - Returns: 按时间排序的前三个事件（时间越近排在前面）
    static func getRecentThreeEvents(from events: [Event]) -> [Event] {
        return events
            .sorted { $0.updatedAt > $1.updatedAt } // 按updatedAt降序排列（最新的在前）
            .prefix(3) // 取前三个
            .map { $0 } // 转换为数组
    }
}