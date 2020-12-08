import Foundation

public class MacDeviceHardware: DeviceHardware {
    public static let deviceHardware = MacDeviceHardware()
    
    public var modelName: String {
        return ""
    }
    
    public var processorName: String {
        return ""
    }
    
    public var cpu: String {
        return ""
    }
    
    public var gpu: String {
        return ""
    }
    
    public var neuralEngine: String {
        return ""
    }
    
    public var modelIdentifier: String {
        return ""
    }
    
    public var processorCount: Int {
        return -1
    }
    
    public var ram: Int {
        return getRAM()
    }
    
    public var ramString: String {
        return getRAMString()
    }
    
}
