import Testing
@testable import Core

struct CoreTests {
    @Test func kernelBootstraps() {
        let sessionManager = SessionManager()
        let kernel = AppKernel(sessionManager: sessionManager)

        #expect(type(of: kernel.defaults) == Defaults.self)
        #expect(type(of: kernel.configStore) == ConfigStore.self)
        #expect(type(of: kernel.auditLog) == AuditLog.self)
        #expect(kernel.sessionManager === sessionManager)
    }
}
