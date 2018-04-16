//
//  Chat.swift
//  xschat
//
//  Created by Ronnie Paskin on 18/04/16.
//  Copyright © 2018 Megaputz. All rights reserved.
//

import Foundation

struct Chat {
    var chat_id: String?    // identifica unicamente o usuário que está enviando
    var first_name: String? // nome do usuário
    var last_name: String?  // sobrenome do usuário
    var username: String?    // id no chat
    
    var messages: [(String, String)] // messages list
}
