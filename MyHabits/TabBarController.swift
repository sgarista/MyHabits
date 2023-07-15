import UIKit

class TabBarController: UITabBarController {

    var habitsTabNavigationController: UINavigationController!
    var infoTabNavigationController: UINavigationController!


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }


    private func setupUI() {

        habitsTabNavigationController = UINavigationController.init(rootViewController: HabitsViewController())
        infoTabNavigationController = UINavigationController.init(rootViewController: InfoViewController())

        self.viewControllers = [habitsTabNavigationController, infoTabNavigationController]

        habitsTabNavigationController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName:"checklist"), tag: 0)

        infoTabNavigationController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName:"info.circle.fill"), tag: 1)

        self.tabBar.tintColor = Colors.violet.color


    }
}
