import XCTest
@testable import DeviceHardware

final class DeviceHardwareTests: XCTestCase {
    
    func testModelIdentifier() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.modelIdentifier, "MacBookAir7,2")
        XCTAssertEqual(UIDeviceHardware.deviceHardware.modelIdentifier, "x86_64")
    }
    
    func testModelName() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.modelName, "MacBook Air (13-inch, Early 2015)")
        XCTAssertNotEqual(MacDeviceHardware.deviceHardware.modelName, "MacBook Air (13-inch, 2017)")
    }
    
    func testProcessorName() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.processorName, "Intel Core i5-5250U")
    }
    
    func testCpu() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.cpu, "1.60GHz 2-core")
    }
    
    func testGpu() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.gpu, "Intel Iris Graphics 6000")
    }
    
    func testNeuralEngine() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.neuralEngine, "None")
    }
    
    func testProcessorCount() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.processorCount, 4)
    }
    
    func testRamString() {
        XCTAssertEqual(MacDeviceHardware.deviceHardware.ramString, "8GB")
    }
    
    func testCallPerformance() {
        self.measure {
            for _ in 0..<10000 {
                _ = MacDeviceHardware.deviceHardware.modelName
            }
        }
    }
}
