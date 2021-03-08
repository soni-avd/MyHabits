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
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
     let habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = habit.name
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(correctHabit))
        view.addSubview(habitDetailsTableView)
        
        let constraints = [
            habitDetailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitDetailsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitDetailsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitDetailsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    @objc func correctHabit() {
        navigationController?.present(CorrectHabitViewController(habit: habit), animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    }
extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HabitDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self)) as! HabitDetailsTableViewCell
        cell.dayDate = HabitsStore.shared.habits[indexPath.item]
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HabitDetailsHeaderView()
    }
    
    
}
