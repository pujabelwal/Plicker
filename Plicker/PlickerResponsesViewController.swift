//
//  PlickerResponsesViewController.swift
//  Plicker
//
//  Created by Puja on 2/3/16.
//  Copyright © 2016 Puja. All rights reserved.
//

import UIKit

class PlickerResponsesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var poll : PBPoll? {
        didSet {
            if self.isViewLoaded(){
                self.tableView.reloadData()
            }
        }
    }
    private let darkGreenColor = UIColor(red: 0, green: 130/255, blue: 0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Responses"
        view.backgroundColor = UIColor.purpleColor()
        self.tableView.reloadData()
    }

    //MARK: DataSource methos
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let _ = self.poll {
            return 2;
        } else {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if let poll = self.poll {
            switch section {
                case 0:
                    if let choices = poll.question?.choices {
                        count = choices.count
                    }
                case 1:
                    if let responses = poll.responses {
                        count = responses.count
                    }
                default: break
            }
        }
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = (indexPath.section == 0) ? "Choice Cell" : "Response Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        //default values/cleanup cells before resuse, this code must be in prepareForReuse()
        cell.textLabel?.textColor = UIColor.blackColor()
        cell.detailTextLabel?.textColor = UIColor.blackColor()
        cell.textLabel!.text = nil
        cell.detailTextLabel?.text = nil
        
        if indexPath.section == 0 {
            if let choices = poll!.question?.choices {
                let choice:PBChoices = choices[indexPath.row]
                var choiceText = PlickerResponsesViewController.alphabetAtIndex(indexPath.row) + "."
                choiceText += " \(choice.body)"
                cell.textLabel!.text = choiceText
                cell.textLabel?.textColor = choice.correct ? darkGreenColor : UIColor.redColor()
                if let responsesForThisChoice = choice.responses,
                     totalResponses = poll!.responses {
                     let stats = "\(responsesForThisChoice.count) / \(totalResponses.count)"
                     cell.detailTextLabel?.text = stats
                }
            }
        } else {
            if let response = poll!.responses?[indexPath.row] {
                if let student = response.student {
                    cell.textLabel!.text = student
                }
                if let choice = response.choice {
                    cell.detailTextLabel?.textColor = choice.correct ? darkGreenColor : UIColor.redColor()
                }
                cell.detailTextLabel?.text = response.answer
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "Choices" : "Answers"
    }
    
    class func alphabetAtIndex(index:Int) -> String {
        let lookup = [0:"A", 1:"B", 2:"C", 3:"D", 4:"E", 5:"F", 6:"G", 7:"H", 8:"I"]
        if let alphabet = lookup[index] {
            return alphabet
        } else {
            return ""
        }
    }
}
