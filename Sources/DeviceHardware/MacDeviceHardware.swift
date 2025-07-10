import Foundation

public class MacDeviceHardware: DeviceHardware {
    public static let deviceHardware = MacDeviceHardware()
    
    /// model name, such as MacBook Air (Retina, 13-inch, 2020)
    public var modelName: String {
        let modelName_ = getModelName() ?? "Unknown"
        return modelName_
    }
    /// processor name, such as Intel Core i5-5250U
    public var processorName: String {
        let processorName_ = getProcessorName() ?? "Unknown"
        return processorName_
    }
    /// CPU information, such as 1.60GHz 2-core
    public var cpu: String {
        let cpu_ = getCpu() ?? "Unknown"
        return cpu_
    }
    /// GPU information, such as Intel Iris Plus Graphics 655
    public var gpu: String {
        return getMetalGpu()
    }
    /// Neural Engine, such as 16-core or None
    public var neuralEngine: String {
        let neuralEngine_ = getNeuralEngine() ?? "Unknown"
        return neuralEngine_
    }
    
    /// Model Identifier, such as MacBookAir9,1
    public var modelIdentifier: String {
        let modelId = getModelIdentifier() ?? "Unknown"
        return modelId
    }
    /// number of (logical) processor, such as 4
    public var processorCount: Int {
        return ProcessInfo.processInfo.processorCount
    }
    /// physical memory size [B], such as 8589934592
    public var ram: Int {
        return getRAM()
    }
    /// physical memory size, such as 8GB
    public var ramString: String {
        return getRAMString()
    }
    
    // MARK: - Model Identifier
    enum ModelIdentifier: String {
        // MARK: MacBook Air
        /// MacBook Air (13-inch, M4, 2025)
        case Mac16_12 = "Mac16,12"
        /// MacBook Air (15-inch, M4, 2025)
        case Mac16_13 = "Mac16,13"
        /// MacBook Air (13-inch, M3, 2024)
        case Mac15_12 = "Mac15,12"
        /// MacBook Air (15-inch, M3, 2024)
        case Mac15_13 = "Mac15,13"
        /// MacBook Air (15-inch, M2, 2023)
        case Mac14_15 = "Mac14,15"
        /// MacBook Air (M2, 2022)
        case Mac14_2 = "Mac14,2"
        /// MacBook Air (M1, 2020)
        case MacBookAir10_1 = "MacBookAir10,1"
        /// MacBook Air (Retina, 13-inch, 2020)
        case MacBookAir9_1 = "MacBookAir9,1"
        /// MacBook Air (Retina, 13-inch, 2019)
        case MacBookAir8_2 = "MacBookAir8,2"
        /// MacBook Air (Retina, 13-inch, 2018)
        case MacBookAir8_1 = "MacBookAir8,1"
        /// MacBook Air (13-inch, 2017), MacBook Air (13-inch, Early 2015)
        case MacBookAir7_2 = "MacBookAir7,2"
        /// MacBook Air (11-inch, Early 2015)
        case MacBookAir7_1 = "MacBookAir7,1"
        /// MacBook Air (13-inch, Early 2014), MacBook Air (13-inch, Mid 2013)
        case MacBookAir6_2 = "MacBookAir6,2"
        /// MacBook Air (11-inch, Early 2014), MacBook Air (11-inch, Mid 2013)
        case MacBookAir6_1 = "MacBookAir6,1"

