//
//  MemeViewController.swift
//  FunFunFun
//
//  Created by Daniel Mills on 2017-07-01.
//  Copyright © 2017 Daniel Mills. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedMeme : DankMeme!
    var memes : [DankMeme] = []
    var currentIndex : Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentSize = imageView.frame.size;
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MemeViewController.onSwipe))
        leftSwipe.direction = .left
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MemeViewController.onSwipe))
        rightSwipe.direction = .right
        
        scrollView.addGestureRecognizer(leftSwipe)
        scrollView.addGestureRecognizer(rightSwipe)
        
        DankMemeService.getEm { dankness in
            self.memes = dankness
            DispatchQueue.main.async {
                self.updateMeme()
            }
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func onSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            currentIndex -= 1
            if(currentIndex < 0) {
                currentIndex = memes.count - 1
            }
        } else if sender.direction == .right {
            currentIndex += 1
            if(currentIndex == memes.count) {
                currentIndex = 0
            }
        }
        
        updateMeme()
    }
    
    func updateMeme() {
        selectedMeme = memes[currentIndex]
        imageView.openUrl(selectedMeme.source!.url)
        scrollView.zoomScale = 1.0
    }
    
    @IBAction func onShare(_ sender: Any) {
        
        let image = imageView.image!
        let activityViewController = UIActivityViewController(activityItems: [image as AnyObject], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
 
}
