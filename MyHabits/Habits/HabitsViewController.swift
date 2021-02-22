//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Сони Авдеева on 09/02/2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Привычки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewHabit))
        
        view.addSubview(habitsCollectionView)
        habitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        habitsCollectionView.backgroundColor = .systemGray
        habitsCollectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        habitsCollectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        habitsCollectionView.delegate = self
        habitsCollectionView.dataSource = self
        
        let constraints = [
            habitsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func addNewHabit() {
        print(#function)
        self.present(HabitViewController(), animated: true, completion: nil)
    }
    
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
        let width: CGFloat = collectionView.bounds.width - 32
        return CGSize(width: width, height: 60)
        } else {
            let width: CGFloat = collectionView.bounds.width - 32
          return CGSize(width: width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 18, right: 16)
        } else if section == 1 {
            return UIEdgeInsets(top: 18, left: 16, bottom: 12, right: 16)
        } else {
            return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        }
    }
    
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
        return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            if indexPath.item == HabitsStore.shared.habits.count {
//                for habit1 in HabitsStore.shared.habits {
                    cell.habit?.name = HabitsStore.shared.habits[indexPath.row].name
//                }
            }
            return cell
        }
}

}
