import XCTest
@testable import DeviceHardware

final class DeviceHardwareTests: XCTestCase {
    
    func testModelIdentifier() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.modelIdentifier, "Mac14,12")
        XCTAssertEqual(UIDeviceHardware.deviceHardware.modelIdentifier, "arm64")
    }
    
    func testModelName() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.modelName, "Mac mini (2023)")
    }
    
    func testProcessorName() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.processorName, "Apple M2 Pro")
    }
    
    func testCpu() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.cpu, "3.49GHz 12-core")
    }
    
    func testGpu() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.gpu, "Apple M2 Pro")
    }
    
    func testNeuralEngine() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.neuralEngine, "16-core")
    }
    
    func testProcessorCount() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.processorCount, 12)
    }
    
    func testRamString() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.ramString, "32GB")
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
