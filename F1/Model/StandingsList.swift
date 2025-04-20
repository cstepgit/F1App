struct StandingsList: Codable {
    let season: Int
    let round: Int
    let constructorStandings: [ConstructorStandings]

    enum CodingKeys: String, CodingKey {
        case season, round
        case constructorStandings = "ConstructorStandings"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let seasonStr = try container.decode(String.self, forKey: .season)
        let roundStr = try container.decode(String.self, forKey: .round)
        guard let season = Int(seasonStr), let round = Int(roundStr) else {
            throw DecodingError.dataCorruptedError(forKey: .season,
                in: container,
                debugDescription: "Season or round is not an Int string")
        }
        self.season = season
        self.round = round
        self.constructorStandings = try container.decode([ConstructorStandings].self, forKey: .constructorStandings)
    }
}
