//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by Сони Авдеева on 01/03/2021.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
// public var dayDate: Habit? {
//        didSet {
//            let dateCount = HabitsStore.shared.dates.count
//            trackedDay.text = HabitsStore.shared.trackDateString(forIndex: dateCount)
//            
//        }
//    }

    var trackedDay: UILabel = {
        var day = UILabel()
        day.translatesAutoresizingMaskIntoConstraints = false

       return day
    }()
    func setupViews() {
        contentView.addSubview(trackedDay)
        let constraints = [
            trackedDay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            trackedDay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            trackedDay.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            trackedDay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
