import UIKit


class HabitCollectionViewCell: UICollectionViewCell {
    
    static let id = "HabitCollectionViewCell"
    
    
    var habitLabel: UILabel = {
        let habitLabel = UILabel()
        habitLabel.translatesAutoresizingMaskIntoConstraints = false
        habitLabel.numberOfLines = 2
        habitLabel.lineBreakMode = .byTruncatingTail
        habitLabel.textAlignment = .left
        habitLabel.font = Fonts.headline.type


        
        return habitLabel
    }()
    
    
    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = Fonts.caption.type
        timeLabel.textColor = Colors.systemgray2.color
        
        return timeLabel
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8


        return stackView
    }()


    var counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.font = Fonts.footnoteRegular13.type
        counterLabel.textColor = Colors.systemgray.color
        
        return counterLabel
    }()
    
    
    
    lazy var doneView: UIView = {
        let doneView = UIView()
        doneView.translatesAutoresizingMaskIntoConstraints = false
        //        doneView.frame = CGRect(x: 0, y: 0, width: 76, height: 76)
        doneView.layer.cornerRadius = 19
        doneView.layer.borderWidth = 2
        doneView.layer.masksToBounds = true
        doneView.isUserInteractionEnabled = true

        return doneView
    }()

    lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark") // Замените "imageName" на название вашего изображения
        imageView.contentMode = .scaleAspectFit // Установите необходимый режим отображения изображения
        imageView.tintColor = .white
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)

        return imageView
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

        stackView.addArrangedSubview(habitLabel)
        stackView.addArrangedSubview(timeLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(counterLabel)
        contentView.addSubview(doneView)
        doneView.addSubview(checkmarkImageView)

        backgroundColor = .white
        layer.cornerRadius = 8
        
    }
    func setupConstraints() {
        
        let safeAreaLayoutGuide = contentView.safeAreaLayoutGuide
        
        
        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalToConstant: 220),

//            habitLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            habitLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
//            habitLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -16),
//            habitLabel.widthAnchor.constraint(equalToConstant: 220),
//
//            timeLabel.leadingAnchor.constraint(equalTo: habitLabel.leadingAnchor),
//
            counterLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            counterLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            counterLabel.heightAnchor.constraint(equalToConstant: 18),
            counterLabel.widthAnchor.constraint(equalToConstant: 188),
            
            doneView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            doneView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            doneView.widthAnchor.constraint(equalToConstant: 38),
            doneView.heightAnchor.constraint(equalToConstant: 38),

            checkmarkImageView.centerXAnchor.constraint(equalTo: doneView.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: doneView.centerYAnchor)
            
        ])
        
    }
    
    var tempHabit: Habit?


    func setup(with habit: Habit) {
        
        habitLabel.text = habit.name
        habitLabel.textColor = habit.color
        timeLabel.text = habit.dateString
        counterLabel.text = "Счётчик: \(habit.trackDates.count)"
        doneView.layer.borderColor = habit.color.cgColor



        if habit.isAlreadyTakenToday {
            doneView.backgroundColor = habit.color
            doneView.isUserInteractionEnabled = false
        } else {
            tempHabit = habit
            doneView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            doneView.addGestureRecognizer(tapGesture)
            doneView.backgroundColor = .white


            
            
            
        }
        
        //        photoImageView.image = UIImage(named: photo.photo)
    }
    
    @objc func handleTap() {
        guard let habit = self.tempHabit else {
            return
        }
        //        if habit.isAlreadyTakenToday == false {
        HabitsStore.shared.track(habit)
        doneView.backgroundColor = .yellow
        doneView.isUserInteractionEnabled = false
        HabitsViewController.collectionView.reloadData()

        //        }
    }
    
}






