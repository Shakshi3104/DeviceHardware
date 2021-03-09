import XCTest
@testable import DeviceHardware

final class DeviceHardwareTests: XCTestCase {
    
    func testModelIdentifier() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.modelIdentifier, "MacBookPro17,1")
        XCTAssertEqual(UIDeviceHardware.deviceHardware.modelIdentifier, "arm64")
    }
    
    func testModelName() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.modelName, "MacBook Pro (13-inch, M1, 2020)")
    }
    
    func testProcessorName() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.processorName, "Apple M1")
    }
    
    func testCpu() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.cpu, "3.2GHz 8-core")
    }
    
    func testGpu() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.gpu, "Apple M1")
    }
    
    func testNeuralEngine() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.neuralEngine, "16-core")
    }
    
    func testProcessorCount() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.processorCount, 8)
    }
    
    func testRamString() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.ramString, "16GB")
    }
    
    func testUINeuralEngine() {
        XCTAssertEqual(UIDeviceHardware.deviceHardware.neuralEngine, "N/A")
    }
    
    func testCallPerformance() {
        self.measure {
            for _ in 0..<10000 {
                _ = MacDeviceHardware.deviceHardware.modelName
            }
        }
    }
}
