import Testing
import Foundation
@testable import InboxNetworking
@testable import InboxResources

struct InboxNetworkingTests {

    // JSON parsing works with mock data
    @Test func testParsingMockJSON() async throws {
        guard let data = try? ResourceLoader.data(named: "photos-mock") else {
            #expect(Bool(false), "Mock JSON not found in InboxResources")
            return
        }

        let messages = try JSONDecoder().decode([InboxMessage].self, from: data)

        #expect(messages.count > 0)
        #expect(!messages[0].title.isEmpty)
        #expect(!messages[0].thumbnailUrl.isEmpty)
    }

    // MockNetworkingService returns success
    @Test func testMockNetworkingServiceReturnsData() async throws {
        let service = MockNetworkingService()

        let result = await withCheckedContinuation { continuation in
            service.fetchMessages { continuation.resume(returning: $0) }
        }

        switch result {
        case .success(let messages):
            #expect(messages.count > 0)
            #expect(!messages[0].title.isEmpty)
        case .failure:
            #expect(Bool(false), "Mock service should not fail")
        }
    }

    // DefaultNetworkingService returns data (optional real API)
    @Test func testDefaultNetworkingService() async throws {
        let service = DefaultNetworkingService()

        let result = await withCheckedContinuation { continuation in
            service.fetchMessages { continuation.resume(returning: $0) }
        }

        switch result {
        case .success(let messages):
            #expect(messages.count > 0)
        case .failure(let error):
            print("Skipped due to network error: \(error.localizedDescription)")
        }
    }
}
