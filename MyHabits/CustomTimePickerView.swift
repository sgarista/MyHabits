import UIKit

class CustomTimePickerView: UIView {

    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.textColor = .black
        timeLabel.font = UIFont.systemFont(ofSize: 20)
        return timeLabel
    }()

    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.translatesAutoresizingMaskIntoConstraints = false

        timePicker.datePickerMode = .time
        timePicker.backgroundColor = UIColor.white
//        timePicker.subviews[0].subviews[0].removeFromSuperview()
//        timePicker.subviews[0].subviews[0].isHidden = true
        timePicker.setValue(UIColor.clear, forKey: "backgroundColor")




        return timePicker
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        //        setupText()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        addSubview(timeLabel)
        addSubview(timePicker)


        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: timePicker.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            timePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            timePicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        timeLabel.text = "Каждый день в"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: "11:00 PM")
        timePicker.date = date ?? Date()
    }

    func getTime() -> Date {
        return timePicker.date
    }
}
