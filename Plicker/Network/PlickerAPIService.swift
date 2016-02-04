//
//  PlickerAPIServices.swift
//  Plicker
//
//  Created by Puja on 1/31/16.
//  Copyright © 2016 Puja. All rights reserved.
//

import UIKit

class PlickerAPIService: NSObject {
    
    func fetchPollData(completion:(error:NSError?, polls: [PBPoll])->(Void)) {
        let pollURL = NSURL(string: "https://plickers-interview.herokuapp.com/polls")
        let request = NSURLRequest(URL: pollURL!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let error = error {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(error:error, polls:[PBPoll]())
                });
            }
            
            if let data = data {
                let jsonObject : AnyObject?
                do {
                    jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                } catch {
                    jsonObject = nil
                }
                //print(jsonObject)
                if let jsonArray = jsonObject as? [AnyObject] {
                     let polls = PBPoll.pollsFromJSONArray(jsonArray)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(error: nil, polls: polls)
                    });
                    
                }
            }
        }
        task.resume()
    }

}
