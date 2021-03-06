//
//  ChatViewController.swift
//  xschat
//
//  Created by Ronnie Paskin on 18/04/16.
//  Copyright © 2018 Megaputz. All rights reserved.
//

import Alamofire
import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var chat:Chat = Chat(chat_id: nil, first_name: nil, last_name: nil, username: nil, messages: [])

//    var chatMessages:[(String, String)] = [] // = [] [("rpaskin","oi"), ("jsilva","tudo bom?"), ("rpaskin", "tudo"), ("ssalgado", "alguém quer um doce?")]

    var cores:[UIColor] = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.15), .white]

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var inputText: UITextField!

    // Return pressed inside input text
    @IBAction func inputTextReturnPressed(_ sender: UITextField) {
        sendToServer()
    }
    
    // Pressed "Send" key
    @IBAction func enviarTouched(_ sender: UIButton) {
        sendToServer()
    }

    func sendToServer() {
        if inputText.hasText {
            let name = "rpaskin"
            let message = inputText.text!
            
            chat.messages.insert((name, message), at: 0) // adds to top of list
            // chat.messages.append((name, message))     // adds to end of list (NOT)
            chatTableView.reloadData()
            
            inputText.text = ""

            let parameters: Parameters = [
                "text": message,
                "chat": [
                    "id": chat.chat_id
                ],
                "from": [
                    "id": chat.username,
                    "first_name": chat.first_name,
                    "last_name": chat.last_name,
                    "username": chat.username
                ]
            ]
            
            Alamofire.request("http://chatbot.les.inf.puc-rio.br:8080/message", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                //                debugPrint(response)
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    
                    let response = json as! NSDictionary
                    
                    //example if there is an id
                    let name = response.object(forKey: "uid")! as! String
                    let text = response.object(forKey: "text")! as! String
                    
                    //                    self.chat.messages.append((name, text))
                    self.chat.messages.insert((name, text), at: 0)
                    //                    self.chat.messages.append((name, text))
                    
                    self.chatTableView.reloadData()
                }
                
                //                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                //                    print("Data: \(utf8Text)") // original server data as UTF8 string
                //                }
            }
        }
        else {
            print("mensagem vazia!")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell") as! chatTableViewCell
        
        let (name, message) = chat.messages[indexPath.row]
        
        cell.sender.text = name
        cell.msg.text = message
        cell.backgroundColor = cores[indexPath.row % 2]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        print("108 ChatViewController")
        print(chat)

        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chat.messages = chat.messages.reversed()
        
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 100
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
