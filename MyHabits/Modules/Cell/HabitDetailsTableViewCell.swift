import UIKit


class HabitDetailsTableViewCell: UITableViewCell {


    static let id = "HabitDetailsTableViewCell"

    var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        return dateLabel
    }()


    var doneImageView: UIImageView = {
        let doneImageView = UIImageView()
        doneImageView.translatesAutoresizingMaskIntoConstraints = false

        return doneImageView
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupConstraints()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupView() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(doneImageView)
    }


    func setupConstraints() {

        NSLayoutConstraint.activate([

            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22),

            doneImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            doneImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }


    func configure(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let currentDateTime = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        
        switch calendar.compare(date, to: currentDateTime, toGranularity: .day) {
        case .orderedSame:
            dateLabel.text = "Сегодня"
        case .orderedDescending:
            dateFormatter.dateFormat = "d MMMM yyyy"
            if let formattedDate = calendar.date(from: components) {
                let formattedDateString = dateFormatter.string(from: formattedDate)
                dateLabel.text = formattedDateString
            }
        case .orderedAscending:
            let dayBeforeYesterday = calendar.date(byAdding: .day, value: -2, to: currentDateTime)!
            if calendar.isDateInYesterday(date) {
                dateLabel.text = "Вчера"
            } else if calendar.isDate(date, inSameDayAs: dayBeforeYesterday) {
                dateLabel.text = "Позавчера"
            } else {
                dateFormatter.dateFormat = "d MMMM yyyy"
                if let formattedDate = calendar.date(from: components) {
                    let formattedDateString = dateFormatter.string(from: formattedDate)
                    dateLabel.text = formattedDateString
                }
            }
        }
    }
}


