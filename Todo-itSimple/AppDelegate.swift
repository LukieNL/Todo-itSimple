//
//  AppDelegate.swift
//  Todo-itSimple
//
//  Created by Lucas van Leerdam on 20/05/2020.
//  Copyright © 2020 Lucas van Leerdam. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            //    print(Realm.Configuration.defaultConfiguration.fileURL)

            do {
                _ = try Realm()
                } catch {
                print("Error initialising new realm, \(error)")
            }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        //
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        //
    }


}

