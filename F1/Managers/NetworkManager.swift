import Foundation

/// A simple error enum for network failures.
enum APIError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}

private struct ConstructorErgastResponse: Codable {
    let MRData: ConstructorMRData
}

private struct ConstructorMRData: Codable {
    let StandingsTable: ConstructorStandingsTable
}

private struct ConstructorStandingsTable: Codable {
    let StandingsLists: [ConstructorStandingsList]
}

private struct DriverErgastResponse: Codable {
    let MRData: DriverMRData
}

private struct DriverMRData: Codable {
    let StandingsTable: DriverStandingsTable
}

private struct DriverStandingsTable: Codable {
    let StandingsLists: [DriverStandingsList]
}




final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = "https://ergast.com/api/f1/"
    private let constructorStandingsEndpoint = "current/constructorstandings.json"
    private let driverStandingsEndpoint = "current/driverstandings.json"

    func fetchConstructorStandings(
        completed: @escaping (Result<[ConstructorStandingsList], APIError>) -> Void
    ) {
        let urlString = baseURL + constructorStandingsEndpoint
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ConstructorErgastResponse.self, from: data)
                completed(.success(result.MRData.StandingsTable.StandingsLists))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }

    func fetchDriverStandings(
        completed: @escaping (Result<[DriverStandingsList], APIError>) -> Void
    ) {
        let urlString = baseURL + driverStandingsEndpoint
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(DriverErgastResponse.self, from: data)
                completed(.success(result.MRData.StandingsTable.StandingsLists))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
}
