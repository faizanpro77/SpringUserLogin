//
//  UserCellCollectionView.swift
//  SpringUserLogin
//
//  Created by MD Faizan on 20/07/23.
//

import UIKit

class UserCellCollectionView: UICollectionViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 5
        layer.borderWidth = 1
    }
    
    func configureCell(user: User) {
        
        nameLabel.text = user.name
        cityLabel.text = "\(user.id)"
        ageLabel.text = "\(user.year)"
        addressLabel.text = user.pantone_value
        
    }
    
}
