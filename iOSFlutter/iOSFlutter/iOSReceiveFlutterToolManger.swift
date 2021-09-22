//
//  iOSReceiveFlutterToolManger.swift
//  iOSFlutter
//
//  Created by 李桂盛 on 2021/9/10.
//

/**
 iOS端接受Flutter
 */

import Foundation
import Flutter
import FlutterPluginRegistrant

let channelName = "com.iOSFlutter"


class iOSReceiveFlutterToolManger {
    static func receiveFlutter() {
        let messageChannel = (UIApplication.shared.delegate as! AppDelegate).flutterMethodChannel
        messageChannel?.setMethodCallHandler({ call, result in
            if(call.method == "aaa") {
                if let message: String = call.arguments as? String {
                    print("接收到flutter信息" + message)
                }
            }
        })
    }
    
    
}
