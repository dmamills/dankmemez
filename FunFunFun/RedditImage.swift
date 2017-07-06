import Foundation

class RedditImage {
    
    let width : Int
    let height : Int
    let url : String
    
    init(_ data : NSDictionary) {
        url = data.value(forKey: "url") as! String
        width = data.value(forKey: "width") as! Int
        height = data.value(forKey: "height") as! Int
    }
}
