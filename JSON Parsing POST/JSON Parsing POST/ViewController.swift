//
//  ViewController.swift
//  JSON Parsing POST
//
//  Created by apple on 10/01/19.
//  Copyright © 2019 Seraphic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    struct JsonPost : Codable {
        var userId : Int
        var id : Int
        var title : String
        var body : String
    }
    @IBOutlet weak var useridtf: UITextField!
    @IBOutlet weak var idtf: UITextField!
    @IBOutlet weak var titletf: UITextField!
    @IBOutlet weak var bodytf: UITextView!
    @IBOutlet weak var postdatalabel: UILabel!
    @IBOutlet weak var useridlabel: UILabel!
    @IBOutlet weak var idlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var bodylabel: UILabel!
    
    @IBAction func postData(_ sender: Any) {

    let link = URL(string: "https://jsonplaceholder.typicode.com/posts")
        var request = URLRequest(url: link!)
        request.httpMethod = "POST"
//        request.addValue("application/JSON", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let USERID = Int(useridtf.text!)
        let ID = Int(idtf.text!)

        let TITLE = titletf.text!
        let BODY = bodytf.text!
        let data = JsonPost(userId: USERID!, id: ID!, title: TITLE, body: BODY)

        do {
            
            let json = try JSONEncoder().encode(data)
            request.httpBody = json
        
        } catch _
        {
            
        }
        
        
    
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            do {
//                let x = try JSONSerialization.jsonObject(with: data!, options: [])
//                print(x)

                let sentPost = try JSONDecoder().decode( JsonPost.self, from: data!)
            
                DispatchQueue.main.async {
                self.useridlabel.text! = String(sentPost.userId)
                self.idlabel.text! = String(sentPost.id)
                self.titlelabel.text! = sentPost.title
                self.bodylabel.text! = sentPost.body
                
                }
                
                
            }
            catch {
                
            }
        }.resume()
        
        
        
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

