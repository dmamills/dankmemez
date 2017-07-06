import UIKit

extension UIImageView {
    
    func openUrl(_ str : String) {
        
        let url = URL(string: str)
        let data = try? Data(contentsOf: url!)
        
        if data != nil {
            self.image = UIImage(data: data!)
        }
    }
}
