import UIKit


class ProgressCollectionViewCell: UICollectionViewCell {

    static let id = "ProgressCollectionViewCell"



    var supportLabel: UILabel = {
        let supportLabel = UILabel()
        supportLabel.translatesAutoresizingMaskIntoConstraints = false
//        supportLabel.text = "Все получится!"


        return supportLabel
    }()

    var progressLabel: UILabel = {
        let progressLabel = UILabel()
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
//        progressLabel.text = "50%"


        return progressLabel
    }()


    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = Colors.violet.color
        progressView.trackTintColor = Colors.systemgray2.color
//        progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)


        return progressView
    }()


    override init(frame: CGRect) {
        super .init(frame: .zero)

        setupView()
        setupConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupView() {

        contentView.addSubview(supportLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressView)

        backgroundColor = .white
        layer.cornerRadius = 8

    }
    func setupConstraints() {

        let safeAreaLayoutGuide = contentView.safeAreaLayoutGuide


        NSLayoutConstraint.activate([

            supportLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            supportLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
//            supportLabel.trailingAnchor.constraint(equalTo: progressLabel.leadingAnchor, constant: -8),

            // Progress Label constraints
            progressLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            progressLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),

            // Progress View constraints
            progressView.topAnchor.constraint(equalTo: supportLabel.bottomAnchor, constant: 8),
            progressView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            progressView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            progressView.heightAnchor.constraint(equalToConstant: 7)

        ])

    }


    func setup() {

        supportLabel.text = "Все получится!"
        progressLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
//        progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
        UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseInOut, animations: {
            self.progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
        }, completion: nil)


    }
}








