//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Сони Авдеева on 22/02/2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var onReloadData: (() -> Void)?

    private lazy var habitDetailsTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(HabitDetailsHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: HabitDetailsHeaderView.self))
        tv.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailsTableViewCell.self))
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    private lazy var correctHabitVC = CorrectHabitViewController(habit: habit)

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
        setupCorrectHabitCallbacks()
    }
    @objc func correctHabit() {
        navigationController?.present(correctHabitVC, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    private func setupCorrectHabitCallbacks() {
        correctHabitVC.onReloadDataAfterDelete = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?.onReloadData?()
        }
        
    }
}
extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habit.trackDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HabitDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self)) as! HabitDetailsTableViewCell
        cell.trackedDay.text = HabitsStore.shared.trackDateString(forIndex: HabitsStore.shared.dates.count - 1 - indexPath.item)
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let oldIndex = tableView.indexPathForSelectedRow {
            tableView.cellForRow(at: oldIndex)?.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        return indexPath
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HabitDetailsHeaderView()
    }
    
    
}
