import Foundation

/// A simple error enum for network failures.
enum APIError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}

private struct ErgastResponse: Codable {
    let MRData: MRData
}

private struct MRData: Codable {
    let StandingsTable: StandingsTable
}

private struct StandingsTable: Codable {
    let StandingsLists: [StandingsList]
}

/// Manages all Ergast API calls.
final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    /// Base URL for all Ergast F1 endpoints.
    private let baseURL = "https://ergast.com/api/f1/"

    /// Path for the current constructor standings.
    private let constructorStandingsEndpoint = "current/constructorstandings.json"

    /// Fetches the current constructor standings.
    /// - Parameter completed: Returns a Result wrapping an array of `StandingsList` or an `APIError`.
    func fetchConstructorStandings(
        completed: @escaping (Result<[StandingsList], APIError>) -> Void
    ) {
        let urlString = baseURL + constructorStandingsEndpoint
        guard let url = URL(string: urlString) else {
            print("[NetworkManager] Invalid URL: \(urlString)")
            completed(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in

            if let networkError = error {
                print("[NetworkManager] Network request failed: \(networkError.localizedDescription)")
                completed(.failure(.unableToComplete))
                return
            }

            guard let httpResp = response as? HTTPURLResponse else {
                print("[NetworkManager] No HTTPURLResponse received: \(String(describing: response))")
                completed(.failure(.invalidResponse))
                return
            }

            guard httpResp.statusCode == 200 else {
                print("[NetworkManager] Invalid response status code: \(httpResp.statusCode)")
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                print("[NetworkManager] No data returned from request.")
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let ergast = try decoder.decode(ErgastResponse.self, from: data)
                let lists = ergast.MRData.StandingsTable.StandingsLists
                completed(.success(lists))
            } catch {
                let dataString = String(data: data, encoding: .utf8) ?? "<unreadable data>"
                print("[NetworkManager] JSON decode failed: \(error). Response data: \(dataString)")
                completed(.failure(.invalidData))
            }

        }.resume()
    }
}
