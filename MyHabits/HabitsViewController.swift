//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Сони Авдеева on 09/02/2021.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Привычки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewHabit))
    }

    @objc func addNewHabit() {
        self.present(HabitViewController(), animated: true, completion: nil)
    }
}
