import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var scoreLabel: UILabel!
    var currentAnswer: UITextField!
    var letterButtons = [UIButton]()
    var correctString = 0
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        //ScoreLabelDefaults
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score:0"
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)
        //ClueLabelDefaults
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.text = "CLUES"
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)
        //AnswerLabelDefaults
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.numberOfLines = 0
        view.addSubview(answersLabel)
        //CurrentAnswerTextFieldDefaults
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        currentAnswer.textAlignment = .center
        view.addSubview(currentAnswer)
        //Submit,ClearButtonsDefaults
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("SUBMIT",
                              for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        submitButton.addTarget(self,
                         action: #selector(submitTapped),
                         for: .touchUpInside)
        let clearButton = UIButton(type: .system)
        clearButton.setTitle("CLEAR",
                             for: .normal)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clearButton)
        clearButton.addTarget(self,
                        action: #selector(clearTapped),
                        for: .touchUpInside)
        //ButtonViewDefaults
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.layer.borderColor = UIColor.lightGray.cgColor
        buttonView.layer.borderWidth = 1
        view.addSubview(buttonView)
        NSLayoutConstraint.activate([
            //ScoreLabelConstraints
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            //AnswerLabelConstraints
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,
                                                   constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                multiplier: 0.4,
                                                constant: -100),
            //ClueLabelConstraints
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.widthAnchor,
                                              multiplier: 0.6,
                                              constant: -100),
            cluesLabel.heightAnchor.constraint(equalTo: answersLabel.heightAnchor),
            //CurrentAnswerTextFieldConstraints
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor,
                                               constant: 20),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                 multiplier: 0.5),
            //Submit,ClearButtonsConstraints
            submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor,
                                                  constant: -100),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            clearButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor,
                                                 constant: 100),
            clearButton.heightAnchor.constraint(equalToConstant: 44),
            //ButtonViewContsraints
            buttonView.widthAnchor.constraint(equalToConstant: 750),
            buttonView.heightAnchor.constraint(equalToConstant: 320),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: submitButton.bottomAnchor,
                                            constant: 20),
            buttonView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                               constant: -20)
            
        ])
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1),
                                             for: .vertical)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1),
                                               for: .vertical)
        let height = 80
        let width = 150
        for row in 0..<4 {
            for column in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW",
                                      for: .normal)
                let frame = CGRect(x: column*width,
                                   y: row*height,
                                   width: width,
                                   height: height)
                letterButton.frame = frame
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.layer.borderWidth = 1
                buttonView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self,
                                       action: #selector(letterTapped),
                                       for: .touchUpInside)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(loadLevel), with: nil)
    }
    @objc func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
            if let levelFileURL = Bundle.main.url(forResource: "level\(level)",
                                                  withExtension: "txt") {
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()
                    for (index,line) in lines.enumerated() {
                        let parts = line.components(separatedBy: ": ")
                        let answer = parts[0]
                        let clue = parts[1]
                        clueString += "\(index+1). \(clue)\n"
                        let solutionWord = answer.replacingOccurrences(of: "|",
                                                                        with: "")
                        solutionString += "\(solutionWord.count) letters\n"
                        solutions.append(solutionWord)
                        let bits = answer.components(separatedBy: "|")
                        letterBits += bits
                    }
                }
            }
        DispatchQueue.main.async {
            [weak self] in
            self?.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            self?.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
            letterBits.shuffle()
            if letterBits.count == self?.letterButtons.count {
                for i in 0..<self!.letterButtons.count {
                    self?.letterButtons[i].setTitle(letterBits[i], for: .normal)
                }
            }
        }
    }
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            currentAnswer.text = ""
            score += 1
            correctString += 1
            if correctString % 7 == 0 {
                let ac = UIAlertController(title: "Well done",
                                           message: "Are you ready for the next level",
                                           preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go",
                                           style: .default,
                                           handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            if currentAnswer.text != "" {
                score-=1
                let ac = UIAlertController(title: "You are wrong",
                                           message: "That's not correct word",
                                           preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Try again",
                                           style: .default))
                present(ac, animated: true)
            }
        }
    }
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        performSelector(inBackground: #selector(loadLevel), with: nil)
        for button in letterButtons {
            button.isHidden = false
        }
        
    }
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
    }
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
}

