struct ConstructorStandings: Codable, Identifiable {
    var id: String { constructor.constructorId }
    let position: Int
    let positionText: String
    let points: Int
    let wins: Int
    let constructor: Constructor

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case constructor = "Constructor"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let posStr = try container.decode(String.self, forKey: .position)
        let ptsStr = try container.decode(String.self, forKey: .points)
        let winsStr = try container.decode(String.self, forKey: .wins)
        guard let position = Int(posStr), let points = Int(ptsStr), let wins = Int(winsStr) else {
            throw DecodingError.dataCorruptedError(forKey: .position,
                in: container,
                debugDescription: "Position, points, or wins is not an Int string")
        }
        self.position = position
        self.positionText = try container.decode(String.self, forKey: .positionText)
        self.points = points
        self.wins = wins
        self.constructor = try container.decode(Constructor.self, forKey: .constructor)
    }
}
