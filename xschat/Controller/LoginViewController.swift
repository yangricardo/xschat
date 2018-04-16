//
//  LoginViewController.swift
//  
//
//  Created by Ronnie Paskin on 18/04/16.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var chat_id: UITextField!
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var user_id: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let chatVC = segue.destination as? ChatViewController else { return } // only continue if we have the destination view controller

        chatVC.chat = Chat(chat_id: "rpaskin", first_name: "Ronnie", last_name: "Paskin", username: "rpaskin", messages: [("dica", "começe enviando /start")])

        chatVC.chat.chat_id = self.chat_id.text
        chatVC.chat.first_name = self.first_name.text
        chatVC.chat.last_name = self.last_name.text
        chatVC.chat.username = self.user_id.text
    }
}
