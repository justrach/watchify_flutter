import Flutter
import UIKit
import WatchConnectivity

public class WatchifyMe: NSObject, FlutterPlugin, WCSessionDelegate {
    //https://medium.com/flutter/flutter-platform-channels-ce7f540a104e
    let channel: FlutterMethodChannel
    let watchConnectivitySession: WCSession?
    // let textField: UITextField?
    
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
        //        self.textField = UITextField() //mapping SwiftUI to Flutter
        
        if WCSession.isSupported() {
            watchConnectivitySession = WCSession.default
        } else {
            watchConnectivitySession = nil
        }
        
        super.init()
        
        watchConnectivitySession?.delegate = self
        watchConnectivitySession?.activate()
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "watchify_flutter", binaryMessenger: registrar.messenger())
        let instance = WatchifyMe(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        //        https://stackoverflow.com/questions/50078947/how-to-implement-a-flutterplugins-method-handler-in-swift
        //thanks to Renato for the destructuring
        switch call.method {
            //are these items supported by the mainFunction?
        case "isSupported":
            result(WCSession.isSupported())
        case "isPaired":
            result(watchConnectivitySession?.isPaired ?? false)
        case "isReachable":
            result(watchConnectivitySession?.isReachable ?? false)
        case "applicationContext":
            result(watchConnectivitySession?.applicationContext ?? [:])
        case "receivedApplicationContexts":
            result([watchConnectivitySession?.receivedApplicationContext ?? [:]]) //return String[:any]
            //todo-filetransfer
            // case "fileTransfer":
            //   session?.fileTransfer
        case "sendMessage":
            watchConnectivitySession?.sendMessage(call.arguments as! [String: Any], replyHandler: nil)
            result(nil)
        case "updateApplicationContext":
            do {
                try watchConnectivitySession?.updateApplicationContext(call.arguments as! [String: Any])
                result(nil)
            } catch {
                result(FlutterError(code: "Error updating application context", message: error.localizedDescription, details: nil))
            }
            //        case "createTextField":
            //            result()
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    
    //https://stackoverflow.com/questions/48911925/type-watchmanager-does-not-conform-to-protocol-wcsessiondelegate
    // app crashed a few times with swift compiler error so do try this if it fails
    //Swift Compiler Error (Xcode): Type 'WatchHandler' does not conform to protocol 'WCSessionDelegate'
    
    //methods below are added https://stackoverflow.com/questions/54865498/type-appdelegate-does-not-conform-to-protocol-wcsessiondelegate-calls-infini
    
    public func sessionDidBecomeInactive(_ session: WCSession) {}
    
    public func sessionDidDeactivate(_ session: WCSession) {}
    
    public func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        channel.invokeMethod("didReceiveMessage", arguments: message)
    }
    
    public func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        channel.invokeMethod("didReceiveApplicationContext", arguments: applicationContext)
    }
    
    
    
}
