import Foundation

public class UIDeviceHardware: DeviceHardware {
    public static let deviceHardware = UIDeviceHardware()
    
    /// model name, such as iPhone 8
    public var modelName: String {
        let modelName_ = getModelName() ?? "Unknown"
        return modelName_
    }
    /// processor name, such as A11 Bionic
    public var processorName: String {
        let processorName_ = getProcessorName() ?? "Unknown"
        return processorName_
    }
    /// CPU information, such as 2.39GHz 6-core
    public var cpu: String {
        let cpu_ = getCpu() ?? "Unknown"
        return cpu_
    }
    /// GPU information, such as Apple A11 GPU
    public var gpu: String {
        let gpu_ = getGpu() ?? "Unknown"
        return gpu_
    }
    /// Neural Engine, such as 2-core
    public var neuralEngine: String {
        let neuralEngine_ = getNeuralEngine() ?? "Unknown"
        return neuralEngine_
    }
    
    /// Model Identifier, such as iPhone10,1
    public var modelIdentifier: String {
        let modelId = getModelIdentifier() ?? "Unknown"
        return modelId
    }
    /// number of processor, such as 6
    public var processorCount: Int {
        return ProcessInfo.processInfo.processorCount
    }
    /// physical memory size [B], such as 2071019520
    public var ram: Int {
        return getRAM()
    }
    /// physical memory size, such as 2GB
    public var ramString: String {
        return getRAMString()
    }
    
    // MARK: -
    private func getModelIdentifier() -> String? {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        if sysctlbyname("hw.machine", &machine, &size, nil, 0) != 0 {
            return nil
        }
        let code: String = String(cString:machine)
        
        return code
    }
    
