import UIKit
// экран отображается при нажатии на ячейку привычки. Показывает дни с момента установки приложения и была-ли выполнена привычка в определенный день.

class HabitDetailsViewController: UIViewController {


    var habit: Habit?

    var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()


    private var backButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("❮ Сегодня", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = Fonts.body.type
        backButton.setTitleColor(Colors.violet.color, for: .normal)

        return backButton
    }()


    private var editButton: UIButton = {
        let editButton = UIButton()
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setTitle("Править", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.titleLabel?.font = Fonts.body.type
        editButton.setTitleColor(Colors.violet.color, for: .normal)

        return editButton
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: HabitDetailsTableViewCell.id)

        setupView()
        setupConstraints()
        setupTableView()
        setupBackButton()
        setupEditButton()

    }


    func setupView() {

        view.addSubview(tableView)
        view.addSubview(backButton)
        view.addSubview(editButton)

        view.backgroundColor = .white

    }


    func setupConstraints() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    func setupTableView() {

        tableView.dataSource = self
        tableView.delegate = self

    }


    func setupBackButton() {
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }


    func setupEditButton() {
        let editButtonItem = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = editButtonItem
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }


    @objc func backButtonTapped() {

        dismiss(animated: true, completion: nil)

    }


    @objc func editButtonTapped() {
        let habitVC = HabitViewController()
        habitVC.title = "Править"
        habitVC.editHabit = habit
        let habitNC = UINavigationController(rootViewController: habitVC)
        habitNC.modalPresentationStyle = .fullScreen
        present(habitNC, animated: true)

        if let tempHabit = habit {
            habitVC.isEdit = true
            habitVC.habitsNameTextField.text = tempHabit.name
            habitVC.habitsNameTextField.textColor = Colors.blue.color
            habitVC.colorButton.backgroundColor = tempHabit.color
            habitVC.selectedDate = tempHabit.date
            let selectedDate = tempHabit.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let formattedTime = dateFormatter.string(from: selectedDate)
            habitVC.timeLabelSecond.text = formattedTime

        }
    }
}


extension HabitDetailsViewController: UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return   HabitsStore.shared.dates.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitDetailsTableViewCell.id, for: indexPath) as? HabitDetailsTableViewCell else { return UITableViewCell() }

        let date = HabitsStore.shared.dates.reversed()[indexPath.row]
        cell.configure(with: (date))
        
        if let tempHabit = habit {
            if HabitsStore.shared.habit(tempHabit, isTrackedIn: date) {
                cell.doneImageView.image = UIImage(named: "doneSymbol")
            }
        }
        return cell
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = Colors.lightgray.color
        let label = UILabel(frame: CGRect(x: 16, y: 22, width: tableView.frame.width - 32, height: 20))
        label.textColor = Colors.tableSectionHeader.color
        label.font = Fonts.body.type
        label.text = "АКТИВНОСТЬ"

        headerView.addSubview(label)

        return headerView
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 44
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
}
