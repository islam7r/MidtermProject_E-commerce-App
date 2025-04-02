//
//  ViewController.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 19.03.25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var nextImageView: UIImageView!
    
    
    private var indexNum: Int = 0
    private var timer: Timer? = nil
    private var timeLeft: Int = 10
    
    private var shapeLayer = CAShapeLayer()
    private var totalTime: TimeInterval = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextButtonView.clipsToBounds = true
        nextButtonView.layer.cornerRadius = nextButtonView.frame.height / 2
        nextButtonView.backgroundColor = .clear
        
        nextImageView.isUserInteractionEnabled = true
        let nextTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextImageTapped))
        nextImageView.addGestureRecognizer(nextTapGestureRecognizer)
        
        backImageView.isUserInteractionEnabled = true
        let backTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backImageTapped))
        backImageView.addGestureRecognizer(backTapGestureRecognizer)
        
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.baseBackgroundColor = UIColor.clear
        buttonConfig.baseForegroundColor = UIColor.white
        buttonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            return outgoing
        })
        nextButton.configuration = buttonConfig
        
       
       
        
        updateUI()
        setupStrokeLayer()
        startTimerAnimation()
        startTimer()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupStrokeLayer()
    }
    
    @objc private func nextImageTapped(){
        indexNum += 1
        updateUI()
        resetTimerAnimation()
        print(indexNum)
    }
    
    @objc private func backImageTapped(){
        indexNum -= 1
        updateUI()
        resetTimerAnimation()
        print(indexNum)
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton!){
        indexNum += 1
        updateUI()
        resetTimerAnimation()
    }
    


}

extension ViewController{
    
    private func updateUI(){
        if indexNum == 0{
            backImageView.alpha = 0
            titleLabel.text = "Cool Product"
            subtitleLabel.text = "We create products in collaboration with great designers who are there to get the coolest products for you."
            nextButton.setTitle("Keç", for: .normal)
        }else if indexNum == 1{
            backImageView.alpha = 1
            titleLabel.text = "Latest Style"
            subtitleLabel.text = "The latest styles according to the latest trends to ensure you get the best and coolest products."
            nextButton.setTitle("Keç", for: .normal)
        }else if indexNum == 2{
            backImageView.alpha = 1
            titleLabel.text = "All For You"
            subtitleLabel.text = "We always try provide the cool products and latest styles by maintaining the best quality for you."
            nextButton.setTitle("Başla", for: .normal)
        }else{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController{
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            
        }
    }
    
    
    private func setupStrokeLayer(){
        let centerPoint = CGPoint(x: nextButtonView.bounds.midX, y: nextButtonView.bounds.midY)
        let radius = nextButtonView.bounds.width / 2 - 4
        
        let circlePath = UIBezierPath(
            arcCenter: centerPoint,
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: 1.5 * CGFloat.pi,
            clockwise: true
        )
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 1
        
        nextButtonView.layer.addSublayer(shapeLayer)
    }
    private func startTimer(){
        timeLeft = 10
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.timeLeft -= 1
            if self.timeLeft == 0 {
                self.timer?.invalidate()
                self.indexNum += 1
                self.updateUI()
                self.resetTimerAnimation()
            }
        })
    }
    
    private func startTimerAnimation(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = totalTime
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        shapeLayer.add(animation, forKey: "strokeAnimation")
    }
    
    
    private func resetTimerAnimation(){
        shapeLayer.removeAllAnimations()
        shapeLayer.strokeEnd = 1
        startTimerAnimation()
        startTimer()
    }
    
    
}

