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
    
    // MARK: -
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
    
    private func getModelName() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        // same model identifier model
        switch modelId {
        case .MacBookAir7_2:
            return ""
        case .MacBookAir6_2:
            return ""
        case .MacBookAir6_1:
            return ""
        case .MacBookPro15_1:
            return ""
        case .MacBookPro15_2:
            return ""
        case .MacBookPro11_3, .MacBookPro11_2:
            return ""
        case .MacBookPro11_1:
            return ""
        case .iMac15_1:
            return ""
        default:
            // other model
            return modelId.modelName()
        }
    }
    
    // MARK: -
    enum ModelIdentifier: String {
       // MARK: MacBook Air
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
       /// Mac Pro (2019)
       case MacPro7_1 = "MacPro7,1"
       /// Mac Pro (Late 2013)
       case MacPro6_1 = "MacPro6,1"
       
       // MARK: Mac mini
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
       
       // Neural Engine Information
       func neuralEngine() -> String {
           switch self {
           case .MacBookAir10_1, .MacBookPro17_1, .Macmini9_1:
               return "16-core"
           default:
               return "None"
           }
       }
       
       // model name
       func modelName() -> String {
           switch self {
           // MARK: MacBook Air
           case .MacBookAir10_1:
               return "MacBook Air (M1, 2020)"
           case .MacBookAir9_1:
               return "MacBook Air (Retina, 13-inch, 2020)"
           case .MacBookAir8_2:
               return "MacBook Air (Retina, 13-inch, 2019)"
           case .MacBookAir8_1:
               return "MacBook Air (Retina, 13-inch, 2018)"
           case .MacBookAir7_2:
               /// 何かしらの判別処理が必要
               return "MacBook Air (13-inch, 2017) / (13-inch, Early 2015)"
           case .MacBookAir7_1:
               return "MacBook Air (11-inch, Early 2015)"
           case .MacBookAir6_2:
               /// 何かしらの判定処理が必要
               return "MacBook Air (13-inch, Early 2014) / (13-inch, Mid 2013)"
           case .MacBookAir6_1:
               /// 何かしらの判定処理が必要
               return "MacBook Air (11-inch, Early 2014) / (11-inch, Mid 2013)"
           
           // MARK: MacBook Pro
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
               /// 何らかの判定処理が必要
               return "MacBook Pro (15-inch, 2019) / (15-inch, 2018)"
           case .MacBookPro15_2:
               /// 何らかの判定処理が必要
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
               /// 何かしらの判定処理が必要
               return "MacBook Pro (Retina, 15-inch, Mid 2014) / (Retina, 15-inch, Late 2013)"
           case .MacBookPro11_1:
               /// 何かしらの判定処理が必要
               return "MacBook Pro (Retina, 13-inch, Mid 2014) / (Retina, 13-inch, Late 2013)"
               
           // MARK: MacBook (12-inch)
           case .MacBook10_1:
               return "MacBook (Retina, 12-inch, 2017)"
           case .MacBook9_1:
               return "MacBook (Retina, 12-inch, Early 2016)"
           case .MacBook8_1:
               return "MacBook (Retina, 12-inch, Early 2015)"
               
           // MARK: Mac Pro
           case .MacPro7_1:
               return "Mac Pro (2019)"
           case .MacPro6_1:
               return "Mac Pro (Late 2013)"
               
           // MARK: Mac mini
           case .Macmini9_1:
               return "Mac mini (M1, 2020)"
           case .Macmini8_1:
               return "Mac mini (2018)"
           case .Macmini7_1:
               return "Mac mini (Late 2014)"
               
           // MARK: iMac Pro
           case .iMacPro1_1:
               return "iMac Pro"
               
           // MARK: iMac
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
               /// 何らかの判定処理が必要
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
           }
       }
    }
}
