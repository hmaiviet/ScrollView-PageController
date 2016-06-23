//
//  ViewScroll.swift
//  UIScrollView
//
//  Created by VietHung on 6/11/16.
//  Copyright © 2016 VietHung. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate{
    
    
    var pageImages: [String] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageController: UIPageControl!
    var photo = UIImageView()
    var first = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        pageImages = ["car1","car2","car3","car4"]
        pageController.currentPage = 0
        pageController.numberOfPages = pageImages.count
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
    }
    
    @IBAction func onChange(sender: AnyObject) {
        scrollView.contentOffset = CGPointMake(CGFloat(pageController.currentPage) * scrollView.frame.size.width, 0)
    }
    
    
    func addImageToScrollView()
    {
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), 0)
        for i in 0..<pageImages.count{
            print(scrollView.frame.size.width)
            let imgView = UIImageView(image: UIImage(named: pageImages[i] + ".jpg"))
            imgView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)
            imgView.contentMode = .ScaleToFill
            if(i==0){
                photo = imgView
            }
            self.scrollView.addSubview(imgView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if(!first){
        addImageToScrollView()
        first = true
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.size.width)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?{
        return photo
    }
    
    func tapImg(gesture: UITapGestureRecognizer){
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 1.5, center: position)
    }
    
    func doubleTapImg(gesture: UITapGestureRecognizer){
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 0.5, center: position)
    }
    
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint){
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        scrollView.zoomToRect(zoomRect, animated: true)
    }
}

    