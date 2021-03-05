//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Сони Авдеева on 22/02/2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
  

    private lazy var habitDetailsTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(HabitDetailsHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: HabitDetailsHeaderView.self))
        tv.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailsTableViewCell.self))
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(correctHabit))
        
        view.addSubview(habitDetailsTableView)
        for habit in HabitsStore.shared.habits {
            self.title = habit.name
        }
        
        let constraints = [
            habitDetailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitDetailsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitDetailsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitDetailsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    @objc func correctHabit() {
        navigationController?.present(CorrectHabitViewController(), animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    }
extension HabitDetailsViewController: UITableViewDelegate {
    
    
}
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return HabitsStore.shared.dates.count
return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HabitDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self)) as! HabitDetailsTableViewCell
        
        return cell
    }
    
    
    
}
