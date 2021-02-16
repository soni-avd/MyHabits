//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Сони Авдеева on 09/02/2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    let scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let containerView: UIView = {
       let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let habitHeadline: UILabel = {
    let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Привычка за 21 день"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let habitInfo: UILabel = {
       let text = UILabel()
        text.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: \n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n3.  Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться. \n4.  Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n5.  Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n 6.   На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.\n  Источник: psychbook.ru"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 17)
        text.numberOfLines = 0
        text.textColor = .black
        return text
    }()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Информация"
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(habitHeadline)
        containerView.addSubview(habitInfo)
        setupViews()
    }
    
    func setupViews() {
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
           
            habitHeadline.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            habitHeadline.bottomAnchor.constraint(equalTo: habitInfo.topAnchor, constant: -16),
            habitHeadline.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            habitHeadline.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            habitInfo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            habitInfo.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            habitInfo.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
