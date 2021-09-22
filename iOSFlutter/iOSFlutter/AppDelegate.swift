//
//  AppDelegate.swift
//  iOSFlutter
//
//  Created by 李桂盛 on 2021/9/9.
//

import UIKit

import Flutter
import FlutterPluginRegistrant


@main
class AppDelegate: UIResponder, UIApplicationDelegate{

    let basicMessageChannelName = "com.basicMessageChannel.iOSFlutter"
    let methodChannelName = "com.methodChannelName.iOSFlutter"
    let eventChannelName = "com.eventChannelName.iOSFlutter"
    var window: UIWindow?
    var flutterBasicMessageChannel: FlutterBasicMessageChannel? // flutter <-> iOS
    var flutterMethodChannel: FlutterMethodChannel? //flutter <-> iOS
    var flutterEventChannel: FlutterEventChannel? // iOS -> flutter
    var flutterEngine: FlutterEngine?
    var flutterViewController: FlutterViewController?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        let nav = UINavigationController.init(rootViewController: ViewController())
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        flutterEngine = FlutterEngine(name: "my flutter engine")

        if let flutterEngine = flutterEngine {
            flutterEngine.run()
            GeneratedPluginRegistrant.register(with: flutterEngine )
            
            flutterViewController =
                FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
            
            ///BasicMessage channel
            flutterBasicMessageChannel = FlutterBasicMessageChannel.init(name: basicMessageChannelName, binaryMessenger: flutterViewController!.binaryMessenger)
            
            ///MethodChannel
            flutterMethodChannel = FlutterMethodChannel.init(name: channelName, binaryMessenger: flutterViewController!.binaryMessenger)
            ///
//            flutterMethodChannel?.setMethodCallHandler({ call, result in
//                if(call.method == "aaa") {
//                    if let message: String = call.arguments as? String {
//                        print("接收到flutter信息" + message)
//                    }
//                }
//            })
            
            ///EventChannel
            flutterEventChannel = FlutterEventChannel(name: eventChannelName, binaryMessenger: flutterViewController!.binaryMessenger)

        }
        return true
    }
    
}
