//
//  AppDelegate.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 9/20/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(rgb:0x0062b5)], for: UIControlState())
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .selected)
        
        self.initDataHardcoded()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func initDataHardcoded(){
        let jsonData = "[{\"imageName\":\"deranch\",\"title\":\"De\'Ranch Lembang\",\"subTitle\":\"Tempat Kukudaan\",\"description\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum iaculis vulputate odio vel mattis. Nulla pretium eleifend enim non pellentesque. Aenean venenatis est eu mi ultrices ultricies. In hendrerit turpis quis nunc mollis pellentesque eu nec dui. Nulla vulputate felis lacus. Cras et leo non felis commodo volutpat tempus ut arcu. Proin vel ligula dignissim justo rutrum aliquet non a ex. Vivamus viverra, mi et varius elementum, quam magna porttitor lacus, ac ornare felis lacus et metus. Sed quis ante dui. Suspendisse dapibus pulvinar aliquam. Nullam nec nunc faucibus, gravida purus sed, blandit eros. Sed id porta orci. Aliquam at purus vitae arcu luctus pulvinar.\\n\\nVestibulum a massa molestie purus lobortis tempor. In cursus lobortis augue, ac tempus diam congue auctor. Phasellus id lorem eget mauris rutrum sagittis sit amet sit amet urna. Integer tempor malesuada eros, vitae pulvinar sapien vehicula accumsan. Aliquam imperdiet turpis id diam sodales tempus. Donec tellus ex, fringilla non ornare sit amet, lacinia id nibh. Proin id purus ultrices, blandit nisi mollis, finibus arcu. Ut justo lorem, porta vitae maximus vitae, vehicula in est.\\n\\nNullam vulputate metus sed varius maximus. Aliquam posuere, sapien ac pulvinar ultrices, dui quam convallis velit, et ullamcorper lacus nisl ac risus. In nec turpis sodales, commodo urna vel, ultricies erat. Cras eget erat vestibulum metus rhoncus iaculis. Quisque quis ex libero. Pellentesque egestas malesuada lectus eget ornare. Cras id vestibulum mauris. Pellentesque tempus eros id pellentesque posuere. Sed venenatis, orci ut fermentum sollicitudin, est urna tempus ex, quis aliquet magna purus quis augue.\\n\\nInteger faucibus sagittis neque, at egestas diam porta non. Aenean fermentum eget nunc vel lacinia. Sed id fringilla enim. Fusce eu nisi iaculis, tempor neque sit amet, commodo leo. Morbi metus mi, rutrum quis eleifend et, egestas eu ligula. Duis id urna quam. Praesent elementum ligula magna, ac bibendum neque condimentum gravida. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed auctor, eros eget consequat blandit, odio velit fermentum justo, non venenatis purus ligula vel nisl.\\n\\nMaecenas blandit, lectus et imperdiet dictum, ipsum justo mattis nunc, sit amet varius justo nulla ut nisl. Sed vitae bibendum enim. Morbi leo lectus, lacinia et pharetra sed, viverra vel elit. Aenean vestibulum tellus at ante elementum ultricies. Aenean pulvinar vitae lacus non volutpat. Mauris ac convallis dolor. Quisque pellentesque purus rhoncus orci gravida lobortis at ac ante. Interdum et malesuada fames ac ante ipsum primis in faucibus. Quisque accumsan vestibulum tincidunt. Phasellus vitae commodo metus, vitae ornare dolor. Mauris a mauris in nulla rutrum facilisis. Duis justo sem, imperdiet a sem at, tincidunt gravida dolor. Nam mollis diam erat, eu elementum arcu ullamcorper at. Nulla facilisi.\",\"latitude\":-6.8156823,\"longitude\":107.6246848},{\"imageName\":\"farmhouse\",\"title\":\"Farmhouse Lembang\",\"subTitle\":\"Tempat ulin budak\",\"description\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum iaculis vulputate odio vel mattis. Nulla pretium eleifend enim non pellentesque. Aenean venenatis est eu mi ultrices ultricies. In hendrerit turpis quis nunc mollis pellentesque eu nec dui. Nulla vulputate felis lacus. Cras et leo non felis commodo volutpat tempus ut arcu. Proin vel ligula dignissim justo rutrum aliquet non a ex. Vivamus viverra, mi et varius elementum, quam magna porttitor lacus, ac ornare felis lacus et metus. Sed quis ante dui. Suspendisse dapibus pulvinar aliquam. Nullam nec nunc faucibus, gravida purus sed, blandit eros. Sed id porta orci. Aliquam at purus vitae arcu luctus pulvinar.\\n\\nVestibulum a massa molestie purus lobortis tempor. In cursus lobortis augue, ac tempus diam congue auctor. Phasellus id lorem eget mauris rutrum sagittis sit amet sit amet urna. Integer tempor malesuada eros, vitae pulvinar sapien vehicula accumsan. Aliquam imperdiet turpis id diam sodales tempus. Donec tellus ex, fringilla non ornare sit amet, lacinia id nibh. Proin id purus ultrices, blandit nisi mollis, finibus arcu. Ut justo lorem, porta vitae maximus vitae, vehicula in est.\\n\\nNullam vulputate metus sed varius maximus. Aliquam posuere, sapien ac pulvinar ultrices, dui quam convallis velit, et ullamcorper lacus nisl ac risus. In nec turpis sodales, commodo urna vel, ultricies erat. Cras eget erat vestibulum metus rhoncus iaculis. Quisque quis ex libero. Pellentesque egestas malesuada lectus eget ornare. Cras id vestibulum mauris. Pellentesque tempus eros id pellentesque posuere. Sed venenatis, orci ut fermentum sollicitudin, est urna tempus ex, quis aliquet magna purus quis augue.\\n\\nInteger faucibus sagittis neque, at egestas diam porta non. Aenean fermentum eget nunc vel lacinia. Sed id fringilla enim. Fusce eu nisi iaculis, tempor neque sit amet, commodo leo. Morbi metus mi, rutrum quis eleifend et, egestas eu ligula. Duis id urna quam. Praesent elementum ligula magna, ac bibendum neque condimentum gravida. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed auctor, eros eget consequat blandit, odio velit fermentum justo, non venenatis purus ligula vel nisl.\\n\\nMaecenas blandit, lectus et imperdiet dictum, ipsum justo mattis nunc, sit amet varius justo nulla ut nisl. Sed vitae bibendum enim. Morbi leo lectus, lacinia et pharetra sed, viverra vel elit. Aenean vestibulum tellus at ante elementum ultricies. Aenean pulvinar vitae lacus non volutpat. Mauris ac convallis dolor. Quisque pellentesque purus rhoncus orci gravida lobortis at ac ante. Interdum et malesuada fames ac ante ipsum primis in faucibus. Quisque accumsan vestibulum tincidunt. Phasellus vitae commodo metus, vitae ornare dolor. Mauris a mauris in nulla rutrum facilisis. Duis justo sem, imperdiet a sem at, tincidunt gravida dolor. Nam mollis diam erat, eu elementum arcu ullamcorper at. Nulla facilisi.\",\"latitude\":-6.8326386,\"longitude\":107.6036865},{\"imageName\":\"karang-setra\",\"title\":\"Karang Setra\",\"subTitle\":\"Tempat ngojay\",\"description\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum iaculis vulputate odio vel mattis. Nulla pretium eleifend enim non pellentesque. Aenean venenatis est eu mi ultrices ultricies. In hendrerit turpis quis nunc mollis pellentesque eu nec dui. Nulla vulputate felis lacus. Cras et leo non felis commodo volutpat tempus ut arcu. Proin vel ligula dignissim justo rutrum aliquet non a ex. Vivamus viverra, mi et varius elementum, quam magna porttitor lacus, ac ornare felis lacus et metus. Sed quis ante dui. Suspendisse dapibus pulvinar aliquam. Nullam nec nunc faucibus, gravida purus sed, blandit eros. Sed id porta orci. Aliquam at purus vitae arcu luctus pulvinar.\\n\\nVestibulum a massa molestie purus lobortis tempor. In cursus lobortis augue, ac tempus diam congue auctor. Phasellus id lorem eget mauris rutrum sagittis sit amet sit amet urna. Integer tempor malesuada eros, vitae pulvinar sapien vehicula accumsan. Aliquam imperdiet turpis id diam sodales tempus. Donec tellus ex, fringilla non ornare sit amet, lacinia id nibh. Proin id purus ultrices, blandit nisi mollis, finibus arcu. Ut justo lorem, porta vitae maximus vitae, vehicula in est.\\n\\nNullam vulputate metus sed varius maximus. Aliquam posuere, sapien ac pulvinar ultrices, dui quam convallis velit, et ullamcorper lacus nisl ac risus. In nec turpis sodales, commodo urna vel, ultricies erat. Cras eget erat vestibulum metus rhoncus iaculis. Quisque quis ex libero. Pellentesque egestas malesuada lectus eget ornare. Cras id vestibulum mauris. Pellentesque tempus eros id pellentesque posuere. Sed venenatis, orci ut fermentum sollicitudin, est urna tempus ex, quis aliquet magna purus quis augue.\\n\\nInteger faucibus sagittis neque, at egestas diam porta non. Aenean fermentum eget nunc vel lacinia. Sed id fringilla enim. Fusce eu nisi iaculis, tempor neque sit amet, commodo leo. Morbi metus mi, rutrum quis eleifend et, egestas eu ligula. Duis id urna quam. Praesent elementum ligula magna, ac bibendum neque condimentum gravida. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed auctor, eros eget consequat blandit, odio velit fermentum justo, non venenatis purus ligula vel nisl.\\n\\nMaecenas blandit, lectus et imperdiet dictum, ipsum justo mattis nunc, sit amet varius justo nulla ut nisl. Sed vitae bibendum enim. Morbi leo lectus, lacinia et pharetra sed, viverra vel elit. Aenean vestibulum tellus at ante elementum ultricies. Aenean pulvinar vitae lacus non volutpat. Mauris ac convallis dolor. Quisque pellentesque purus rhoncus orci gravida lobortis at ac ante. Interdum et malesuada fames ac ante ipsum primis in faucibus. Quisque accumsan vestibulum tincidunt. Phasellus vitae commodo metus, vitae ornare dolor. Mauris a mauris in nulla rutrum facilisis. Duis justo sem, imperdiet a sem at, tincidunt gravida dolor. Nam mollis diam erat, eu elementum arcu ullamcorper at. Nulla facilisi.\",\"latitude\":-6.8832515,\"longitude\":107.5934003}]"
        
        let data = jsonData.data(using: String.Encoding.utf8)
        let jsonArr: NSArray?
        do {
            jsonArr = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray
        } catch _ {
            jsonArr = nil
        }
        
        let listDestination : NSMutableArray = []
        for json in jsonArr! {
            
            let destination = Destination(data:json as! NSDictionary)
            listDestination.add(destination)
        }
        
        Data.setObjectData(listDestination, key: kListDestination)

    }

}

