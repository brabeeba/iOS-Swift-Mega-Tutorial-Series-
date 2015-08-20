//用以下的model做一個詢價條件
import UIKit
import Foundation

enum PayMethod: Int {
    case BothTerm=0, Prepaid, Collect
    static func stringToType (string: String) -> PayMethod? {
        switch string {
        case "Both term":
            return .BothTerm
        case "Prepaid":
            return .Prepaid
        case "Collect":
            return .Collect
        default:
            assert(true, "YOU SHOULD NOT SEE THIS")
            return nil
        }
    }
    func print () -> String {
        switch self {
        case .BothTerm:
            return "Both term"
        case .Prepaid:
            return "Prepaid"
        case .Collect:
            return "Collect"
        }
        
    }
    static func keys ()->[String]{
        return ["Both term", "Prepaid", "Collect"]
    }
}
enum RequestMethod: Int {
    case ExWork = 0, CF, FOB, DDU, DDP
    static func stringToType(string: String) -> RequestMethod? {
        switch string {
        case "Ex-Work":
            return .ExWork
        case "C&F":
            return .CF
        case "FOB":
            return .FOB
        case "DDU":
            return .DDU
        case "DDP":
            return .DDP
        default:
            assert(true, "YOU SHOULD NOT SEE THIS")
            return nil
        }
    }
    func print () -> String {
        switch self {
        case .ExWork:
            return "Ex-Work"
        case .CF:
            return "C&F"
        case .FOB:
            return "FOB"
        case .DDU:
            return "DDU"
        case .DDP:
            return "DDP"
        }
    }
    static func keys () -> [String] {
        return ["Ex-Work", "C&F", "FOB", "DDU", "DDP"]
    }
}

class PricingCondition {
    var payMethod:PayMethod?
    var requestMethod:RequestMethod?
    var departFee = false
    var arrivalFee = false
    let row = 4
    let section = 3
    let header = ["詢價條件", "付款條件", ""]
    let rowInSection = [5, 3, 2]
    
    func cellTitleInSection (section:Int) -> [String] {
        switch section {
        case 0:
            return RequestMethod.keys()
        case 1:
            return PayMethod.keys()
        case 2:
            return ["需報裝貨港費用", "需報卸貨港費用"]
        default:
            return []
        }
    }
    func printJSON () -> [String:AnyObject] {
        var result = [
            "term":"",
            "paymentTerm":"",
            "isPolCharge":"",
            "isPodCharge":""]
        if let json = requestMethod {
            result ["term"] = json.print()
        }
        if let json = payMethod {
            result ["paymentTerm"] = json.print()
        }
        if departFee {
            result ["isPolCharge"] = "Y"
        } else {
            result ["isPolCharge"] = "N"
        }
        if arrivalFee {
            result ["isPodCharge"] = "Y"
        } else {
            result ["isPodCharge"] = "N"
        }
        return result
    }
    func completed () -> Bool {
        if payMethod != nil && requestMethod != nil {
            return true
        } else {
            return false
        }
    }
    func empty () -> Bool {
        if payMethod == nil && requestMethod == nil {
            return true
        } else {
            return false
        }
    }
    func print () -> NSMutableAttributedString {
        var stringList = [String]()
        if requestMethod != nil {
            stringList.append("詢價條件: \(requestMethod!.print())")
        }
        if payMethod != nil {
            stringList.append("付款條件: \(payMethod!.print())")
        }
        var joiner = " "
        var stringList1 = [String]()
        let text = joiner.join(stringList)
        if text != "" {
            stringList1.append(text)
        }
        if departFee {
            stringList1.append("需報裝貨港費用")
        }
        if arrivalFee {
            stringList1.append("需報卸貨港費用")
        }
        var joiner1 = "\n"
        var result = NSMutableAttributedString(string: joiner1.join(stringList1))
        if stringList1.count > 1 {
            var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 15
            result.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, result.length))
        }
        return result
    }
}