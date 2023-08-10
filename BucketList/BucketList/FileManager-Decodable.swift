
import Foundation

extension FileManager {
    func decode<T: Codable>(_ inputUrl: URL) -> T {
        guard let url = try? self.url(forPublishingUbiquitousItemAt: inputUrl, expiration: nil) else {
            fatalError("Failed to load file: \(inputUrl) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file: \(inputUrl) in bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode file: \(inputUrl) from bundle.")
        }
        
        return loaded
    }
}
