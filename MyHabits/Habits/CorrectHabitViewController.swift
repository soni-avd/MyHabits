//
//  CorrectHabitViewController.swift
//  MyHabits
//
//  Created by Сони Авдеева on 04/03/2021.
//

import UIKit

class CorrectHabitViewController: UIViewController {
    
    var onReloadDataAfterDelete: (() -> Void)?

    private var habitViewController: HabitViewController?
    var habitDetail: HabitDetailsViewController?
    var habitsViewController: HabitsViewController?
    
    
    let scrollView = UIScrollView()
    public var habit: Habit
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "НАЗВАНИЕ"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 1
        return label
    }()
    
    let textInput: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.layer.borderWidth = 0
        input.font = .systemFont(ofSize: 13)
        return input
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ЦВЕТ"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    let colorButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
        button.layer.masksToBounds = true
        return button
    }()
    let timeLabel: UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.text = "ВРЕМЯ"
        time.textColor = .black
        time.font = .boldSystemFont(ofSize: 13)
        return time
    }()
    
    let dateText: UILabel = {
        let date = UILabel()
        date.text =   "Каждый день в "
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = .systemFont(ofSize: 13)
        date.textColor = .black
        return date
    }()
    let txtDatePicker: UITextField = {
        let txtdata = UITextField()
        txtdata.translatesAutoresizingMaskIntoConstraints = false
        txtdata.textColor = .black
        txtdata.placeholder = "00:00"
        return txtdata
    }()
    let datePicker = UIDatePicker()
    
    let deleteButton: UIButton = {
        let delete = UIButton(type: .system)
        delete.translatesAutoresizingMaskIntoConstraints = false
        delete.setTitle("Удалить привычку", for: .normal)
        delete.setTitleColor(.red, for: .normal)
        delete.addTarget(self, action: #selector(showAlert(_:)), for: .touchUpInside)
        return delete
    }()
    
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func showDatePicker() {
        datePicker.datePickerMode = .time
        txtDatePicker.inputView = datePicker
        datePicker.backgroundColor = .blue
        datePicker.preferredDatePickerStyle = .wheels
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
    }
    
    @objc func doDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        txtDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    @objc func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Удалить привычку?", message: "Вы хотите удалить привычку \(habit.name)?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            if let oldHabit = HabitsStore.shared.habits.firstIndex(where: ({ $0.name == self.habit.name })) {
                HabitsStore.shared.habits.remove(at: oldHabit )
            }
            self.dismiss(animated: true) { [weak self] in
                self?.onReloadDataAfterDelete?()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func setupViews() {
        print(#function)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(textInput)
        scrollView.addSubview(colorLabel)
        scrollView.addSubview(colorButton)
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(dateText)
        scrollView.addSubview(txtDatePicker)
        scrollView.addSubview(deleteButton)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 66),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: textInput.topAnchor, constant: -7),
            nameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            textInput.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textInput.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textInput.bottomAnchor.constraint(equalTo: colorLabel.topAnchor, constant: -15),
            
            colorLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            colorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            timeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            timeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dateText.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            dateText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dateText.trailingAnchor.constraint(equalTo: txtDatePicker.leadingAnchor, constant: -10),
            dateText.widthAnchor.constraint(equalToConstant: 100),
            dateText.heightAnchor.constraint(equalToConstant: 30),
            
            txtDatePicker.heightAnchor.constraint(equalToConstant: 30),
            txtDatePicker.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            txtDatePicker.topAnchor.constraint(equalTo: dateText.topAnchor),
            
            deleteButton.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            deleteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    @objc func colorButtonPressed() {
        print(#function)
        let picker = UIColorPickerViewController()
        self.present(picker, animated: true, completion: nil)
        picker.selectedColor = colorButton.backgroundColor!
        picker.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = .white
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        scrollView.addSubview(navBar)
        let navItem = UINavigationItem(title: "Править")
        let saveItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveBarButton))
        navItem.rightBarButtonItem = saveItem
        let cancelItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelBarButton))
        navItem.leftBarButtonItem = cancelItem
        navBar.setItems([navItem], animated: false)
        setupViews()
        showDatePicker()
        textInput.text = habit.name
        textInput.textColor = habit.color
        colorButton.backgroundColor = habit.color
    }
    @objc func saveBarButton() {
        let newHabit = Habit(name: textInput.text!,
                             date: datePicker.date,
                             color: colorButton.backgroundColor!)
        reloadInputViews()
        if let index = HabitsStore.shared.habits.firstIndex(where: { $0 == self.habit }) {
            HabitsStore.shared.habits[index] = newHabit
        }
        dismiss(animated: true) { [weak self] in
            self?.onReloadDataAfterDelete?()
        }
    }
    @objc func cancelBarButton() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
}
extension CorrectHabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
}
