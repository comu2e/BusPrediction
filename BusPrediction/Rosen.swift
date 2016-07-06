//import RealmSwift
////Rosen用のRealm
//class Rosen:Object {
//    
//    struct each_rbo{
//    
//    var companyid : Int!
//    var dest : String!
//    var expl : String!
//    var name : String!
//    var stations : [String]!
//    
//    
//    /**
//     * Instantiate the instance using the passed dictionary values to set the properties values
//     */
//    init(fromDictionary dictionary: NSDictionary){
//    companyid = dictionary["companyid"] as? Int
//    dest = dictionary["dest"] as? String
//    expl = dictionary["expl"] as? String
//    name = dictionary["name"] as? String
//    stations = dictionary["stations"] as? [String]
//    }
//    
//    /**
//     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> NSDictionary
//    {
//    let dictionary = NSMutableDictionary()
//    if companyid != nil{
//    dictionary["companyid"] = companyid
//    }
//    if dest != nil{
//    dictionary["dest"] = dest
//    }
//    if expl != nil{
//    dictionary["expl"] = expl
//    }
//    if name != nil{
//    dictionary["name"] = name
//    }
//    if stations != nil{
//    dictionary["stations"] = stations
//    }
//    return dictionary
//    }
//    
//    }
//}