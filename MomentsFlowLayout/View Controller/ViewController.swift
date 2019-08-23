//
//  ViewController.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-17.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var momentsDemoData = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
    var momentsData: [MomentCardData] = [
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo1")!, heading: "Relax", caption: "One Touch, All the lights", preferredCardLayout: MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.7)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo1")!, heading: "Relax", caption: "One Touch, All the lights", preferredCardLayout: MomentCardLayout(textAlignment: .right, headerAndCaptionVerticalCenterPercentage: 0.7)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo1")!, heading: "Relax", caption: "One Touch, All the lights", preferredCardLayout: nil)
    ]
    var momentsCollectionView: UICollectionView?
    var headerStackView: UIStackView?
    var currentLayoutItemSize: CGSize = CGSize.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureMomentsCollectionView()
//        configureHeader()
//        configureButtons()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureMomentsCollectionView() {

        let layout = MomentsFlowLayout(superViewFrame: view.frame)
//        let layout = UICollectionViewFlowLayout()
        momentsCollectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        
        guard let momentsCollectionView = momentsCollectionView else { fatalError("collectionView nil") }
        momentsCollectionView.decelerationRate = .fast
        momentsCollectionView.dataSource = self
        momentsCollectionView.delegate = self
        momentsCollectionView.register(MomentsCardCell.self, forCellWithReuseIdentifier: MomentsCardCell.identifier)
        
        view.addSubview(momentsCollectionView)
        momentsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        momentsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        momentsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        momentsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        momentsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func configureHeader() {
        
        currentLayoutItemSize = (momentsCollectionView?.collectionViewLayout as! MomentsFlowLayout).currentItemSize
        
        let momentsLabel = UILabel(frame: CGRect(x: 35, y: 80, width: self.view.frame.width, height: 70))
        momentsLabel.text = "Try it"
        momentsLabel.font = UIFont.systemFont(ofSize: 39, weight: .bold)
        momentsLabel.textColor = .white
//        momentsLabel.backgroundColor = .blue
        
        let captionLabel = UILabel()
        captionLabel.lineBreakMode = .byWordWrapping
        captionLabel.numberOfLines = 0
        captionLabel.preferredMaxLayoutWidth = currentLayoutItemSize.width
        captionLabel.text = "Browse to explore how home \nautomation can simply your life"
        captionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        captionLabel.textColor = .white
//        captionLabel.backgroundColor = .purple

        
        let stackView = UIStackView(arrangedSubviews: [momentsLabel, captionLabel])
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
    
        self.view.addSubview(stackView)
        
        let leadingEdgeOfFocusedCell = (view.frame.width - currentLayoutItemSize.width)/2 - 16
        let trailingEdgeOfFocusedCell = leadingEdgeOfFocusedCell + currentLayoutItemSize.width

        let amountCellShiftedDown = momentsCollectionView!.contentInset.top
        let labelInsetAmounts = amountCellShiftedDown*0.35
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOfFocusedCell).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingEdgeOfFocusedCell).isActive = true
        stackView.topAnchor.constraint(equalTo: momentsCollectionView!.topAnchor, constant: labelInsetAmounts).isActive = true
        stackView.bottomAnchor.constraint(equalTo: momentsCollectionView!.bottomAnchor, constant: -currentLayoutItemSize.height-((momentsCollectionView!.frame.size.height-currentLayoutItemSize.height)/2)+amountCellShiftedDown-labelInsetAmounts).isActive = true
        
        headerStackView = stackView
        
    }
    func configureButtons() {
        
        /// Shop Button
        let shopButtonSize: CGFloat = 60
        let shopButton = UIButton(frame: CGRect(x: 0, y: 0, width: shopButtonSize, height: shopButtonSize))
        let shopButtonImage = UIImage(named: "shopButton")
        shopButton.setImage(shopButtonImage, for: .normal)
        shopButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        shopButton.layer.shadowColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        shopButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        shopButton.layer.masksToBounds = false
        shopButton.layer.shadowRadius = 14
        shopButton.layer.shadowOpacity = 0.6
        shopButton.layer.cornerRadius = shopButton.frame.width / 2
        
        let shopButtonContainer = UIView()
        view.addSubview(shopButtonContainer)
        shopButtonContainer.addSubview(shopButton)
        
        shopButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        shopButtonContainer.topAnchor.constraint(equalTo: headerStackView!.topAnchor, constant: 5).isActive = true
        shopButtonContainer.leadingAnchor.constraint(equalTo: headerStackView!.leadingAnchor, constant: currentLayoutItemSize.width + (currentLayoutItemSize.width * 0.15) - shopButtonSize).isActive = true
        shopButtonContainer.widthAnchor.constraint(equalToConstant: shopButtonSize).isActive = true
        shopButtonContainer.heightAnchor.constraint(equalToConstant: shopButtonSize).isActive = true

        /// AR Button
        let arButtonSize: CGFloat = 60
        let arButton = UIButton(frame: CGRect(x: 0, y: 0, width: arButtonSize, height: arButtonSize))
        let arButtonImage = UIImage(named: "colorsButton")
        arButton.setImage(arButtonImage, for: .normal)
        arButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        arButton.layer.shadowColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        arButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        arButton.layer.masksToBounds = false
        arButton.layer.shadowRadius = 14
        arButton.layer.shadowOpacity = 0.6
        arButton.layer.cornerRadius = shopButton.frame.width / 2
        
        let arButtonContainer = UIView()
        view.addSubview(arButtonContainer)
        arButtonContainer.addSubview(arButton)
        
        arButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        arButtonContainer.topAnchor.constraint(equalTo: headerStackView!.topAnchor, constant: view.frame.height * 0.80).isActive = true
        arButtonContainer.leadingAnchor.constraint(equalTo: headerStackView!.leadingAnchor, constant: currentLayoutItemSize.width + (currentLayoutItemSize.width * 0.15) - arButtonSize).isActive = true
        arButtonContainer.widthAnchor.constraint(equalToConstant: arButtonSize).isActive = true
        arButtonContainer.heightAnchor.constraint(equalToConstant: arButtonSize).isActive = true
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Collection View DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return momentsData.count
        return momentsDemoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MomentsCardCell.identifier, for: indexPath) as! MomentsCardCell