        // MARK: MacBook Pro
        /// MacBook Pro (14-inch, 2024) / M4
        case Mac16_1 = "Mac16,1"
        /// MacBook Pro (14-inch, 2024) / M4 Pro or M4 Max
        case Mac16_6 = "Mac16,6"
        case Mac16_8 = "Mac16,8"
        /// MacBook Pro (16-inch, 2024) / M4 Pro or M4 Max
        case Mac16_5 = "Mac16,5"
        case Mac16_7 = "Mac16,7"
        /// MacBook Pro (14-inch, Nov 2023) / M3
        case Mac15_3 = "Mac15,3"
        /// MacBook Pro (14-inch, Nov 2023) / M3 Pro or M3 Max
        case Mac15_6 = "Mac15,6"
        case Mac15_8 = "Mac15_8"
        case Mac15_10 = "Mac15,10"
        /// MacBook Pro (16-inch, Nov 2023) / M3 Pro or M3 Max
        case Mac15_7 = "Mac15_7"
        case Mac15_9 = "Mac15_9"
        case Mac15_11 = "Mac15_11"
        /// MacBook Pro (14-inch, 2023) / M2 Pro
        case Mac14_9 = "Mac14,9"
        /// MacBook Pro (14-inch, 2023) / M2 Max
        case Mac14_5 = "Mac14,5"
        /// MacBook Pro (16-inch, 2023) / M2 Pro
        case Mac14_10 = "Mac14,10"
        /// MacBook Pro (16-inch, 2023) / M2 Max
        case Mac14_6 = "Mac14,6"
        /// MacBook Pro (13-inch, M2, 2022)
        case Mac14_7 = "Mac14,7"
        /// MacBook Pro (16-inch, 2021) / M1 Pro
        case MacBookPro18_1 = "MacBookPro18,1"
        /// MacBook Pro (16-inch, 2021) / M1 Max
        case MacBookPro18_2 = "MacBookPro18,2"
        /// MacBook Pro (14-inch, 2021) / M1 Pro
        case MacBookPro18_3 = "MacBookPro18,3"
        /// MacBook Pro (14-inch, 2021) / M1 Max
        case MacBookPro18_4 = "MacBookPro18,4"
        /// MacBook Pro (13-inch, M1, 2020)
        case MacBookPro17_1 = "MacBookPro17,1"
        /// MacBook Pro (13-inch, 2020, Two Thunderbolt 3 ports)
        case MacBookPro16_3 = "MacBookPro16,3"
        /// MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)
        case MacBookPro16_2 = "MacBookPro16,2"
        /// MacBook Pro (16-inch, 2019)
        case MacBookPro16_4 = "MacBookPro16,4"
        case MacBookPro16_1 = "MacBookPro16,1"
        /// MacBook Pro (13-inch, 2019, Two Thunderbolt 3 ports
        case MacBookPro15_4 = "MacBookPro15,4"
        /// MacBook Pro (15-inch, 2019)
        case MacBookPro15_3 = "MacBookPro15,3"
        /// MacBook Pro (15-inch, 2019), MacBook Pro (15-inch, 2018)
        case MacBookPro15_1 = "MacBookPro15,1"
        /// MacBook Pro (13-inch, 2019, Four Thunderbolt 3 ports), MacBook Pro (13-inch, 2018, Four Thunderbolt 3 ports)
        case MacBookPro15_2 = "MacBookPro15,2"
        /// MacBook Pro (15-inch, 2017)
        case MacBookPro14_3 = "MacBookPro14,3"
        /// MacBook Pro (13-inch, 2017, Four Thunderbolt 3 ports)
        case MacBookPro14_2 = "MacBookPro14,2"
        /// MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)
        case MacBookPro14_1 = "MacBookPro14,1"
        /// MacBook Pro (15-inch, 2016)
        case MacBookPro13_3 = "MacBookPro13,3"
        /// MacBook Pro (13-inch, 2016, Four Thunderbolt 3 ports)
        case MacBookPro13_2 = "MacBookPro13,2"
        /// MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports)
        case MacBookPro13_1 = "MacBookPro13,1"
        /// MacBook Pro (Retina, 15-inch, Mid 2015)
        case MacBookPro11_5 = "MacBookPro11,5"
        case MacBookPro11_4 = "MacBookPro11,4"
        /// MacBook Pro (Retina, 13-inch, Early 2015)
        case MacBookPro12_1 = "MacBookPro12,1"
        /// MacBook Pro (Retina, 15-inch, Mid 2014), MacBook Pro (Retina, 15-inch, Late 2013)
        case MacBookPro11_3 = "MacBookPro11,3"
        case MacBookPro11_2 = "MacBookPro11,2"
        /// MacBook Pro (Retina, 13-inch, Mid 2014), MacBook Pro (Retina, 13-inch, Late 2013)
        case MacBookPro11_1 = "MacBookPro11,1"

