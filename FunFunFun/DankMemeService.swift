import Foundation
import Alamofire

class DankMemeService {
    
    typealias onDownload = ([DankMeme]) -> ()
    static let DANK_URL : String = "https://reddit.com/r/dankmemes.json"
    
    static func getEm(_ completed: @escaping onDownload) {
        var dankness : [DankMeme] = []
        
        Alamofire.request(DANK_URL).responseJSON { response in
            if let result = response.result.value {
                let JSON = ((result as! NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey:"children") as! Array<NSDictionary>
                
                for child in JSON {
                    let postData = child.value(forKey: "data") as! NSDictionary
                    dankness.append(DankMeme(postData))
                }
                
                completed(dankness)
            }
        }
    }
}
