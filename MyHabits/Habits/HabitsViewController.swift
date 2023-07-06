import UIKit


class HabitsViewController: UIViewController {

    private var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        return button
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        setupAddButton()
        view.backgroundColor = .cyan
    }


    func setupAddButton() {
        let addButtonItem = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = addButtonItem
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    @objc func addButtonTapped() {

        let habitNC = UINavigationController(rootViewController: HabitViewController())
        habitNC.modalPresentationStyle = .fullScreen
        present(habitNC, animated: true)

        print("Button tapped")

    }

}
