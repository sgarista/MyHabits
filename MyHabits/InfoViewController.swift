import UIKit


class InfoViewController: UIViewController {


    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()

   private var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        return contentView
    }()


    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont(name: "SFProText-Regular", size: 17)
        titleLabel.font = .boldSystemFont(ofSize: 17)

        return titleLabel
    }()

    private var bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.numberOfLines = 0

        return bodyLabel
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.lightgray.color

        setupUI()
        setupConstraints()


        titleLabel.text = "Сколько зарабатывают гонщики «Ф-1»?"
        bodyLabel.text = "А после введения потолка расходов на болиды команды получили возможность сманивать и удерживать звезд большими зарплатами – ведь гонорары гонщиков исключаются из-под ограничений! Сколько же зарабатывают эти ребята? Один из самых авторитетных и старых журналистов паддока «Формулы-1» (а ныне и советник президента Международной автомобильной федерации) Дитер Ренкен общается с инсайдерами, менеджерами гонщиков и управляющим штатом команд о суммах в их контрактах каждый год и публикует инсайды – вот его распределение 220 миллионов в год на всех: А после введения потолка расходов на болиды команды получили возможность сманивать и удерживать звезд большими зарплатами – ведь гонорары гонщиков исключаются из-под ограничений! Сколько же зарабатывают эти ребята? Один из самых авторитетных и старых журналистов паддока «Формулы-1» (а ныне и советник президента Международной автомобильной федерации) Дитер Ренкен общается с инсайдерами, менеджерами гонщиков и управляющим штатом команд о суммах в их контрактах каждый год и публикует инсайды – вот его распределение 220 миллионов в год на всех: А после введения потолка расходов на болиды команды получили возможность сманивать и удерживать звезд большими зарплатами – ведь гонорары гонщиков исключаются из-под ограничений! Сколько же зарабатывают эти ребята? Один из самых авторитетных и старых журналистов паддока «Формулы-1» (а ныне и советник президента Международной автомобильной федерации) Дитер Ренкен общается с инсайдерами, менеджерами гонщиков и управляющим штатом команд о суммах в их контрактах каждый год и публикует инсайды – вот его распределение 220 миллионов в год на всех: А после введения потолка расходов на болиды команды получили возможность сманивать и удерживать звезд большими зарплатами – ведь гонорары гонщиков исключаются из-под ограничений! Сколько же зарабатывают эти ребята? Один из самых авторитетных и старых журналистов паддока «Формулы-1» (а ныне и советник президента Международной автомобильной федерации) Дитер Ренкен общается с инсайдерами, менеджерами гонщиков и управляющим штатом команд о суммах в их контрактах каждый год и публикует инсайды – вот его распределение 220 миллионов в год на всех:"
    }




    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)

        title = "Информация"

    }

    func setupConstraints() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)

        ])

    }
}
