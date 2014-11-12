//
//  viewtest.swift
//  sliding-menu-test-with-container
//
//  Created by Kyle Smyth on 2014-11-10.
//  Copyright (c) 2014 Kyle Smyth. All rights reserved.
//

import UIKit

class TopLevelController: UIViewController, MenuDelegate {

    
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    var menuController : MenuTableViewController!
    var contentController : ContentController!
    var blueController : UIViewController!
    var redController : UIViewController!
    
    var menuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self,  action: Selector("containerViewTapped:"))
        overlayView.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer(target: self, action: Selector("containerPan:"))
        pan.minimumNumberOfTouches = 1
        overlayView.addGestureRecognizer(pan)
        
        blueController = self.storyboard?.instantiateViewControllerWithIdentifier("blue") as UIViewController
        redController = self.storyboard?.instantiateViewControllerWithIdentifier("red") as UIViewController
        contentController.initContent(blueController)
    }

    @IBAction func menuButtonTouchUpInside(sender: AnyObject) {
        if(menuOpen) {
            closeMenu()
        }
        else {
            openMenu()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "embeddedContent") {
            self.contentController = segue.destinationViewController as ContentController
        }
        else if (segue.identifier == "embeddedMenu") {
            self.menuController = segue.destinationViewController as MenuTableViewController
            menuController.setDelegate(self)
        }
    }
    
    func itemSelected(item: Int) {
        if(item == 0) {
            contentController.setContent(blueController)
        }
        else if(item == 1) {
            contentController.setContent(redController)
        }
        closeMenu()
    }


    func openMenu() {
            menuOpen = true
            let menuWidth = menuContainer.frame.width
        
            var main = contentContainer.frame
            main.origin.x = menuWidth
        
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.contentContainer.frame = main
                self.overlayView.frame = main
            })
    }
    
    func closeMenu() {
            menuOpen = false
            let menuWidth = menuContainer.frame.width
        
            var main = contentContainer.frame
            main.origin.x = 0
        
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.contentContainer.frame = main
                self.overlayView.frame = main
            })
    }
    
    func containerViewTapped(gesture: UIPanGestureRecognizer) {
        if(gesture.state == UIGestureRecognizerState.Ended && menuOpen) {
            closeMenu()
        }
    }
    
    func containerPan(gesture: UIPanGestureRecognizer) {
        let menuWidth = menuContainer.frame.width
        let location = gesture.locationInView(overlayView)
        let velocity = gesture.velocityInView(overlayView)
        let translation = gesture.translationInView(overlayView)
        var main = contentContainer.frame

        if (gesture.state == UIGestureRecognizerState.Changed) {
            if(!menuOpen) {
                if(translation.x > 0 && translation.x > abs(translation.y) && main.origin.x < menuWidth) {
                    main.origin.x = translation.x
                }
            }
            else {
                if(translation.x < 0 && abs(translation.x) > translation.y && main.origin.x > 0) {
                    main.origin.x = menuWidth + translation.x
                }
            }

            self.contentContainer.frame = main
            self.overlayView.frame = main
        }
        else if (gesture.state == UIGestureRecognizerState.Ended) {

            if(velocity.x > 0 && main.origin.x != 0 ) {
                openMenu()
            }
            else if(velocity.x < 0 && main.origin.x != menuWidth) {
                closeMenu()
            }
            else {
                closeMenu()
            }

        }
    }
}
