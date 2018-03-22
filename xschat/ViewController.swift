//
//  ViewController.swift
//  xschat
//
//  Created by Ronnie Paskin on 18/03/22.
//  Copyright © 2018 Megaputz. All rights reserved.
//

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

