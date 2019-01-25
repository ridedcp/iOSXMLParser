//
//  ViewController.swift
//  XMLParser
//
//  Created by Daniel Cano on 25/01/2019.
//  Copyright © 2019 danielcano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var parser: XMLParser = XMLParser()
    var dataPostArray: [XMLData] = []
    var postTitle: String = String()
    var postLink: String = String()
    var name: String = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let url: URL? = URL(string: "http://www.nba.com/rss/nba_rss.xml")

        guard url != nil else { return }
        
        //Initialize xmlParser class with this url
        parser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        
        //Start protocol methods, parse xml
        parser.parse()
    }

    
    //Start Delegate Methods
    
    //Start parsing XML. Select main Key.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    
        name = elementName
        
        //When start parsing, find "item" key in HTML page, it will initialize data Strings
        if elementName == "item" {
            
            //Initialize strings
            postTitle = String()
            postLink = String()
        }
    }
    
    
    //Extract data from "item" key. Find characters into XML
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) //Extract data deleting white spaces
        
        if (!data.isEmpty) {
            
            if name == "title" {
                
                postTitle += data
                
            } else if name == "link" {
                
                postLink += data
            }
        }
    }
    
    
    //End Parsing and add founded element info my array
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            
            let postData: XMLData = XMLData()
            postData.title = postTitle
            postData.link = postLink
            
            dataPostArray.append(postData)
        }
    }
    
    
    //TableView Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataPostArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let articleTitle: XMLData = dataPostArray[indexPath.row]
        cell.textLabel?.text = articleTitle.title
        
        return cell
    }
    
    
    //Call when tab a cell. We add same title ("show") to our segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show" {
            
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let postData: XMLData = dataPostArray[selectedRow!]
            
            let VC = segue.destination as! DetailViewController
            VC.web = postData.link
        }
    }
}

