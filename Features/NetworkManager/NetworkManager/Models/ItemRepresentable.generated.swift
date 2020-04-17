// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - AutoCodable for Enums

// MARK: - Item AutoCodable
extension Item: Codable {

    private enum CodingKeys: String, CodingKey {
        case base
    }

    private enum Base: String, Codable {
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
        case 
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base = try container.decode(Base.self, forKey: .base)

        switch base {
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        case .:
            self = .
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        case .:
            try container.encode(Base., forKey: .base)
        }
    }
}
