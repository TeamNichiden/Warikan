import UIKit

protocol ImageUploadService {
  func uploadImage(_ image: UIImage, completion: @escaping (URL?) -> Void)
}

// 仮実装（ローカル保存）
class LocalImageUploadService: ImageUploadService {
  func uploadImage(_ image: UIImage, completion: @escaping (URL?) -> Void) {
    let filename = UUID().uuidString + ".jpg"
    let url = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
    if let data = image.jpegData(compressionQuality: 0.8) {
      try? data.write(to: url)
      completion(url)
    } else {
      completion(nil)
    }
  }
}
