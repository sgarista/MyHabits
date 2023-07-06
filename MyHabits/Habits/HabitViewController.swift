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

        return nameLabel
    }()


    var habitsNameTextField: UITextField = {
        let habitsNameTextField = UITextField()
        habitsNameTextField.translatesAutoresizingMaskIntoConstraints = false
        habitsNameTextField.placeholder = "Бегать по утрам, спать 8 часов и тд и тп"


        return habitsNameTextField
    }()


    var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.text = "ЦВЕТ"

        return colorLabel
    }()


   lazy var colorButton: UIButton = {
        let colorButton = UIButton()
        colorButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        colorButton.layer.cornerRadius = colorButton.frame.height / 2
        colorButton.clipsToBounds = true
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.backgroundColor = UIColor.red
        colorButton.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)


        return colorButton
    }()


    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.text = "ВРЕМЯ"
        return timeLabel
    }()

    var timePickerView: CustomTimePickerView = {
        let timePickerView = CustomTimePickerView()
        timePickerView.translatesAutoresizingMaskIntoConstraints = false

        timePickerView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let tapGesture = UITapGestureRecognizer(target: HabitViewController.self, action: #selector(openTimePicker))
        timePickerView.timeLabel.addGestureRecognizer(tapGesture)
        timePickerView.timeLabel.isUserInteractionEnabled = true


        return timePickerView
    }()

    private var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//        cancelButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        return cancelButton
    }()


    private var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)

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
        contentView.addSubview(timePickerView)
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

            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            timePickerView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            timePickerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)

        ])
    }




    @objc func cancelButtonTapped() {


        print("cancel button tapped")

    }

    @objc func saveButtonTapped() {


        print("save button tapped")

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
    
    @objc func openTimePicker() {
        let alertController = UIAlertController(title: "Выберите время", message: nil, preferredStyle: .actionSheet)

        let doneAction = UIAlertAction(title: "Готово", style: .default) { [weak self] (action) in
            let selectedTime = self?.timePickerView.getTime()

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let timeString = dateFormatter.string(from: selectedTime!)
            self?.timePickerView.timeLabel.text = "Каждый день в \(timeString)"
        }
        alertController.addAction(doneAction)

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        alertController.view.addSubview(timePickerView.timePicker)

        present(alertController

                , animated: true, completion: nil)
    }

    @objc func goBack() {
print("ssdfsdf")
        
    }


}



