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
            return device.name
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
        var n = bytes
        var prefix = 0
        
        // calc prefix
        while(n != 0) {
            n = n / 1024
            prefix += 1
        }
        prefix -= 1
        
        let xBytes = Double(bytes) / Double(1024 ** prefix)
        
        // B to TB
        switch prefix {
        case 0:
            return "\(Int(round(xBytes)))B"
        case 1:
            return "\(Int(round(xBytes)))kB"
        case 2:
            return "\(Int(round(xBytes)))MB"
        case 3:
            return "\(Int(round(xBytes)))GB"
        case 4:
            return "\(round(xBytes*10)/10)TB"
        default:
            return "\(bytes)B"
        }
    }
}

// Python-like power operator
infix operator **: MultiplicationPrecedence

extension Int {
    static func **(number: Int, power: Int) -> Int {
        return Int(pow(Double(number), Double(power)))
    }
}
