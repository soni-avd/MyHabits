//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Сони Авдеева on 20/02/2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit? {
        didSet {
            habitLabel.text = habit?.name
            timeLabel.text = habit?.dateString
            tickButton.layer.borderColor = habit?.color.cgColor
            habitLabel.textColor = habit?.color
            if habit?.isAlreadyTakenToday == true {
                tick()
                daysLabel.text = "Подряд: \(+1)"
            } else {
                daysLabel.text = "Подряд: 0"
            }
        }
    }
    private var habitLabel: UILabel = {
        var habit = UILabel()
        habit.translatesAutoresizingMaskIntoConstraints = false
        habit.numberOfLines = 0
        for habit1 in HabitsStore.shared.habits {
            habit.text = "\(habit1.name)"
            habit.textColor = habit1.color
        }
        habit.font = .boldSystemFont(ofSize: 15)
        return habit
    }()
    private var timeLabel: UILabel = {
        var time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.textColor = .systemGray
        for habit in HabitsStore.shared.habits {
            time.text = "\(habit.dateString)"
        }
        return time
    }()
    
    private var daysLabel: UILabel = {
        var days = UILabel()
        days.translatesAutoresizingMaskIntoConstraints = false
        days.textColor = .systemGray
        return days
    }()
    private lazy var tickButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tick), for: .touchUpInside)
        return button
    }()
    @objc func tick() {
        print(#function)
    
            tickButton.tintColor = habit?.color
        tickButton.backgroundColor = habit?.color
            tickButton.setImage(.checkmark, for: .normal)
            if habit?.isAlreadyTakenToday == false {
                HabitsStore.shared.track(habit!)
            
            }
    }
    
        
    
    func setupViews() {
        print(#function)
        
        contentView.addSubview(habitLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(daysLabel)
        contentView.addSubview(tickButton)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        let constraints = [
            
            habitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -4),
            habitLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            timeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            daysLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            daysLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            daysLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            daysLabel.heightAnchor.constraint(equalToConstant: 20),
            
            tickButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            tickButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47),
            tickButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            tickButton.widthAnchor.constraint(equalToConstant: 36)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

