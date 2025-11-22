import Logging
import OSLog

public struct OSLogHandler: LogHandler {

    private let logger: OSLog
    public var logLevel: Logging.Logger.Level = .debug

    private var _metadata: Logging.Logger.Metadata = [:]

    public init(subsystem: String, category: String) {
        self.logger = OSLog(subsystem: subsystem, category: category)
    }

    // MARK: - Metadata Support

    public subscript(metadataKey key: String) -> Logging.Logger.Metadata.Value? {
        get {
            return _metadata[key]
        }
        set {
            _metadata[key] = newValue
        }
    }

    public var metadata: Logging.Logger.Metadata {
        get { _metadata }
        set { _metadata = newValue }
    }

    // MARK: - Log

    public func log(
        level: Logging.Logger.Level,
        message: Logging.Logger.Message,
        metadata: Logging.Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        guard level >= self.logLevel else { return }

        // Mesclar metadata do logger + metadata passado na chamada
        let mergedMetadata = _metadata.merging(metadata ?? [:]) { $1 }

        // Converter mensagem + metadata para string
        let messageString: String
        if mergedMetadata.isEmpty {
            messageString = message.description
        } else {
            let metadataString = mergedMetadata.map { key, value in "\(key)=\(value)" }.joined(separator: "\n")
            messageString = "\(message)\n\(metadataString)"
        }

        let osLogType = osLogType(from: level)

        os_log("%{public}@", log: logger, type: osLogType, messageString)
    }

    private func osLogType(from level: Logging.Logger.Level) -> OSLogType {
        switch level {
        case .trace, .debug:
            return .debug
        case .info:
            return .info
        case .notice, .warning:
            return .default
        case .error:
            return .error
        case .critical:
            return .fault
        }
    }
}
