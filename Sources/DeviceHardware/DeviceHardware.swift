import Foundation
import Metal


protocol DeviceHardware {
    /// model name, such as iPhone 8
    var modelName: String { get }
    /// processor name, such as A11 Bionic
    var processorName: String { get }
    /// CPU information, such as 2.39GHz 6-core
    var cpu: String { get }
    /// GPU information, such as Apple A11 GPU
    var gpu: String { get }
    /// Neural Engine, such as 2-core
    var neuralEngine: String { get }
    
    /// Model Identifier, such as iPhone10,1
    var modelIdentifier: String { get }
    /// number of processor, such as 6
    var processorCount: Int { get }
    /// physical memory size [B], such as 2071019520
    var ram: Int { get }
    /// physical memory size, such as 2GB
    var ramString: String { get }
}

extension DeviceHardware {
    func getMetalGpu() -> String {
        if #available(OSX 10.11, iOS 8.0, macCatalyst 13.0, *) {
            guard let device = MTLCreateSystemDefaultDevice() else {
                return "Unknown"
            }
            
            let deviceName = device.name
                .replacingOccurrences(of: "(R)", with: "")
                .replacingOccurrences(of: "(TM)", with: "")
            return deviceName
        } else {
            // Fallback on earlier versions
            // Not support Metal
            return "Not support Metal"
        }
    }
    
    func getRAM() -> Int {
        return Int(ProcessInfo.processInfo.physicalMemory)
    }
    
    func getRAMString() -> String {
        let bytes = getRAM()
        let formatter = ByteCountFormatter()
        formatter.countStyle = .memory
        return formatter.string(fromByteCount: Int64(bytes)).replacingOccurrences(of: " ", with: "")
    }
}
