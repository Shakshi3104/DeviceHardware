import Foundation

public class UIDeviceHardware: DeviceHardware {
    public static let deviceHardware = UIDeviceHardware()
    
    public var modelName: String {
        ""
    }
    
    public var processorName: String {
        ""
    }
    
    public var cpu: String {
        ""
    }
    
    public var gpu: String {
        ""
    }
    
    public var neuralEngine: String {
        ""
    }
    
    public var modelIdentifier: String {
        ""
    }
    
    public var processorCount: Int {
        return ProcessInfo.processInfo.processorCount
    }
    
    public var ram: Int {
        return getRAM()
    }
    
    public var ramString: String {
        return getRAMString()
    }
    
    
}
