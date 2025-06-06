import Foundation
import SwiftData

@Model
class AppUser: Identifiable, Codable {
    @Attribute(.unique) var id: UUID
    var name: String
    var email: String
    var userId: String
    var iconUrl: URL?
    var iconData: Data? // 用于保存选择的图片数据
    
    init(id: UUID = UUID(), name: String, email: String, userId: String, iconUrl: URL? = nil, iconData: Data? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.userId = userId
        self.iconUrl = iconUrl
        self.iconData = iconData
    }
    
    // Codable 实现
    enum CodingKeys: String, CodingKey {
        case id, name, email, userId, iconUrl, iconData
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        userId = try container.decode(String.self, forKey: .userId)
        iconUrl = try container.decodeIfPresent(URL.self, forKey: .iconUrl)
        iconData = try container.decodeIfPresent(Data.self, forKey: .iconData)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(userId, forKey: .userId)
        try container.encodeIfPresent(iconUrl, forKey: .iconUrl)
        try container.encodeIfPresent(iconData, forKey: .iconData)
    }
}

// 为了兼容性，保留原来的 struct 版本作为数据传输对象
struct AppUserDTO: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var email: String
    var userId: String
    var iconUrl: URL?
    var iconData: Data?
    
    init(from appUser: AppUser) {
        self.id = appUser.id
        self.name = appUser.name
        self.email = appUser.email
        self.userId = appUser.userId
        self.iconUrl = appUser.iconUrl
        self.iconData = appUser.iconData
    }
}
