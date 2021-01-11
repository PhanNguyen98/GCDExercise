//
//  TableViewCell.swift
//  GCDExercise
//
//  Created by Phan Nguyen on 17/12/2020.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var fruitImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fruitImageView.image = nil
    }
    
    func setImageFromUrl(ImageURL :String, index: Int) {
        let queue = DispatchQueue(label: "Concurrent",qos: .background , attributes: .concurrent)
        activityIndicator.startAnimating()
        queue.async {
            let task = URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: { (data, response, error) -> Void in
                DispatchQueue.main.async {
                    if self.tag == index {
                        if let data = data {
                            self.fruitImageView.image = UIImage(data: data)
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            })
            task.resume()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
