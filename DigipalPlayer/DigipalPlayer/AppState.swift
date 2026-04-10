import Foundation
import Combine

class AppState: ObservableObject {
    static let shared = AppState()

    @Published var serverUrl: String {
        didSet {
            UserDefaults.standard.set(serverUrl, forKey: "serverUrl")
        }
    }

    @Published var showSetup: Bool = false
    @Published var kioskMode: Bool = false
    @Published var isConnected: Bool = false
    @Published var connectionMode: String = "CLOUD"

    @Published var autoStartOnLogin: Bool {
        didSet {
            UserDefaults.standard.set(autoStartOnLogin, forKey: "autoStartOnLogin")
        }
    }

    var hasServerUrl: Bool {
        !serverUrl.isEmpty
    }

    var playerUrl: String {
        guard hasServerUrl else { return "" }
        return "\(serverUrl)/tv?platform=macos"
    }

    private init() {
        self.serverUrl = UserDefaults.standard.string(forKey: "serverUrl") ?? ""
        self.autoStartOnLogin = UserDefaults.standard.bool(forKey: "autoStartOnLogin")
        self.showSetup = self.serverUrl.isEmpty
    }
}
