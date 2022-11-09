//
//  AFSJSONTableViewController.swift
//  AlamofireSwiftyJSON
//
//  Created by Кирилл Софрин on 09.11.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class AFSJSONTableViewController: UITableViewController {

    var arrayOfQuotes: [String] = []
    let url = "https://www.breakingbadapi.com/api/quotes"

    override func viewDidLoad() {
        super.viewDidLoad()
        parsingJSON(url: url)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfQuotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = arrayOfQuotes[indexPath.row]
        return cell
    }


    func parsingJSON(url: String) {
        AF.request(url, method: .get).responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for index in 0..<json.count {
                    self.arrayOfQuotes.append(json[index]["quote"].stringValue)
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }


}
