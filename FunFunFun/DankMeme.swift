import Foundation
import UIKit

class DankMeme {
    
    let title : String
    let url : String
    let permalink : String
    var source : RedditImage? = nil
    var thumbnails : [RedditImage] = []
    var sourceImage : UIImage?
    
    init(_ json : NSDictionary) {
        title = json.value(forKey: "title") as! String
        url = json.value(forKey: "url") as! String
        permalink = json.value(forKey: "permalink") as! String
        
        let previews = json.value(forKey: "preview") as! NSDictionary
        let images = previews.value(forKey: "images") as! NSArray
        setThumbnails(images[0] as! NSDictionary)
    }
    
    private func setThumbnails(_ json : NSDictionary) {
        let s = json.value(forKey: "source") as! NSDictionary
        let resolutions = json.value(forKey: "resolutions") as! NSArray
        
        self.source = RedditImage(s)
        for r in resolutions {
            thumbnails.append(RedditImage(r as! NSDictionary))
        }
    }

}
