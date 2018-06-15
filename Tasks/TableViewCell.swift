//
//  TableViewCell.swift
//  Tasks
//
//  Created by Kirill Klimovich on 13/06/2018.
//  Copyright © 2018 Kirill Klimovich. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var titleTextEdit: UITextField!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //hide iPhone's keyboard on Return
        self.titleTextEdit.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //hide iPhone's keyboard on Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }

}
