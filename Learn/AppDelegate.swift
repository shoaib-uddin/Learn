//
//  AppDelegate.swift
//  Learn
//
//  Created by Xtreme Hardware on 15/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit
import UserNotifications
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //
        
        print("received in foreground");
        completionHandler([.alert, .badge, .sound])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //
        
        let actionIdentifier = response.actionIdentifier;
        
        switch actionIdentifier {
        case UNNotificationDismissActionIdentifier: // Notification was dismissed by user
            // Do something
            completionHandler()
        case UNNotificationDefaultActionIdentifier: // App was opened from notification
            // Do something
            
            //let title = response.notification.request.content.userInfo["dictid"] as! String;
            let fact_id = response.notification.request.content.userInfo["factId"] as! String;
            if let _user = CoreDataHelper.returnUser(), let _id = _user.id{
            
                LearnottoApi.getSingleFacts(_id, fact_id, completion: { (success, fact) in
                    //
                    
                    
                    
                    if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as? MainVC {
                        if let window = self.window, let rootViewController = window.rootViewController {
                            var currentController = rootViewController
                            while let presentedController = currentController.presentedViewController {
                                currentController = presentedController
                            }
                            
                            controller.viewFromNotif = true;
                            controller.factFromNotif = fact;
                            currentController.present(controller, animated: true, completion: nil)
                        }
                    }
                })
            
            }
            
            
            

            
            
            
            completionHandler()
        default:
            completionHandler()
        }
        
    }
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        if(!UtilityHelper.getBoolKey(localv.isInitializeCategories)){
            CoreDataHelper.createRecords();
        }
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        
        print(CoreDataHelper.returnSettings());
        globalSettings = CoreDataHelper.returnSettings();
        
        
        let center = UNUserNotificationCenter.current();
        let options: UNAuthorizationOptions = [.alert, .sound];
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong")
            }
            
        }
        
        UNUserNotificationCenter.current().delegate = self;
        
        if #available(iOS 10, *) {
            
            //Notifications get posted to the function (delegate):  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void)"
            
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                
                guard error == nil else {
                    //Display Error.. Handle Error.. etc..
                    return
                }
                
                if granted {
                    //Do stuff here..
                    
                    //Register for RemoteNotifications. Your Remote Notifications can display alerts now :)
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
                }
                else {
                    //Handle user denying permissions..
                }
            }
            
            //Register for remote notifications.. If permission above is NOT granted, all notifications are delivered silently to AppDelegate.
            application.registerForRemoteNotifications()
        }
        else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        
        FirebaseApp.configure();
        
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //
        
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print(deviceTokenString);
        CoreDataHelper.updatePushToken(token: deviceTokenString) { (success) in
            print("token saved \(success)")
        }
        print()
        if let refreshedToken = InstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //
         print("i am not available - \(error)")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation])
        // Add any custom logic here.
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate ;
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Learn")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

