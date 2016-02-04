//
//  PlickerCell.swift
//  Plicker
//
//  Created by Puja on 2/1/16.
//  Copyright © 2016 Puja. All rights reserved.
//

import UIKit

class PlickerCell: UICollectionViewCell {
    
    @IBOutlet weak var questionImage: UIImageView!    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var overlayImageView: UIImageView!
    
    lazy var placeHolderImage = UIImage(named: "question")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureWithQuestion(question: PBQuestion) {
        questionText.text = question.body
        if let body = question.body where body.isEmpty {
            overlayImageView.hidden = true
            questionImage.contentMode = .ScaleAspectFit
        }else {
            overlayImageView.hidden = false
            questionImage.contentMode = .ScaleAspectFill
        }
        
        if let imageURLString = question.image, url = NSURL(string: imageURLString) {
                //print(question.image)
                let request = NSURLRequest(URL: url)
                questionImage.setImageWithURLRequest(request, placeholderImage: placeHolderImage,
                    success: { (urlRequest: NSURLRequest, response: NSHTTPURLResponse?, image: UIImage) -> Void in
                        self.questionImage.image = image
                    },
                    failure: nil)
        } else {
            questionImage.image = placeHolderImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionImage.cancelImageDownloadTask()
        questionImage.image = nil
        questionText.text = nil
    }
}