        // MARK: MacBook (12-inch)
        /// MacBook (Retina, 12-inch, 2017)
        case MacBook10_1 = "MacBook10,1"
        /// MacBook (Retina, 12-inch, Early 2016)
        case MacBook9_1 = "MacBook9,1"
        /// MacBook (Retina, 12-inch, Early 2015)
        case MacBook8_1 = "MacBook8,1"

        // MARK: Mac Pro
        /// Mac Pro (2023)
        case Mac14_8 = "Mac14,8"
        /// Mac Pro (2019)
        case MacPro7_1 = "MacPro7,1"
        /// Mac Pro (Late 2013)
        case MacPro6_1 = "MacPro6,1"

        // MARK: Mac mini
        /// Mac mini (2024) / M4
        case Mac16_10 = "Mac16,10"
        /// Mac mini (2024) / M4 Pro
        case Mac16_15 = "Mac16,15"
        /// Mac mini (2023) / M2
        case Mac14_3 = "Mac14,3"
        /// Mac mini (2023) / M2 Pro
        case Mac14_12 = "Mac14,12"
        /// Mac mini (M1, 2020)
        case Macmini9_1 = "Macmini9,1"
        /// Mac mini (2018)
        case Macmini8_1 = "Macmini8,1"
        /// Mac mini (Late 2014)
        case Macmini7_1 = "Macmini7,1"

        // MARK: iMac Pro
        /// iMac Pro
        case iMacPro1_1 = "iMacPro1,1"

        // MARK: iMac
        /// iMac (24-inch, 2024, Two ports)
        case Mac16_2 = "Mac16,2"
        /// iMac (24-inch, 2024, Four ports)
        case Mac16_3 = "Mac16,3"
        /// iMac (24-inch, 2023, Two ports)
        case Mac15_4 = "Mac15,4"
        /// iMac (24-inch, 2023, Four ports)
        case Mac15_5 = "Mac15,5"
        /// iMac (24-inch, M1, 2021)
        case iMac21_1 = "iMac21,1"
        case iMac21_2 = "iMac21,2"
        /// iMac (Retina 5K, 27-inch, 2020)
        case iMac20_2 = "iMac20,2"
        case iMac20_1 = "iMac20,1"
        /// iMac (Retina 5K, 27-inch, 2019)
        case iMac19_1 = "iMac19,1"
        /// iMac (Retina 4K, 21.5-inch, 2019)
        case iMac19_2 = "iMac19,2"
        /// iMac (Retina 5K, 27-inch, 2017)
        case iMac18_3 = "iMac18,3"
        /// iMac (Retina 4K, 21.5-inch, 2017)
        case iMac18_2 = "iMac18,2"
        /// iMac (21.5-inch, 2017)
        case iMac18_1 = "iMac18,1"
        /// iMac (Retina 5K, 27-inch, Late 2015)
        case iMac17_1 = "iMac17,1"
        /// iMac (Retina 4K, 21.5-inch, Late 2015)
        case iMac16_2 = "iMac16,2"
        /// iMac (21.5-inch, Late 2015)
        case iMac16_1 = "iMac16,1"
        /// iMac (Retina 5K, 27-inch, Mid 2015), iMac (Retina 5K, 27-inch, Late 2014)
        case iMac15_1 = "iMac15,1"
        /// iMac (21.5-inch, Mid 2014)
        case iMac14_4 = "iMac14,4"
        /// iMac (27-inch, Late 2013)
        case iMac14_2 = "iMac14,2"
        /// iMac (21.5-inch, Late 2013)
        case iMac14_1 = "iMac14,1"
        /// iMac (27-inch, Late 2012)
        case iMac13_2 = "iMac13,2"
        /// iMac (21.5-inch, Late 2012)
        case iMac13_1 = "iMac13,1"
        
