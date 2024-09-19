import Foundation
import CryptoKit

class EncryptionManager {
    static let shared = EncryptionManager()
    
    private let key: SymmetricKey
    
    private init() {
        // Генерация или загрузка ключа
        // В реальном приложении ключ может храниться в Keychain или получаться с сервера
        key = SymmetricKey(size: .bits256)
    }
    
    func encryptMessage(_ message: String) -> Data? {
        guard let data = message.data(using: .utf8) else { return nil }
        do {
            let sealedBox = try ChaChaPoly.seal(data, using: key)
            return sealedBox.combined
        } catch {
            print("Ошибка шифрования: \(error)")
            return nil
        }
    }
    
    func decryptMessage(_ data: Data) -> String? {
        do {
            let sealedBox = try ChaChaPoly.SealedBox(combined: data)
            let decryptedData = try ChaChaPoly.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Ошибка расшифровки: \(error)")
            return nil
        }
    }
}