//        let moment = momentsData[indexPath.row]
//        cell.configure(with: moment)
//        cell.backgroundColor = momentsData[indexPath.row].backgroundColor
        
        cell.backgroundColor = momentsDemoData[indexPath.row]
        
//        switch indexPath.row {
//        case 0:
//            cell.imageView.image = UIImage(named: "demo1")
//            cell.imageView.contentMode = .scaleAspectFill
//        case 1:
//            cell.imageView.image = UIImage(named: "demo2")
//            cell.imageView.contentMode = .scaleAspectFill
//        case 2:
//            cell.imageView.image = UIImage(named: "demo3")
//            cell.imageView.contentMode = .scaleAspectFill
//        case 3:
//            cell.imageView.image = UIImage(named: "demo4")
//            cell.imageView.contentMode = .scaleAspectFill
//        case 4:
//            cell.imageView.image = UIImage(named: "demo5")
//            cell.imageView.contentMode = .scaleAspectFill
//        case 5:
//            cell.imageView.image = UIImage(named: "demo6")
//            cell.imageView.contentMode = .scaleAspectFill
//        case 6:
//            cell.imageView.image = UIImage(named: "demo7")
//            cell.imageView.contentMode = .scaleAspectFill
//        case 7:
//            cell.imageView.image = UIImage(named: "demo8")
//            cell.imageView.contentMode = .scaleAspectFill
//        default:
//            cell.imageView.image = nil
//            return cell
//        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItem at \(indexPath.row)")
    }

}