        // MARK: Mac Studio
        /// Mac Studio (2023) / M2 Max
        case Mac14_13 = "Mac14,13"
        /// Mac Studio (2023) / M2 Ultra
        case Mac14_14 = "Mac14,14"
        /// Mac Studio (2022) / M1 Max
        case Mac13_1 = "Mac13,1"
        /// Mac Studio (2022) / M1 Ultra
        case Mac13_2 = "Mac13,2"
        
        // TODO: Add model identifier when new Apple Silicon Series is announced.
        // Whether is Apple Silicon Mac or not
        func isAppleSiliconMac() -> Bool {
            switch self {
            case
                /// M1
                    .MacBookAir10_1, .MacBookPro17_1, .Macmini9_1, .iMac21_1, .iMac21_2,
                /// M1 Pro
                    .MacBookPro18_1, .MacBookPro18_3,
                /// M1 Max
                    .MacBookPro18_2, .MacBookPro18_4, .Mac13_1,
                /// M1 Ultra
                    .Mac13_2,
                /// M2
                    .Mac14_2, .Mac14_7, .Mac14_3, .Mac14_15,
                /// M2 Pro
                    .Mac14_9, .Mac14_10, .Mac14_12,
                /// M2 Max
                    .Mac14_5, .Mac14_6, .Mac14_13,
                /// M2 Ultra
                    .Mac14_8, .Mac14_14,
                /// M3, M3 Pro, M3 Max
                    .Mac15_3, .Mac15_4, .Mac15_5,
                    .Mac15_6, .Mac15_7, .Mac15_8,
                    .Mac15_9, .Mac15_10, .Mac15_11,
                    .Mac15_12, .Mac15_13,
                /// M4, M4 Pro, M4 Max
                    .Mac16_1, .Mac16_2, .Mac16_3, .Mac16_5, .Mac16_6, .Mac16_7, .Mac16_8, .Mac16_10, .Mac16_12, .Mac16_13, .Mac16_15
                :
                return true
            default:
                return false
            }
        }
       
       // TODO: Add core counts of Neural Engine when new Apple Silicon Series is announced.
       // Neural Engine Information
       func neuralEngine() -> String {
           switch self {
           /// M1
           case .MacBookAir10_1, .MacBookPro17_1, .Macmini9_1, .iMac21_1, .iMac21_2:
               return "16-core"
           /// M1 Pro
           case .MacBookPro18_1, .MacBookPro18_3:
               return "16-core"
           /// M1 Max
           case .MacBookPro18_2, .MacBookPro18_4, .Mac13_1:
               return "16-core"
           /// M1 Ultra
           case .Mac13_2:
               return "32-core"
           /// M2
           case .Mac14_2, .Mac14_7, .Mac14_15:
               return "16-core"
           /// M2 Pro
           case .Mac14_9, .Mac14_10, .Mac14_12:
               return "16-core"
           /// M2 Max
           case .Mac14_5, .Mac14_6, .Mac14_13:
               return "16-core"
           /// M2 Ultra
           case .Mac14_14, .Mac14_8:
               return "32-core"
           /// M3, M3 Pro, M3 Max
           case .Mac15_3, .Mac15_4, .Mac15_5, .Mac15_6, .Mac15_7, .Mac15_8, .Mac15_9, .Mac15_10, .Mac15_11, .Mac15_12, .Mac15_13:
               return "16-core"
           /// M4, M4 Pro, M4 Max
           case .Mac16_1, .Mac16_2, .Mac16_3, .Mac16_5, .Mac16_6, .Mac16_7, .Mac16_8, .Mac16_10, .Mac16_15:
               return "16-core"
           default:
               return "None"
           }
       }
       
