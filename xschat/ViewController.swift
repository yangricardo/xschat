//
//  ViewController.swift
//  xschat
//
//  Created by Ronnie Paskin on 18/03/22.
//  Copyright © 2018 Megaputz. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var inputText: UITextField!
    
    var chatMessages = [("rpaskin","oi"), ("jsilva","tudo bom?"), ("rpaskin", "tudo"), ("ssalgado", "alguém quer um doce?")]
    
    @IBAction func enviarTouched(_ sender: UIButton) {
        
        if inputText.hasText {
            let name = "rpaskin"
            let message = inputText.text!

            chatMessages.append((name, message))
            chatTableView.reloadData()

            let parameters: Parameters = [
                "text": "start",
                "chat": [
                    "id": "rpaskin"
                ],
                "from": [
                    "id": "user_1",
                    "first_name": "Joao",
                    "last_name": "Silva",
                    "username": "user_1"
                ]
            ]
            
            Alamofire.request("http://chatbot.les.inf.puc-rio.br:8080/message", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
            }
        }
        else {
            print("mensagem vazia!")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell")

        let (name, message) = chatMessages[indexPath.row]
        
        cell?.textLabel?.text = name
        cell?.detailTextLabel?.text = message

        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        chatTableView.delegate = self
        chatTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

