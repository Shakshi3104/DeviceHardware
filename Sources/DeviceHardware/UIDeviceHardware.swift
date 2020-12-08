import Foundation

public class UIDeviceHardware: DeviceHardware {
    var modelName: String {
        ""
    }
    
    var processorName: String {
        ""
    }
    
    var cpu: String {
        ""
    }
    
    var gpu: String {
        ""
    }
    
    var neuralEngine: String {
        ""
    }
    
    var modelIdentifier: String {
        ""
    }
    
    var processorCount: Int {
        return ProcessInfo.processInfo.processorCount
    }
    
    var ram: Int {
        return getRAM()
    }
    
    var ramString: String {
        return getRAMString()
    }
    
    
}
