//
//  HabitsTodayProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Сони Авдеева on 18/02/2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    
    private let  indicatorText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Все получится!"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private var indicatorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(Float(HabitsStore.shared.todayProgress))%"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    var progressIndicator: UIProgressView = {
        var progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.trackTintColor = .systemGray
        progress.progressTintColor = .systemPurple
        progress.setProgress(HabitsStore.shared.todayProgress, animated: true)
        return progress
    }()
    
    func setupViews() {
        contentView.addSubview(indicatorText)
        contentView.addSubview(indicatorLabel)
        contentView.addSubview(progressIndicator)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        let constraints = [
            indicatorText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            indicatorText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            indicatorText.bottomAnchor.constraint(equalTo: progressIndicator.topAnchor, constant: -10),
            
            indicatorLabel.topAnchor.constraint(equalTo: indicatorText.topAnchor),
            indicatorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            indicatorLabel.widthAnchor.constraint(equalToConstant: 40),
            indicatorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            progressIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressIndicator.heightAnchor.constraint(equalToConstant: 7)
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
