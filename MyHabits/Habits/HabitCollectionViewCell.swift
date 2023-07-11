import UIKit


class HabitCollectionViewCell: UICollectionViewCell {
    
    static let id = "HabitCollectionViewCell"
    
    
    var habitLabel: UILabel = {
        let habitLabel = UILabel()
        habitLabel.translatesAutoresizingMaskIntoConstraints = false
        habitLabel.numberOfLines = 2
        habitLabel.lineBreakMode = .byTruncatingTail
        habitLabel.textAlignment = .left

        
        return habitLabel
    }()
    
    
    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        return timeLabel
    }()
    
    
    var counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        return counterLabel
    }()
    
    
    
    lazy var doneView: UIView = {
        let doneView = UIView()
        doneView.translatesAutoresizingMaskIntoConstraints = false
        //        doneView.frame = CGRect(x: 0, y: 0, width: 76, height: 76)
        doneView.layer.cornerRadius = 19
        doneView.layer.masksToBounds = true
              doneView.isUserInteractionEnabled = true
//                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//                doneView.addGestureRecognizer(tapGesture)
//        doneView.addGestureRecognizer(tapGesture)


        return doneView
    }()

//    let tapGesture = UITapGestureRecognizer(target: HabitCollectionViewCell.self, action: #selector(handleTap))

    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        
        setupView()
        setupConstraints()


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        contentView.addSubview(habitLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(doneView)
        
        backgroundColor = .white
        layer.cornerRadius = 8
        
    }
    func setupConstraints() {
        
        let safeAreaLayoutGuide = contentView.safeAreaLayoutGuide
        
        
        NSLayoutConstraint.activate([
            
            habitLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            habitLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            habitLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -16),
            habitLabel.widthAnchor.constraint(equalToConstant: 220),
            
            // Progress Label constraints
            timeLabel.leadingAnchor.constraint(equalTo: habitLabel.leadingAnchor),
            
            // Progress View constraints
            counterLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            counterLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            counterLabel.heightAnchor.constraint(equalToConstant: 18),
            
            doneView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -38),
            doneView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            doneView.widthAnchor.constraint(equalToConstant: 38),
            doneView.heightAnchor.constraint(equalToConstant: 38)
            
        ])
        
    }
    
    var tempHabit: Habit?


    func setup(with habit: Habit) {
        
        habitLabel.text = habit.name
        timeLabel.text = habit.dateString
        counterLabel.text = "\(habit.trackDates.count)"
        doneView.backgroundColor = habit.color


//        if habit.isAlreadyTakenToday {
//
//            doneView.backgroundColor = .yellow
//            tapGesture.isEnabled = false
//        } else {
//            tempHabit = habit
//            tapGesture.isEnabled = true
//
//
////            doneView.isUserInteractionEnabled = true
////            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
////            doneView.addGestureRecognizer(tapGesture)
//        }





        if habit.isAlreadyTakenToday {
            doneView.backgroundColor = .yellow
            doneView.isUserInteractionEnabled = false
        } else {
            tempHabit = habit
            doneView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            doneView.addGestureRecognizer(tapGesture)
            doneView.backgroundColor = habit.color
            
            
            
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






