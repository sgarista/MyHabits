import UIKit


class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {

    
    private var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        return contentView
    }()


    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "НАЗВАНИЕ"
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return nameLabel
    }()


    var habitsNameTextField: UITextField = {
        var habitsNameTextField = UITextField()
        habitsNameTextField.translatesAutoresizingMaskIntoConstraints = false
        //        habitsNameTextField.text = "Завести полезную привычку"
        habitsNameTextField.placeholder = "Бегать по утрам, спать 8 часов и тд и тп"
        habitsNameTextField.textColor = Colors.systemgray2.color

        return habitsNameTextField
    }()


    var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)

        return colorLabel
    }()


    lazy var colorButton: UIButton = {
        let colorButton = UIButton()
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.layer.cornerRadius = 15
        colorButton.clipsToBounds = true
        colorButton.backgroundColor = UIColor.red
        colorButton.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)

        return colorButton
    }()


    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)

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
        timeLabelSecond.text = "11:00 PM"

        return timeLabelSecond
    }()

    var selectedDate: Date?

    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.datePickerMode = .time
//        timePicker.locale = Locale(identifier: "en_US_POSIX")
        timePicker.preferredDatePickerStyle = .wheels

        timePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)

        return timePicker
    }()


    private var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        cancelButton.setTitleColor(Colors.violet.color, for: .normal)

        //        cancelButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        return cancelButton
    }()


    private var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        saveButton.setTitleColor(Colors.violet.color, for: .normal)

        return saveButton
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupCancelButton()
        setupSaveButton()

        title = "Страница"

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


    func setupUI() {

        view.addSubview(contentView)
        contentView.addSubview(nameLabel)
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



            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            habitsNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
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
            timePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)

        ])
    }




    @objc func cancelButtonTapped() {

        dismiss(animated: true, completion: nil)

        print("cancel button tapped")

    }

    @objc func saveButtonTapped() {

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
                             color: colorButton.backgroundColor ?? .systemRed)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        print(newHabit.name, newHabit.date, newHabit.color)
//                store.habits.removeAll()
        print(store.habits)
        print("save button tapped")
        dismiss(animated: true, completion: nil)
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

        // Форматируем выбранное время для отображения в UILabel
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+03:00")

        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: selectedDate!)

        // Передаем отформатированное время в UILabel
        timeLabelSecond.text = formattedTime

        // Вызываем метод для передачи времени в другое место
    }

    //    @objc private func timeChanged() {
    //        let formatter = DateFormatter()
    //        formatter.timeStyle = .short
    //
    //        let selectedTime = formatter.string(from: timePicker.date)
    //        print(type(of: selectedTime))
    //        timeLabelSecond.text = selectedTime
    //    }


}



