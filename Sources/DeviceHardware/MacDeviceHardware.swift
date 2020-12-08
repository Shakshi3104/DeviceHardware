import Foundation

public class MacDeviceHardware: DeviceHardware {
    var modelName: String {
        return ""
    }
    
    var processorName: String {
        return ""
    }
    
    var cpu: String {
        return ""
    }
    
    var gpu: String {
        return ""
    }
    
    var neuralEngine: String {
        return ""
    }
    
    var modelIdentifier: String {
        return ""
    }
    
    var processorCount: Int {
        return -1
    }
    
    var ram: Int {
        return getRAM()
    }
    
    var ramString: String {
        return getRAMString()
    }
    
}
