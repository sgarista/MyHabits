import UIKit
/*
 экран создания или редактирования привычки. При редактировании появляется кнопка для удаления привычки.
 В макете установлен формат пикера с AM/PM, поскольку потом время все-равно переводится в 24-часовой формат, я выставил Locale(identifier: "ru_RU") для отображения пикера сразу в формате 24 часа.
 */

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {

    
    var editHabit: Habit?

    var isEdit = false


    private var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        return contentView
    }()


    var habitNameLabel: UILabel = {
        let habitNameLabel = UILabel()
        habitNameLabel.translatesAutoresizingMaskIntoConstraints = false
        habitNameLabel.text = "НАЗВАНИЕ"
        habitNameLabel.font = Fonts.headline.type

        return habitNameLabel
    }()


    var habitsNameTextField: UITextField = {
        var habitsNameTextField = UITextField()
        habitsNameTextField.translatesAutoresizingMaskIntoConstraints = false
        habitsNameTextField.placeholder = "Бегать по утрам, спать 8 часов и тд и тп"
        habitsNameTextField.autocorrectionType = .no
        habitsNameTextField.textColor = .black
        habitsNameTextField.font = Fonts.headline.type
        habitsNameTextField.clearButtonMode = .whileEditing

        return habitsNameTextField
    }()


    var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = Fonts.headline.type

        return colorLabel
    }()


    lazy var colorButton: UIButton = {
        let colorButton = UIButton()
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.layer.cornerRadius = 15
        colorButton.clipsToBounds = true
        colorButton.backgroundColor = UIColor.blue
        colorButton.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)

        return colorButton
    }()


    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = Fonts.headline.type

        return timeLabel
    }()


    var timeLabelFirst: UILabel = {
        let timeLabelFirst = UILabel()
        timeLabelFirst.translatesAutoresizingMaskIntoConstraints = false
        timeLabelFirst.text = "Каждый день в "

        return timeLabelFirst
    }()


    var timeLabelSecond: UILabel = {
        let timeLabelSecond = UILabel()
        timeLabelSecond.translatesAutoresizingMaskIntoConstraints = false
        timeLabelSecond.textColor = Colors.violet.color

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: Date())
        timeLabelSecond.text = currentTime

        return timeLabelSecond
    }()

    var selectedDate: Date?


    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "ru_RU")

        timePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)

        return timePicker
    }()


    private var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.titleLabel?.font = Fonts.body.type
        cancelButton.setTitleColor(Colors.violet.color, for: .normal)

        return cancelButton
    }()


    private var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.titleLabel?.font = Fonts.headline.type
        saveButton.setTitleColor(Colors.violet.color, for: .normal)

        return saveButton
    }()


    lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Удалить привычку", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)

        return deleteButton
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        setupCancelButton()
        setupSaveButton()
        setupView()
        setupConstraints()
        setupDeleteButton()

    }


    func setupCancelButton() {
        let cancelButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.leftBarButtonItem = cancelButtonItem
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }


    func setupSaveButton() {
        let saveButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.rightBarButtonItem = saveButtonItem
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }


    func setupView() {

        view.addSubview(contentView)
        contentView.addSubview(habitNameLabel)
        contentView.addSubview(habitsNameTextField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorButton)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timeLabelFirst)
        contentView.addSubview(timeLabelSecond)
        contentView.addSubview(timePicker)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)

        view.backgroundColor = .white
    }


    func setupConstraints() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([

            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            habitsNameTextField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 16),
            habitsNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitsNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            colorLabel.topAnchor.constraint(equalTo: habitsNameTextField.bottomAnchor, constant: 16),
            colorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 16),
            colorButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),

            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            timeLabelFirst.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            timeLabelFirst.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),


            timeLabelSecond.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            timeLabelSecond.leadingAnchor.constraint(equalTo: timeLabelFirst.trailingAnchor),

            timePicker.topAnchor.constraint(equalTo: timeLabelSecond.bottomAnchor, constant: 16),
            timePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

        ])
    }


    func setupDeleteButton() {

        if isEdit {
            contentView.addSubview(deleteButton)

            NSLayoutConstraint.activate([
                deleteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                deleteButton.heightAnchor.constraint(equalToConstant: 22)
            ])
            deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        } else {
            deleteButton.removeFromSuperview()
            NSLayoutConstraint.deactivate([
                deleteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                deleteButton.heightAnchor.constraint(equalToConstant: 22)
            ])
        }
    }


    @objc func cancelButtonTapped() {

        dismiss(animated: true, completion: nil)

    }


    @objc func saveButtonTapped() {

        if let habit = editHabit {
            var tempName = ""
            if let text = habitsNameTextField.text {
                if text.count > 0 {
                    tempName = text
                } else {
                    tempName = "Завести полезную привычку"
                }
            }
            habit.name = tempName
            habit.date = selectedDate ?? Date()
            habit.color = colorButton.backgroundColor ?? .systemRed
            HabitsStore.shared.save()
            let habitDetailsViewController = HabitDetailsViewController()
            habitDetailsViewController.habit = habit

            dismiss(animated: true, completion: nil)
            HabitsViewController.collectionView.reloadData()
            HabitDetailsViewController().tableView.reloadData()
        } else {

            var tempName = ""
            if let text = habitsNameTextField.text {
                if text.count > 0 {
                    tempName = text
                } else {
                    tempName = "Завести полезную привычку"
                }
            }

            let newHabit = Habit(name: tempName,
                                 date: selectedDate ?? Date(),
                                 color: colorButton.backgroundColor ?? .blue)
            let store = HabitsStore.shared
            store.habits.insert(newHabit, at: 0)

            dismiss(animated: true, completion: nil)
            HabitsViewController.collectionView.reloadData()

        }
    }


    @objc func showColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    }


    @objc func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        colorButton.backgroundColor = selectedColor
        viewController.dismiss(animated: true, completion: nil)
    }


    @objc func datePickerValueChanged(sender: UIDatePicker) {

        selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: selectedDate!)
        timeLabelSecond.text = formattedTime
    }


    @objc func deleteButtonPressed() {

        if let habit = editHabit {

            let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit.name)?", preferredStyle: .alert)

            let deleteAlert = UIAlertAction(title: "Удалить", style: .destructive) { _ in
                self.deleteHabit(with: habit)
                self.dismiss(animated: true) {
                    let habitsViewController = HabitsViewController()
                    habitsViewController.modalPresentationStyle = .fullScreen
                    self.presentingViewController?.present(habitsViewController, animated: true, completion: nil)
                }
            }

            alert.addAction(deleteAlert)

            let cancelAlert = UIAlertAction(title: "Отмена", style: .cancel) { _ in

            }

            alert.addAction(cancelAlert)

            present(alert, animated: true, completion: nil)

        }
    }


    func deleteHabit(with habit: Habit) {
        if let index = HabitsStore.shared.habits.firstIndex(where: { $0.name == habit.name && $0.date == habit.date }) {
            HabitsStore.shared.habits.remove(at: index)
            HabitsViewController.collectionView.reloadData()
        }
    }
}



