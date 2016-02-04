//
//  PlickerViewController.swift
//  Plicker
//
//  Created by Puja on 1/31/16.
//  Copyright © 2016 Puja. All rights reserved.
//

import UIKit

class PlickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var polls = [PBPoll]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Questions"
        let service = PlickerAPIService()

        service.fetchPollData { (error, polls) -> (Void) in
            if let error = error {
                print(error.localizedDescription)
                //TODO:: show error, perform recovery
            } else {
                self.polls = polls
                //print(polls)
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: UICollectionViewDataSource methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return polls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlickerCellID", forIndexPath: indexPath) as! PlickerCell
        let poll = self.polls[indexPath.row]
        cell.configureWithQuestion(poll.question!)
        return cell
    }
    
    //MARK: UICollectionViewDelegate methods
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //let currentPoll = self.polls[indexPath.row]
        let plickerResponsesController = self.storyboard?.instantiateViewControllerWithIdentifier("ResponseViewControllerID") as! PlickerResponsesViewController
        plickerResponsesController.poll = self.polls[indexPath.row]
        self.navigationController?.pushViewController(plickerResponsesController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
        let size = CGSizeMake(CGRectGetWidth(collectionView.bounds), 200)
        return size
    }
}

