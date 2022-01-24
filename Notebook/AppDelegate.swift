//
//  AppDelegate.swift
//  Notebook
//
//  Created by Naw on 20/01/2022.
//

import UIKit


@UIApplicationMain
class appDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application:UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        UINavigationBar.appearance().tintColor = UIColor.blue
        UINavigationBar.appearance().backgroundColor = UIColor.lightGray
        UINavigationBar.appearance().largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        return true
    }
}