       // model name
       func modelName() -> String {
           switch self {
           // MARK: MacBook Air
           case .Mac15_12:
               return "MacBook Air (13-inch, M3, 2024)"
           case .Mac15_13:
               return "MacBook Air (15-inch, M3, 2024)"
           case .Mac14_15:
               return "MacBook Air (15-inch, M2, 2023)"
           case .Mac14_2:
               return "MacBook Air (M2, 2022)"
           case .MacBookAir10_1:
               return "MacBook Air (M1, 2020)"
           case .MacBookAir9_1:
               return "MacBook Air (Retina, 13-inch, 2020)"
           case .MacBookAir8_2:
               return "MacBook Air (Retina, 13-inch, 2019)"
           case .MacBookAir8_1:
               return "MacBook Air (Retina, 13-inch, 2018)"
           case .MacBookAir7_2:
               /// Need some decision processing
               return "MacBook Air (13-inch, 2017) / (13-inch, Early 2015)"
           case .MacBookAir7_1:
               return "MacBook Air (11-inch, Early 2015)"
           case .MacBookAir6_2:
               /// Need some decision processing
               return "MacBook Air (13-inch, Early 2014) / (13-inch, Mid 2013)"
           case .MacBookAir6_1:
               /// Need some decision processing
               return "MacBook Air (11-inch, Early 2014) / (11-inch, Mid 2013)"
           
           // MARK: MacBook Pro
           case .Mac16_1, .Mac16_6, .Mac16_8:
               return "MacBook Pro (14-inch, 2024)"
           case .Mac16_7, .Mac16_5:
               return "MacBook Pro (16-inch, 2024)"
           case .Mac15_3, .Mac15_6, .Mac15_8, .Mac15_10:
               return "MacBook Pro (14-inch, Nov 2023)"
           case .Mac15_7, .Mac15_9, .Mac15_11:
               return "MacBook Pro (16-inch, Nov 2023)"
           case .Mac14_5, .Mac14_9:
               return "MacBook Pro (14-inch, 2023)"
           case .Mac14_6, .Mac14_10:
               return "MacBook Pro (16-inch, 2023)"
           case .Mac14_7:
               return "MacBook Pro (13-inch, M2, 2022)"
           case .MacBookPro18_1, .MacBookPro18_2:
               return "MacBook Pro (16-inch, 2021)"
           case .MacBookPro18_3, .MacBookPro18_4:
               return "MacBook Pro (14-inch, 2021)"
           case .MacBookPro17_1:
               return "MacBook Pro (13-inch, M1, 2020)"
           case .MacBookPro16_3:
               return "MacBook Pro (13-inch, 2020, Two Thunderbolt 3 ports)"
           case .MacBookPro16_2:
               return "MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)"
           case .MacBookPro16_1, .MacBookPro16_4:
               return "MacBook Pro (16-inch, 2019)"
           case .MacBookPro15_4:
               return "MacBook Pro (13-inch, 2019, Two Thunderbolt 3 ports)"
           case .MacBookPro15_3:
               return "MacBook Pro (15-inch, 2019)"
           case .MacBookPro15_1:
               /// Need some decision processing
               return "MacBook Pro (15-inch, 2019) / (15-inch, 2018)"
           case .MacBookPro15_2:
               /// Need some decision processing
               return "MacBook Pro (13-inch, 2019, Four Thunderbolt 3 ports) / (13-inch, 2018, Four Thunderbolt 3 ports)"
           case .MacBookPro14_3:
               return "MacBook Pro (15-inch, 2017)"
           case .MacBookPro14_2:
               return "MacBook Pro (13-inch, 2017, Four Thunderbolt 3 ports)"
           case .MacBookPro14_1:
               return "MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)"
           case .MacBookPro13_3:
               return "MacBook Pro (15-inch, 2016)"
           case .MacBookPro13_2:
               return "MacBook Pro (13-inch, 2016, Four Thunderbolt 3 ports)"
           case .MacBookPro13_1:
               return "MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports)"
           case .MacBookPro11_5, .MacBookPro11_4:
               return "MacBook Pro (Retina, 15-inch, Mid 2015)"
           case .MacBookPro12_1:
               return "MacBook Pro (Retina, 13-inch, Early 2015)"
           case .MacBookPro11_3, .MacBookPro11_2:
               /// Need some decision processing
               return "MacBook Pro (Retina, 15-inch, Mid 2014) / (Retina, 15-inch, Late 2013)"
           case .MacBookPro11_1:
               /// Need some decision processing
               return "MacBook Pro (Retina, 13-inch, Mid 2014) / (Retina, 13-inch, Late 2013)"
               
           // MARK: MacBook (12-inch)
           case .MacBook10_1:
               return "MacBook (Retina, 12-inch, 2017)"
           case .MacBook9_1:
               return "MacBook (Retina, 12-inch, Early 2016)"
           case .MacBook8_1:
               return "MacBook (Retina, 12-inch, Early 2015)"
               
           // MARK: Mac Pro
           case .Mac14_8:
               return "Mac Pro (2023)"
           case .MacPro7_1:
               return "Mac Pro (2019)"
           case .MacPro6_1:
               return "Mac Pro (Late 2013)"
               
           // MARK: Mac mini
           case .Mac16_15, .Mac16_10:
               return "Mac mini (2024)"
           case .Mac14_3, .Mac14_12:
               return "Mac mini (2023)"
           case .Macmini9_1:
               return "Mac mini (M1, 2020)"
           case .Macmini8_1:
               return "Mac mini (2018)"
           case .Macmini7_1:
               return "Mac mini (Late 2014)"
               
           // MARK: iMac Pro
           case .iMacPro1_1:
               return "iMac Pro (2017)"
               
           // MARK: iMac
           case .Mac16_2:
               return "iMac (24-inch, 2024, Two ports)"
           case .Mac16_3:
               return "iMac (24-inch, 2024, Four ports)"
           case .Mac15_5:
               return "iMac (24-inch, 2023, Four ports)"
           case .Mac15_4:
               return "iMac (24-inch, 2023, Two ports)"
           case .iMac21_1, .iMac21_2:
            return "iMac (24-inch, M1, 2021)"
           case .iMac20_2, .iMac20_1:
               return "iMac (Retina 5K, 27-inch, 2020)"
           case .iMac19_1:
               return "iMac (Retina 5K, 27-inch, 2019)"
           case .iMac19_2:
               return "iMac (Retina 4K, 21.5-inch, 2019)"
           case .iMac18_3:
               return "iMac (Retina 5K, 27-inch, 2017)"
           case .iMac18_2:
               return "iMac (Retina 4K, 21.5-inch, 2017)"
           case .iMac18_1:
               return "iMac (21.5-inch, 2017)"
           case .iMac17_1:
               return "iMac (Retina 5K, 27-inch, Late 2015)"
           case .iMac16_2:
               return "iMac (Retina 4K, 21.5-inch, Late 2015)"
           case .iMac16_1:
               return "iMac (21.5-inch, Late 2015)"
           case .iMac15_1:
               /// Need some decision processing
               return "iMac (Retina 5K, 27-inch, Mid 2015) / (Retina 5K, 27-inch, Late 2014)"
           case .iMac14_4:
               return "iMac (21.5-inch, Mid 2014)"
           case .iMac14_2:
               return "iMac (27-inch, Late 2013)"
           case .iMac14_1:
               return "iMac (21.5-inch, Late 2013)"
           case .iMac13_2:
               return "iMac (27-inch, Late 2012)"
           case .iMac13_1:
               return "iMac (21.5-inch, Late 2012)"
               
           // MARK: Mac Studio
           case .Mac14_13, .Mac14_14:
               return "Mac Studio (2023)"
           case .Mac13_1, .Mac13_2:
               return "Mac Studio (2022)"
           }
       }
    }
}