    private func getModelName() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        return modelId.modelName()
    }
    
    private func getProcessorName() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        return modelId.processorName()
    }
    
    private func getCpu() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        return modelId.cpu()
    }
    
    private func getGpu() -> String? {
        if #available(OSX 10.11, iOS 8.0, macCatalyst 13.0, *) {
            return getMetalGpu()
        } else {
            // Fallback on earlier versions
            guard let id = getModelIdentifier() else {
                return nil
            }
            
            guard let modelId = ModelIdentifier(rawValue: id) else {
                return nil
            }
            
            return modelId.gpu()
        }
    }
    
    private func getNeuralEngine() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        return modelId.neuralEngine()
    }
    
    // MARK: -
    enum ModelIdentifier: String {
        // MARK: Simulator
        case i386
        case x86_64
        case arm64
        // MARK: iPod
        /// iPod touch (1st Generation)
        case iPod1_1 = "iPod1,1"
        /// iPod touch (2nd Generation)
        case iPod2_1 = "iPod2,1"
        /// iPod touch (3rd Generation)
        case iPod3_1 = "iPod3,1"
        /// iPod touch (4th Generation)
        case iPod4_1 = "iPod4,1"
        /// iPod touch (5th Generation)
        case iPod5_1 = "iPod5,1"
        /// iPod touch (6th Generation)
        case iPod7_1 = "iPod7,1"
        /// iPod touch (7th Generation)
        case iPod9_1 = "iPod9,1"

        // MARK: iPhone
        /// iPhone
        case iPhone1_1 = "iPhone1,1"
        /// iPhone 3G
        case iPhone1_2 = "iPhone1,2"
        /// iPhone 3GS
        case iPhone2_1 = "iPhone2,1"
        /// iPhone 4 GSM
        case iPhone3_1 = "iPhone3,1"
        /// iPhone 4 GSM 2012
        case iPhone3_2 = "iPhone3,2"
        /// iPhone 4 CDMA For Verizon,Sprint
        case iPhone3_3 = "iPhone3,3"
        /// iPhone 4S
        case iPhone4_1 = "iPhone4,1"
        /// iPhone 5 GSM
        case iPhone5_1 = "iPhone5,1"
        /// iPhone 5 Global
        case iPhone5_2 = "iPhone5,2"
        /// iPhone 5c GSM
        case iPhone5_3 = "iPhone5,3"
        /// iPhone 5c Global
        case iPhone5_4 = "iPhone5,4"
        /// iPhone 5s GSM
        case iPhone6_1 = "iPhone6,1"
        /// iPhone 5s Global
        case iPhone6_2 = "iPhone6,2"
        /// iPhone 6 Plus
        case iPhone7_1 = "iPhone7,1"
        /// iPhone 6
        case iPhone7_2 = "iPhone7,2"
        /// iPhone 6S
        case iPhone8_1 = "iPhone8,1"
        /// iPhone 6S Plus
        case iPhone8_2 = "iPhone8,2"
        /// iPhone SE
        case iPhone8_4 = "iPhone8,4"
        /// iPhone 7 A1660,A1779,A1780
        case iPhone9_1 = "iPhone9,1"
        /// iPhone 7 A1778
        case iPhone9_3 = "iPhone9,3"
        /// iPhone 7 Plus A1661,A1785,A1786
        case iPhone9_2 = "iPhone9,2"
        /// iPhone 7 Plus A1784
        case iPhone9_4 = "iPhone9,4"
        /// iPhone 8 A1863,A1906,A1907
        case iPhone10_1 = "iPhone10,1"
        /// iPhone 8 A1905
        case iPhone10_4 = "iPhone10,4"
        /// iPhone 8 Plus A1864,A1898,A1899
        case iPhone10_2 = "iPhone10,2"
        /// iPhone 8 Plus A1897
        case iPhone10_5 = "iPhone10,5"
        /// iPhone X A1865,A1902
        case iPhone10_3 = "iPhone10,3"
        /// iPhone X A1901
        case iPhone10_6 = "iPhone10,6"
        /// iPhone XR A1984,A2105,A2106,A2108
        case iPhone11_8 = "iPhone11,8"
        /// iPhone XS A2097,A2098
        case iPhone11_2 = "iPhone11,2"
        /// iPhone XS Max A1921,A2103
        case iPhone11_4 = "iPhone11,4"
        /// iPhone XS Max A2104
        case iPhone11_6 = "iPhone11,6"
        /// iPhone 11
        case iPhone12_1 = "iPhone12,1"
        /// iPhone 11 Pro
        case iPhone12_3 = "iPhone12,3"
        /// iPhone 11 Pro Max
        case iPhone12_5 = "iPhone12,5"
        /// iPhone SE (2nd Generation)
        case iPhone12_8 = "iPhone12,8"
        /// iPhone 12 mini
        case iPhone13_1 = "iPhone13,1"
        /// iPhone 12
        case iPhone13_2 = "iPhone13,2"
        /// iPhone 12 Pro
        case iPhone13_3 = "iPhone13,3"
        /// iPhone 12 Pro Max
        case iPhone13_4 = "iPhone13,4"

        // MARK: iPad
        /// iPad
        case iPad1_1 = "iPad1,1"
        /// iPad 2
        case iPad2_1 = "iPad2,1"
        /// iPad 2 GSM
        case iPad2_2 = "iPad2,2"
        /// iPad 2 CDMA (Cellular)
        case iPad2_3 = "iPad2,3"
        /// iPad 2 Mid2012
        case iPad2_4 = "iPad2,4"
        /// iPad mini WiFi
        case iPad2_5 = "iPad2,5"
        /// iPad mini GSM (Cellular)
        case iPad2_6 = "iPad2,6"
        /// iPad mini Global (Cellular)
        case iPad2_7 = "iPad2,7"
        /// iPad 3 WiFi
        case iPad3_1 = "iPad3,1"
        /// iPad 3 CDMA (Cellular)
        case iPad3_2 = "iPad3,2"
        /// iPad 3 GSM (Cellular)
        case iPad3_3 = "iPad3,3"
        /// iPad 4 WiFi
        case iPad3_4 = "iPad3,4"
        /// iPad 4 GSM (Cellular)
        case iPad3_5 = "iPad3,5"
        /// iPad 4 Global (Cellular)
        case iPad3_6 = "iPad3,6"
        /// iPad Air WiFi
        case iPad4_1 = "iPad4,1"
        /// iPad Air Cellular
        case iPad4_2 = "iPad4,2"
        /// iPad Air ChinaModel
        case iPad4_3 = "iPad4,3"
        /// iPad mini 2 WiFi
        case iPad4_4 = "iPad4,4"
        /// iPad mini 2 Cellular
        case iPad4_5 = "iPad4,5"
        /// iPad mini 2 ChinaModel
        case iPad4_6 = "iPad4,6"
        /// iPad mini 3 WiFi
        case iPad4_7 = "iPad4,7"
        /// iPad mini 3 Cellular
        case iPad4_8 = "iPad4,8"
        /// iPad mini 3 ChinaModel
        case iPad4_9 = "iPad4,9"
        /// iPad mini 4 WiFi
        case iPad5_1 = "iPad5,1"
        /// iPad mini 4 Cellular
        case iPad5_2 = "iPad5,2"
        /// iPad Air 2 WiFi
        case iPad5_3 = "iPad5,3"
        /// iPad Air 2 Cellular
        case iPad5_4 = "iPad5,4"
        /// iPad Pro 9.7inch WiFi
        case iPad6_3 = "iPad6,3"
        /// iPad Pro 9.7inch Cellular
        case iPad6_4 = "iPad6,4"
        /// iPad Pro 12.9inch WiFi
        case iPad6_7 = "iPad6,7"
        /// iPad Pro 12.9inch Cellular
        case iPad6_8 = "iPad6,8"
        /// iPad (5th Generation) WiFi
        case iPad6_11 = "iPad6,11"
        /// iPad (5th Generation) Cellular
        case iPad6_12 = "iPad6,12"
        /// iPad Pro 12.9inch (2nd Generation) WiFi
        case iPad7_1 = "iPad7,1"
        /// iPad Pro 12.9inch (2nd Generation) Cellular
        case iPad7_2 = "iPad7,2"
        /// iPad Pro 10.5inch A1701 WiFi
        case iPad7_3 = "iPad7,3"
        /// iPad Pro 10.5inch A1709 Cellular
        case iPad7_4 = "iPad7,4"
        /// iPad 6th Generation WiFi
        case iPad7_5 = "iPad7,5"
        /// iPad 6th Generation Cellular
        case iPad7_6 = "iPad7,6"
        /// iPad 7th Generation WiFi
        case iPad7_11 = "iPad7,11"
        /// iPad 7th Generation Cellular
        case iPad7_12 = "iPad7,12"
        /// iPad Pro 11inch WiFi
        case iPad8_1 = "iPad8,1"
        /// iPad Pro 11inch WiFi
        case iPad8_2 = "iPad8,2"
        /// iPad Pro 11inch Cellular
        case iPad8_3 = "iPad8,3"
        /// iPad Pro 11inch Cellular
        case iPad8_4 = "iPad8,4"
        /// iPad Pro 12.9inch WiFi
        case iPad8_5 = "iPad8,5"
        /// iPad Pro 12.9inch WiFi
        case iPad8_6 = "iPad8,6"
        /// iPad Pro 12.9inch Cellular
        case iPad8_7 = "iPad8,7"
        /// iPad Pro 12.9inch Cellular
        case iPad8_8 = "iPad8,8"
        /// iPad Pro 11inch (2nd generation) WiFi
        case iPad8_9 = "iPad8,9"
        /// iPad Pro 11inch (2nd generation) Cellular
        case iPad8_10 = "iPad8,10"
        /// iPad Pro 12.9inch (4th generation) WiFi
        case iPad8_11 = "iPad8,11"
        /// iPad Pro 12.9inch (4th generation) Cellular
        case iPad8_12 = "iPad8,12"
        /// iPad mini 5th WiFi
        case iPad11_1 = "iPad11,1"
        /// iPad mini 5th Cellular
        case iPad11_2 = "iPad11,2"
        /// iPad Air (3rd generation) WiFi
        case iPad11_3 = "iPad11,3"
        /// iPad Air (3rd generation) Cellular
        case iPad11_4 = "iPad11,4"
        /// iPad (8th generation) WiFi
        case iPad11_6 = "iPad11,6"
        /// iPad (8th generation) Cellular
        case iPad11_7 = "iPad11,7"
        /// iPad Air (4th generation) WiFi
        case iPad13_1 = "iPad13,1"
        /// iPad Air (4th generation) Cellular
        case iPad13_2 = "iPad13,2"
        
        /// model name
        func modelName() -> String {
            switch self {
            case .i386, .x86_64, .arm64:
                return "Simulator"
            case .iPod1_1:
                return "iPod touch (1st generation)"
            case .iPod2_1:
                return "iPod touch (2nd generation)"
            case .iPod3_1:
                return "iPod touch (3rd generation)"
            case .iPod4_1:
                return "iPod touch (4th generation)"
            case .iPod5_1:
                return "iPod touch (5th generation)"
            case .iPod7_1:
                return "iPod touch (6th generation)"
            case .iPod9_1:
                return "iPod touch (7th generation)"
            case .iPhone1_1:
                return "iPhone (the original iPhone)"
            case .iPhone1_2:
                return "iPhone 3G"
            case .iPhone2_1:
                return "iPhone 3GS"
            case .iPhone3_1, .iPhone3_2, .iPhone3_3:
                return "iPhone4"
            case .iPhone4_1:
                return "iPhone 4S"
            case .iPhone5_1, .iPhone5_2:
                return "iPhone 5"
            case .iPhone5_3, .iPhone5_4:
                return "iPhone 5c"
            case .iPhone6_1, .iPhone6_2:
                return "iPhone 5s"
            case .iPhone7_1:
                return "iPhone 6 Plus"
            case .iPhone7_2:
                return "iPhone 6"
            case .iPhone8_1:
                return "iPhone 6s"
            case .iPhone8_2:
                return "iPhone 6s Plus"
            case .iPhone8_4:
                return "iPhone SE (1th generation)"
            case .iPhone9_1, .iPhone9_3:
                return "iPhone 7"
            case .iPhone9_2, .iPhone9_4:
                return "iPhone 7 Plus"
            case .iPhone10_1, .iPhone10_4:
                return "iPhone 8"
            case .iPhone10_2, .iPhone10_5:
                return "iPhone 8 Plus"
            case .iPhone10_3, .iPhone10_6:
                return "iPhone X"
            case .iPhone11_8:
                return "iPhone XR"
            case .iPhone11_2:
                return "iPhone XS"
            case .iPhone11_4, .iPhone11_6:
                return "iPhone XS Max"
            case .iPhone12_1:
                return "iPhone 11"
            case .iPhone12_3:
                return "iPhone 11 Pro"
            case .iPhone12_5:
                return "iPhone 11 Pro Max"
            case .iPhone12_8:
                return "iPhone SE (2nd generation)"
            case .iPhone13_1:
                return "iPhone 12 mini"
            case .iPhone13_2:
                return "iPhone 12"
            case .iPhone13_3:
                return "iPhone 12 Pro"
            case .iPhone13_4:
                return "iPhone 12 Pro Max"
            case .iPad1_1:
                return "iPad (1st generation)"
            case .iPad2_1, .iPad2_4, .iPad2_2, .iPad2_3:
                    return "iPad 2"
            case .iPad2_5, .iPad2_6, .iPad2_7:
                return "iPad mini"
            case .iPad3_1, .iPad3_2, .iPad3_3:
                return "iPad (3rd generation) (The new iPad)"
            case .iPad3_4, .iPad3_5, .iPad3_6:
                return "iPad (4th generation) (iPad with Retina display)"
            case .iPad4_1, .iPad4_2, .iPad4_3:
                return "iPad Air (1th generation)"
            case .iPad4_4, .iPad4_5, .iPad4_6:
                return "iPad mini 2"
            case .iPad4_7, .iPad4_8, .iPad4_9:
                return "iPad mini 3"
            case .iPad5_1, .iPad5_2:
                return "iPad mini 4"
            case .iPad5_3, .iPad5_4:
                return "iPad Air 2"
            case .iPad6_3, .iPad6_4:
                return "iPad Pro (9.7-inch)"
            case .iPad6_7, .iPad6_8:
                return "iPad Pro (12.9-inch) (1st generation)"
            case .iPad6_11, .iPad6_12:
                return "iPad (5th generation)"
            case .iPad7_1, .iPad7_2:
                return "iPad Pro (12.9-inch) (2nd generation)"
            case .iPad7_3, .iPad7_4:
                return "iPad Pro (10.5-inch)"
            case .iPad7_5, .iPad7_6:
                return "iPad (6th generation)"
            case .iPad7_11, .iPad7_12:
                return "iPad (7th generation)"
            case .iPad8_1, .iPad8_2, .iPad8_3, .iPad8_4:
                return "iPad Pro (11-inch)"
            case .iPad8_5, .iPad8_6, .iPad8_7, .iPad8_8:
                return "iPad Pro (12.9-inch) (3rd generation)"
            case .iPad8_9, .iPad8_10:
                return "iPad Pro (11-inch) (2nd generation)"
            case .iPad8_11, .iPad8_12:
                return "iPad Pro (12.9-inch) (4th generation)"
            case .iPad11_1, .iPad11_2:
                return "iPad mini (5th generation)"
            case .iPad11_3, .iPad11_4:
                return "iPad Air (3rd generation)"
            case .iPad11_6, .iPad11_7:
                return "iPad (8th generation)"
            case .iPad13_1, .iPad13_2:
                return "iPad Air (4th generation)"
            }
        }
            
            // Processor (SoC) Name
        func processorName() -> String {
            switch self {
            /// Simulator
            case .i386, .x86_64, .arm64:
                return "N/A"
            /// iPhone, iPod touch (1st), iPhone 3G
            case .iPod1_1, .iPhone1_1, .iPhone1_2:
                return "APL0098"
            /// iPod touch (2nd)
            case .iPod2_1:
                return "APL0278"
            /// iPhone 3GS
            case .iPhone2_1:
                return "APL0298"
            /// iPod touch (3rd)
            case .iPod3_1:
                return "APL2298"
            /// iPhone 4, iPad (1st), iPod touch (4th)
            case .iPod4_1, .iPhone3_1, .iPhone3_2, .iPhone3_3, .iPad1_1:
                return "Apple A4"
            /// iPhone 4s, iPad 2, iPod touch (5th), iPad mini (1st)
            case .iPhone4_1, .iPod5_1, .iPad2_5, .iPad2_6, .iPad2_7, .iPad2_1, .iPad2_2, .iPad2_3, .iPad2_4:
                return "Apple A5"
            /// iPad (3rd)
            case .iPad3_1, .iPad3_2, .iPad3_3:
                return "Apple A5X"
            /// iPhone 5, iPhone 5c
            case .iPhone5_1, .iPhone5_2, .iPhone5_3, .iPhone5_4:
                return "Apple A6"
            /// iPad (4th)
            case .iPad3_4, .iPad3_5, .iPad3_6:
                return "Apple A6X"
            /// iPhone 5s, iPad mini 2, iPad mini 3, iPad Air (1st)
            case .iPhone6_1, .iPhone6_2, .iPad4_4, .iPad4_5, .iPad4_6, .iPad4_7, .iPad4_8, .iPad4_9, .iPad4_1, .iPad4_2, .iPad4_3:
                return "Apple A7"
            /// iPhone 6/6 Plus, iPod touch (6th), iPad mini 4
            case .iPhone7_1, .iPhone7_2, .iPod7_1, .iPad5_1, .iPad5_2:
                return "Apple A8"
            /// iPad Air (2nd)
            case .iPad5_4, .iPad5_3:
                return "Apple A8X"
            /// iPhone 6s/6s Plus, iPhone SE (1st), iPad (5th)
            case .iPhone8_1, .iPhone8_2, .iPhone8_4, .iPad6_11, .iPad6_12:
                return "Apple A9"
            /// iPad Pro (1st)
            case .iPad6_3, .iPad6_4, .iPad6_7, .iPad6_8:
                return "Apple A9X"
            /// iPhone 7/7 Plus, iPad (6th), iPod touch (7th), iPad (7th)
            case .iPhone9_1, .iPhone9_2, .iPhone9_3, .iPhone9_4, .iPad7_5, .iPad7_6, .iPod9_1, .iPad7_11, .iPad7_12:
                return "Apple A10 Fusion"
            /// iPad Pro (2nd)
            case .iPad7_1, .iPad7_2, .iPad7_3, .iPad7_4:
                return "Apple A10X Fusion"
            /// iPhone 8/8 Plus, iPhone X
            case .iPhone10_1, .iPhone10_2, .iPhone10_3, .iPhone10_4, .iPhone10_5, .iPhone10_6:
                return "Apple A11 Bionic"
            /// iPhone XS/XS Max, iPhone XR, iPad Air (3rd), iPad mini (5th), iPad (8th)
            case .iPhone11_2, .iPhone11_4, .iPhone11_6, .iPhone11_8, .iPad11_3, .iPad11_4, .iPad11_1, .iPad11_2, .iPad11_6, .iPad11_7:
                return "Apple A12 Bionic"
            /// iPad Pro (3rd)
            case .iPad8_1, .iPad8_2, .iPad8_3, .iPad8_4, .iPad8_5, .iPad8_6, .iPad8_7, .iPad8_8:
                return "Apple A12X Bionic"
            /// iPad Pro (4th)
            case .iPad8_9, .iPad8_10, .iPad8_11, .iPad8_12:
                return "Apple A12Z Bionic"
            /// iPhone 11, iPhone 11 Pro/11 Pro Max, iPhone SE (2nd)
            case .iPhone12_1, .iPhone12_3, .iPhone12_5, .iPhone12_8:
                return "Apple A13 Bionic"
            /// iPhone 12/12 mini, iPhone 12 Pro/12 Pro Max, iPad Air (4th)
            case .iPhone13_1, .iPhone13_2, .iPhone13_3, .iPhone13_4, .iPad13_1, .iPad13_2:
                return "Apple A14 Bionic"
            }
        }
        
        
        // CPU Information
        func cpu() -> String {
            switch self {
             /// Simulator
            case .i386, .x86_64, .arm64:
                return "N/A"
             /// iPhone, iPod touch (1st), iPhone 3G
            case .iPod1_1, .iPhone1_1, .iPhone1_2:
                return "412MHz 1-core"
             /// iPod touch (2nd)
            case .iPod2_1:
                return "533MHz 1-core"
             /// iPhone 3GS
            case .iPhone2_1:
                return "600MHz 1-core"
             /// iPod touch (3rd)
            case .iPod3_1:
                return "800MHz 1-core"
             /// iPhone 4, iPad (1st), iPod touch (4th)
            case .iPod4_1, .iPhone3_1, .iPhone3_2, .iPhone3_3, .iPad1_1:
                return "1.0GHz 1-core"
             /// iPhone 4s, iPad 2, iPod touch (5th), iPad mini (1st)
            case .iPhone4_1, .iPod5_1, .iPad2_5, .iPad2_6, .iPad2_7, .iPad2_1, .iPad2_2, .iPad2_3, .iPad2_4:
                return "1.0GHz 2-core"
             /// iPad (3rd)
            case .iPad3_1, .iPad3_2, .iPad3_3:
                return "1.0GHz 2-core"
             /// iPhone 5, iPhone 5c
            case .iPhone5_1, .iPhone5_2, .iPhone5_3, .iPhone5_4:
                return "1.3GHz 2-core"
             /// iPad (4th)
            case .iPad3_4, .iPad3_5, .iPad3_6:
                return "1.4GHz 2-core"
             /// iPhone 5s, iPad mini 2, iPad mini 3
            case .iPhone6_1, .iPhone6_2, .iPad4_4, .iPad4_5, .iPad4_6, .iPad4_7, .iPad4_8, .iPad4_9:
                return "1.3GHz 2-core"
                /// iPad Air (1st)
            case .iPad4_1, .iPad4_2, .iPad4_3:
                return "1.4GHz 2-core"
             /// iPhone 6/6 Plus, iPod touch (6th), iPad mini 4
            case .iPhone7_1, .iPhone7_2, .iPod7_1, .iPad5_1, .iPad5_2:
                return "1.5GHz 2-core"
             /// iPad Air (2nd)
            case .iPad5_4, .iPad5_3:
                return "1.5GHz 3-core"
             /// iPhone 6s/6s Plus, iPhone SE (1st), iPad (5th)
            case .iPhone8_1, .iPhone8_2, .iPhone8_4, .iPad6_11, .iPad6_12:
                return "1.85GHz 2-core"
             /// iPad Pro (1st)
            case .iPad6_3, .iPad6_4, .iPad6_7, .iPad6_8:
                return "2.26GHz 2-core"
             /// iPhone 7/7 Plus, iPad (6th), iPod touch (7th), iPad (7th)
            case .iPhone9_1, .iPhone9_2, .iPhone9_3, .iPhone9_4, .iPad7_5, .iPad7_6, .iPod9_1, .iPad7_11, .iPad7_12:
                return "2.34GHz 4-core"
             /// iPad Pro (2nd)
            case .iPad7_1, .iPad7_2, .iPad7_3, .iPad7_4:
                return "2.36GHz 6-core"
             /// iPhone 8/8 Plus, iPhone X
            case .iPhone10_1, .iPhone10_2, .iPhone10_3, .iPhone10_4, .iPhone10_5, .iPhone10_6:
                return "2.39GHz 6-core"
             /// iPhone XS/XS Max, iPhone XR, iPad Air (3rd), iPad mini (5th), iPad (8th)
            case .iPhone11_2, .iPhone11_4, .iPhone11_6, .iPhone11_8, .iPad11_3, .iPad11_4, .iPad11_1, .iPad11_2, .iPad11_6, .iPad11_7:
                return "2.49 GHz 6-core"
             /// iPad Pro (3rd), iPad Pro (4th)
            case .iPad8_1, .iPad8_2, .iPad8_3, .iPad8_4, .iPad8_5, .iPad8_6, .iPad8_7, .iPad8_8, .iPad8_9, .iPad8_10, .iPad8_11, .iPad8_12:
                return "2.49GHz 8-core"
             /// iPhone 11, iPhone 11 Pro/11 Pro Max, iPhone SE (2nd)
            case .iPhone12_1, .iPhone12_3, .iPhone12_5, .iPhone12_8:
                return "2.65GHz 6-core"
             /// iPhone 12/12 mini, iPhone 12 Pro/12 Pro Max, iPad Air (4th)
            case .iPhone13_1, .iPhone13_2, .iPhone13_3, .iPhone13_4, .iPad13_1, .iPad13_2:
                return "2.99GHz 6-core"
            }
        }
        
        // GPU Information
        func gpu() -> String {
            switch self {
             /// Simulator
            case .i386, .x86_64, .arm64:
                return "N/A"
             /// iPhone, iPod touch (1st), iPhone 3G
            case .iPod1_1, .iPhone1_1, .iPhone1_2:
                return "PowerVR MBX Lite"
             /// iPod touch (2nd)
            case .iPod2_1:
                return "PowerVR MBX Lite"
             /// iPhone 3GS
            case .iPhone2_1:
                return "PowerVR SGX535"
             /// iPod touch (3rd)
            case .iPod3_1:
                return "PowerVR SGX535"
             /// iPhone 4, iPad (1st), iPod touch (4th)
            case .iPod4_1, .iPhone3_1, .iPhone3_2, .iPhone3_3, .iPad1_1:
                return "PowerVR SGX535"
             /// iPhone 4s, iPad 2, iPod touch (5th), iPad mini (1st)
            case .iPhone4_1, .iPod5_1, .iPad2_5, .iPad2_6, .iPad2_7, .iPad2_1, .iPad2_2, .iPad2_3, .iPad2_4:
                return "PowerVR SGX543MP2 2-core"
             /// iPad (3rd)
            case .iPad3_1, .iPad3_2, .iPad3_3:
                return "PowerVR SGX554MP4 4-core"
             /// iPhone 5, iPhone 5c
            case .iPhone5_1, .iPhone5_2, .iPhone5_3, .iPhone5_4:
                return "PowerVR SGX543MP3 3-core"
             /// iPad (4th)
            case .iPad3_4, .iPad3_5, .iPad3_6:
                return "PowerVR SGX554MP4 4-core"
             /// iPhone 5s, iPad mini 2, iPad mini 3, iPad Air (1st)
            case .iPhone6_1, .iPhone6_2, .iPad4_4, .iPad4_5, .iPad4_6, .iPad4_7, .iPad4_8, .iPad4_9, .iPad4_1, .iPad4_2, .iPad4_3:
                return "PowerVR G6430 4-core"
             /// iPhone 6/6 Plus, iPod touch (6th), iPad mini 4
            case .iPhone7_1, .iPhone7_2, .iPod7_1, .iPad5_1, .iPad5_2:
                return "PowerVR GXA6450 4-core"
             /// iPad Air (2nd)
            case .iPad5_4, .iPad5_3:
                return "PowerVR GXA6850 8-core"
             /// iPhone 6s/6s Plus, iPhone SE (1st), iPad (5th)
            case .iPhone8_1, .iPhone8_2, .iPhone8_4, .iPad6_11, .iPad6_12:
                return "PowerVR GT7600 6-core"
             /// iPad Pro (1st)
            case .iPad6_3, .iPad6_4, .iPad6_7, .iPad6_8:
                return "PowerVR GTA7850 12-core"
             /// iPhone 7/7 Plus, iPad (6th), iPod touch (7th), iPad (7th)
            case .iPhone9_1, .iPhone9_2, .iPhone9_3, .iPhone9_4, .iPad7_5, .iPad7_6, .iPod9_1, .iPad7_11, .iPad7_12:
                return "PowerVR GT7600 Plus 6-core"
             /// iPad Pro (2nd)
            case .iPad7_1, .iPad7_2, .iPad7_3, .iPad7_4:
                return "PowerVR GT7600 Plus 12-core"
             /// iPhone 8/8 Plus, iPhone X
            case .iPhone10_1, .iPhone10_2, .iPhone10_3, .iPhone10_4, .iPhone10_5, .iPhone10_6:
                return "3-core"
             /// iPhone XS/XS Max, iPhone XR, iPad Air (3rd), iPad mini (5th), iPad (8th)
            case .iPhone11_2, .iPhone11_4, .iPhone11_6, .iPhone11_8, .iPad11_3, .iPad11_4, .iPad11_1, .iPad11_2, .iPad11_6, .iPad11_7:
                return "4-core"
             /// iPad Pro (3rd)
            case .iPad8_1, .iPad8_2, .iPad8_3, .iPad8_4, .iPad8_5, .iPad8_6, .iPad8_7, .iPad8_8:
                return "7-core"
             /// iPad Pro (4th)
            case .iPad8_9, .iPad8_10, .iPad8_11, .iPad8_12:
                return "8-core"
             /// iPhone 11, iPhone 11 Pro/11 Pro Max, iPhone SE (2nd)
            case .iPhone12_1, .iPhone12_3, .iPhone12_5, .iPhone12_8:
                return "4-core"
             /// iPhone 12/12 mini, iPhone 12 Pro/12 Pro Max, iPad Air (4th)
            case .iPhone13_1, .iPhone13_2, .iPhone13_3, .iPhone13_4, .iPad13_1, .iPad13_2:
                return "4-core"
            }
        }
        
        // Neural Engine Information
        func neuralEngine() -> String {
            switch self {
            /// Simulator
            case .i386, .x86_64, .arm64:
                return "N/A"
            case .iPhone10_1, .iPhone10_2, .iPhone10_3, .iPhone10_4, .iPhone10_5, .iPhone10_6:
                return "2-core"
             /// iPhone XS/XS Max, iPhone XR, iPad Air (3rd), iPad mini (5th), iPad (8th)
            case .iPhone11_2, .iPhone11_4, .iPhone11_6, .iPhone11_8, .iPad11_3, .iPad11_4, .iPad11_1, .iPad11_2, .iPad11_6, .iPad11_7:
                return "8-core"
             /// iPad Pro (3rd), iPad Pro (4th)
            case .iPad8_1, .iPad8_2, .iPad8_3, .iPad8_4, .iPad8_5, .iPad8_6, .iPad8_7, .iPad8_8, .iPad8_9, .iPad8_10, .iPad8_11, .iPad8_12:
                return "8-core"
             /// iPhone 11, iPhone 11 Pro/11 Pro Max, iPhone SE (2nd)
            case .iPhone12_1, .iPhone12_3, .iPhone12_5, .iPhone12_8:
                return "8-core"
             /// iPhone 12/12 mini, iPhone 12 Pro/12 Pro Max, iPad Air (4th)
            case .iPhone13_1, .iPhone13_2, .iPhone13_3, .iPhone13_4, .iPad13_1, .iPad13_2:
                return "16-core"
             /// Other device
            default:
                return "None"
            }
        }
    }
}
