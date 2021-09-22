//
//  ViewController.swift
//  iOSFlutter
//
//  Created by 李桂盛 on 2021/9/9.
//

import UIKit
import Flutter

let messageDic = [
    "code": NSNumber.init(value: 200),
    "message": "iOS向Flutter传递消息"
] as [String : Any]

class ViewController: UIViewController, FlutterStreamHandler {

    var eventSink: FlutterEventSink?
    var label: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        
        if let flutterViewController = (UIApplication.shared.delegate as? AppDelegate)?.flutterViewController {
            flutterViewController.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
//            self.view.addSubview(flutterViewController.view)
            self.addChild(flutterViewController)
            self.view.addSubview(flutterViewController.view)
        }
        
        label = UILabel.init(frame: CGRect(x: 80.0, y: 80.0, width: 300, height: 140))
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.textColor = .red
        self.view.addSubview(label)
        
        
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.setTitle("通过MessageChannel向Flutter传递消息", for: UIControl.State.normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.frame = CGRect(x: 80.0, y: 300.0, width: 300.0, height: 40.0)
        button.backgroundColor = UIColor.blue
        self.view.addSubview(button)
        
        
        let button1 = UIButton(type:UIButton.ButtonType.custom)
        button1.addTarget(self, action: #selector(click1), for: .touchUpInside)
        button1.setTitle("通过MethodChannel向Flutter传递消息", for: UIControl.State.normal)
        button1.titleLabel?.font = .systemFont(ofSize: 13)
        button1.frame = CGRect(x: 80.0, y: 350.0, width: 300.0, height: 40.0)
        button1.backgroundColor = UIColor.blue
        self.view.addSubview(button1)
        
        
//        if let eventChannel = (UIApplication.shared.delegate as! AppDelegate).flutterEventChannel {
//            eventChannel.setStreamHandler(self)
//        }
        

        ///监听flutter传递的信息并回复
        /** 接受的格式
         {"method": "close", "content": "传递flutter数据给iOS", "code": 200}
         */
        if let basicMessageChannel = (UIApplication.shared.delegate as? AppDelegate)?.flutterBasicMessageChannel {
            basicMessageChannel.setMessageHandler { message, callBack in
                if let msg = message as? NSDictionary, let method = msg["method"] as? String {
                    if (method == "close") {
                        let messageNewDic = [
                            "code": NSNumber.init(value: 200),
                            "message": "iOS接收到Flutter传递消息并回复"
                        ] as [String : Any]
                        
                        self.label.text = self.dicValueString(msg as! [String : Any])
                        callBack(messageNewDic)
                    }
                }
            }
        }
        
        ///监听flutter传递的信息并回复
        /** 接受的格式
         {"method": "close", "content": "传递flutter数据给iOS", "code": 200}
         */
        if let methodChannel = (UIApplication.shared.delegate as? AppDelegate)?.flutterMethodChannel {
            methodChannel.setMethodCallHandler { call, callBack in
                if (call.method == "flutterTest") {
                    if let dic = call.arguments as? NSDictionary {
                        let messageNewDic = [
                            "code": NSNumber.init(value: 200),
                            "message": "iOS接收到Flutter传递消息并回复"
                        ] as [String : Any]

                        callBack(messageNewDic)
                        DispatchQueue.main.async {
                            self.label.text = self.dicValueString(dic as! [String : Any])
                        }

                    }
                }
            }
        }
    }
    
    @objc func click() {
        if let basicMessageChannel = (UIApplication.shared.delegate as? AppDelegate)?.flutterBasicMessageChannel {
            basicMessageChannel.sendMessage(messageDic) { reply in
                if let msg = reply as? NSDictionary {
                    self.label.text = self.dicValueString(msg as! [String : Any])
                }
            }
        }
    }
    
    @objc func click1() {
        if let methodChannel = (UIApplication.shared.delegate as? AppDelegate)?.flutterMethodChannel {
            methodChannel.invokeMethod("test", arguments: messageDic) { result in
//                if let msg = result as? NSDictionary {
//                    self.label.text = self.dicValueString(msg as! [String : Any])
//                }
                print("ZZZZ")
            }
        }
    }

    //FlutterStreamHandler
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
//        self.eventSink!("abc")
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    func dicValueString(_ dic:[String : Any]) -> String?{
         let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
         let str = String(data: data!, encoding: String.Encoding.utf8)
         return str
     }


}

