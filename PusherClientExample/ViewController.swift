//
//  ViewController.swift
//  PusherClientExample
//
//  Created by Daniel Que on 2016-10-17.
//
//

import UIKit
import PusherSwift

class ViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    let pusher = Pusher(
        key: "app_key",
        options: PusherClientOptions(
            authMethod: .endpoint(authEndpoint: "http://10.88.111.2:3000/v1/auth/pusher")  // local ip address
        )
    )

    // Uses Slanger as backend.
    // let pusher = Pusher(
    //     key: "test123",
    //     options: PusherClientOptions(
    //         authMethod: .endpoint(authEndpoint: "http://10.88.111.2:3000/v1/auth/pusher"),
    //         attemptToReturnJSONObject: false,
    //         autoReconnect: true,
    //         host: .host("54.164.144.11"),  // slanger server
    //         port: 8080,
    //         encrypted: false))

    var channel: PusherChannel?

    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextView.layer.cornerRadius = 5
        inputTextView.layer.borderColor = UIColor.black.cgColor
        inputTextView.layer.borderWidth = 1

        pusher.connect()
        self.channel = pusher.subscribe("private-test_channel")
        let _ = self.channel!.bind(eventName: "client-my_event", callback: { (data: Any?) -> Void in
            print("Received event.")
            if let data = data as? [String : AnyObject] {
                let message = data["message"] as? String
                self.messageTextView.text = message
            } else if let message = data as? String {
                self.messageTextView.text = message
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sendButtonTapped(_ sender: UIButton) {
        if self.channel != nil {
            print("Sending message: \(inputTextView.text!).")
            self.channel!.trigger(eventName: "client-my_event", data: [ "message": inputTextView.text! ]);
        }
    }

}