// MARK: - MacDeveiceHardware extensions
public extension MacDeviceHardware {
    /// get Model Identifier
    private func getModelIdentifier() -> String? {
        var size: Int = 0
        sysctlbyname("hw.model", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        if sysctlbyname("hw.model", &machine, &size, nil, 0) != 0 {
            return nil
        }
        let code: String = String(cString:machine)
        
        return code
    }
    
    // MARK: -
    private func getCpuBrandString() -> String? {
        var size: Int = 0
        sysctlbyname("machdep.cpu.brand_string", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        if sysctlbyname("machdep.cpu.brand_string", &machine, &size, nil, 0) != 0 {
            return nil
        }
        let cpuInfo: String = String(cString:machine)
       
        return cpuInfo
    }
    
    
    private func generateIntelCPUString(number: String, frequency: String) -> String {
        return "Intel(R) Core(TM) \(number) CPU @ \(frequency)"
    }
    
    /// get Mac model name
    private func getModelName() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        let cpuString = getCpuBrandString() ?? ""
        
        // same model identifier model
        switch modelId {
        case .MacBookAir7_2:
            switch cpuString {
            case generateIntelCPUString(number: "i5-5350U", frequency: "1.80GHz"):
                return "MacBook Air (13-inch, 2017)"
            case generateIntelCPUString(number: "i5-5250U", frequency: "1.60GHz"):
                return "MacBook Air (13-inch, Early 2015)"
            default:
                // Core i7-5650U or other CPU
                return "MacBook Air (13-inch, Early 2017)"
            }
        case .MacBookAir6_2:
            switch cpuString {
            case generateIntelCPUString(number: "i5-4260U", frequency: "1.40GHz"):
                return "MacBook Air (13-inch, Early 2014)"
            case generateIntelCPUString(number: "i5-4250U", frequency: "1.30GHz"):
                return "MacBook Air (13-inch, Mid 2013)"
            default:
                // Core i7-4650U or other CPU
                return "MacBook Air (13-inch, Early 2014)"
            }
        case .MacBookAir6_1:
            switch cpuString {
            case generateIntelCPUString(number: "i5-4260U", frequency: "1.40GHz"):
                return "MacBook Air (11-inch, Early 2014)"
            case generateIntelCPUString(number: "i5-4250U", frequency: "1.30GHz"):
                return "MacBook Air (11-inch, Mid 2013)"
            default:
                // Core i7-4650U or other CPU
                return "MacBook Air (11-inch, Early 2014)"
            }
        case .MacBookPro15_1:
            switch cpuString {
            case generateIntelCPUString(number: "i7-9750H", frequency: "2.60GHz"), generateIntelCPUString(number: "i9-9880H", frequency: "2.30GHz"), generateIntelCPUString(number: "i9-9980HK", frequency: "2.40GHz"):
                return "MacBook Pro (15-inch, 2019)"
            case generateIntelCPUString(number: "i7-8750H", frequency: "2.20GHz"), generateIntelCPUString(number: "i7-8850H", frequency: "2.60GHz"), generateIntelCPUString(number: "i9-8950HK", frequency: "2.90GHz"):
                return "MacBook Pro (15-inch, 2018)"
            default:
                return "MacBook Pro (15-inch, 2019)"
            }
        case .MacBookPro15_2:
            switch cpuString {
            case generateIntelCPUString(number: "i5-8279U", frequency: "2.40GHz"), generateIntelCPUString(number: "i7-8569U", frequency: "2.80GHz"):
                return "MacBook Pro (13-inch, 2019, Four Thunderbolt 3 ports)"
            case generateIntelCPUString(number: "i5-8259U", frequency: "2.30GHz"), generateIntelCPUString(number: "i7-8559U", frequency: "2.70GHz"):
                return "MacBook Pro (13-inch, 2018, Four Thunderbolt 3 ports)"
            default:
                return "MacBook Pro (13-inch, 2019, Four Thunderbolt 3 ports)"
            }
        case .MacBookPro11_3, .MacBookPro11_2:
            switch cpuString {
            case generateIntelCPUString(number: "i7-4770HQ", frequency: "2.20GHz"), generateIntelCPUString(number: "i7-4870HQ", frequency: "2.50GHz"), generateIntelCPUString(number: "i7-4980HQ", frequency: "2.80GHz"):
                return "MacBook Pro (Retina, 15-inch, Mid 2014)"
            case generateIntelCPUString(number: "i7-4750HQ", frequency: "2.00GHz"), generateIntelCPUString(number: "i7-4850HQ", frequency: "2.30GHz"), generateIntelCPUString(number: "i7-4960HQ", frequency: "2.60GHz"):
                return "MacBook Pro (Retina, 15-inch, Late 2013)"
            default:
                return "MacBook Pro (Retina, 15-inch, Mid 2014)"
            }
        case .MacBookPro11_1:
            switch cpuString {
            case generateIntelCPUString(number: "i5-4278U", frequency: "2.60GHz"), generateIntelCPUString(number: "i5-4308U", frequency: "2.80GHz"), generateIntelCPUString(number: "i7-4578U", frequency: "3.00GHz"):
                return "MacBook Pro (Retina, 13-inch, Mid 2014)"
            case generateIntelCPUString(number: "i5-4258U", frequency: "2.40GHz"), generateIntelCPUString(number: "i5-4288U", frequency: "2.60GHz"), generateIntelCPUString(number: "i7-4558U", frequency: "3.00GHz"):
                return "MacBook Pro (Retina, 13-inch, Late 2013)"
            default:
                return "MacBook Pro (Retina, 13-inch, Mid 2014)"
            }
        case .iMac15_1:
            switch cpuString {
            case generateIntelCPUString(number: "i5-4590", frequency: "3.30GHz"):
                return "iMac (Retina 5K, 27-inch, Mid 2015)"
            case generateIntelCPUString(number: "i5-4690", frequency: "3.50GHz"), generateIntelCPUString(number: "i7-4790K", frequency: "4.00GHz"):
                return "iMac (Retina 5K, 27-inch, Late 2014)"
            default:
                return "iMac (Retina 5K, 27-inch, Mid 2015)"
            }
        default:
            // other model
            return modelId.modelName()
        }
    }
    
    // MARK: -
    /// get processor name
    private func getProcessorName() -> String? {
        guard let cpuInfo = getCpuBrandString() else {
            return nil
        }
        
        let cpuInfoArray = cpuInfo.split(separator: "@")
        let cpuBrand = cpuInfoArray[0]
            .replacingOccurrences(of: "CPU", with: "")
            .replacingOccurrences(of: "(R)", with: "")
            .replacingOccurrences(of: "(TM)", with: "")
            .trimmingCharacters(in: .whitespaces)
        
        return cpuBrand
    }
    
    /// get the number of physical core
    private func getPhysicalCore() -> Int? {
        var core: Int32 = 0
        var size = MemoryLayout<Int32>.size
        
        if sysctlbyname("hw.physicalcpu", &core, &size, nil, 0) != 0 {
            return nil
        }
        
        return Int(core)
    }
    
    /// get CPU info
    private func getCpu() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        // TODO: Add CPU frequency when new Apple Silicon Series is announced.
        // MARK: Apple silicon or not
        if modelId.isAppleSiliconMac() {
            guard let core = getPhysicalCore() else {
                return nil
            }
            
            switch modelId {
            /// M1 family
            case .MacBookAir10_1, .MacBookPro17_1, .Macmini9_1, .iMac21_1, .iMac21_2,
                    .MacBookPro18_1, .MacBookPro18_2, .MacBookPro18_3, .MacBookPro18_4, .Mac13_1, .Mac13_2:
                return "3.2GHz \(core)-core"
            /// M2 family
            case .Mac14_2, .Mac14_7, .Mac14_3, .Mac14_15, .Mac14_5, .Mac14_6, .Mac14_9, .Mac14_10, .Mac14_12, .Mac14_13, .Mac14_14, .Mac14_8:
                return "3.49GHz \(core)-core"
            /// M3 family
            case .Mac15_3, .Mac15_4, .Mac15_5, .Mac15_6, .Mac15_7, .Mac15_8, .Mac15_9, .Mac15_10, .Mac15_11, .Mac15_12, .Mac15_13:
                return "4.05GHz \(core)-core"
            default:
                return nil
            }
        } else {
            // Intel CPU Information
            guard let cpuInfo = getCpuBrandString() else {
                return nil
            }
            
            let cpuInfoArray = cpuInfo.split(separator: "@")
            let cpuFrequency = cpuInfoArray[1].trimmingCharacters(in: .whitespaces)
            
            guard let core = getPhysicalCore() else {
                return nil
            }
            
            return "\(cpuFrequency) \(core)-core"
        }
    }
    
    /// get neural engine info
    private func getNeuralEngine() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        return modelId.neuralEngine()
    }
}
