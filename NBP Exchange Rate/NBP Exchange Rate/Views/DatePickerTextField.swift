//
//  DatePickerTextField.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 10/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

class DatePickerTextField: UITextField {
    
    let dateFormatter = DateFormatter()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(onDateChange(_:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        inputView = datePicker
        text = dateFormatter.string(from: datePicker.date)
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }

    @objc func onDateChange(_ sender: UIDatePicker) {
        text = dateFormatter.string(from: sender.date)
    }
}
