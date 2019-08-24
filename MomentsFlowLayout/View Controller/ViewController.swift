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
    var momentsData: [MomentCardData] = DemoDataStore.momentsData
    var momentsCollectionView: UICollectionView?
    var headerView: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureMomentsCollectionView()
        configureHeader()
        configureButtons()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureMomentsCollectionView() {

        let layout = MomentsFlowLayout(superViewFrame: view.frame)
        momentsCollectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        
        guard let momentsCollectionView = momentsCollectionView else { fatalError("collectionView nil") }
        momentsCollectionView.dataSource = self
        momentsCollectionView.register(MomentsCardCell.self, forCellWithReuseIdentifier: MomentsCardCell.identifier)
        momentsCollectionView.delegate = self
        momentsCollectionView.decelerationRate = .fast
        momentsCollectionView.delaysContentTouches = false
        
        view.addSubview(momentsCollectionView)
        
        // Autolayout
        momentsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        momentsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        momentsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        momentsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        momentsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func configureHeader() {
        
        // Use itemSize of UICollectionViewFlowLayout to calculate placement of header.
        let currentLayoutItemSize = (momentsCollectionView?.collectionViewLayout as! MomentsFlowLayout).currentItemSize
        
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

        // A UIStackView seemed like a good choice to group the two items. But it seems to limit how much customization is allowed for spacing between items in the stack. Especially when taking into account different device sizes.
        let stackView = UIStackView(arrangedSubviews: [momentsLabel, captionLabel])
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
    
        self.view.addSubview(stackView)
        
        // Align the header to the leading and trailing edge of the focused cell.
        let leadingEdgeOfFocusedCell = (view.frame.width - currentLayoutItemSize.width)/2 - 16 // the 16 represents the amount the cell is shifted towards the left from being exactly centered in the collection view.
        let trailingEdgeOfFocusedCell = leadingEdgeOfFocusedCell + currentLayoutItemSize.width

        let amountCellShiftedDown = momentsCollectionView!.contentInset.top
        let labelInsetAmounts = amountCellShiftedDown*0.35
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOfFocusedCell).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingEdgeOfFocusedCell).isActive = true
        stackView.topAnchor.constraint(equalTo: momentsCollectionView!.topAnchor, constant: labelInsetAmounts).isActive = true
        stackView.bottomAnchor.constraint(equalTo: momentsCollectionView!.bottomAnchor, constant: -currentLayoutItemSize.height-((momentsCollectionView!.frame.size.height-currentLayoutItemSize.height)/2)+amountCellShiftedDown-labelInsetAmounts).isActive = true
        
        headerView = stackView
        
    }
    func configureButtons() {
        
        // Use itemSize of UICollectionViewFlowLayout to calculate placement of header.
        let currentLayoutItemSize = (momentsCollectionView?.collectionViewLayout as! MomentsFlowLayout).currentItemSize
        
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
        shopButtonContainer.topAnchor.constraint(equalTo: headerView!.topAnchor, constant: 5).isActive = true
        shopButtonContainer.leadingAnchor.constraint(equalTo: headerView!.leadingAnchor, constant: currentLayoutItemSize.width + (currentLayoutItemSize.width * 0.15) - shopButtonSize).isActive = true
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
        arButtonContainer.topAnchor.constraint(equalTo: headerView!.topAnchor, constant: view.frame.height * 0.80).isActive = true
        arButtonContainer.leadingAnchor.constraint(equalTo: headerView!.leadingAnchor, constant: currentLayoutItemSize.width + (currentLayoutItemSize.width * 0.15) - arButtonSize).isActive = true
        arButtonContainer.widthAnchor.constraint(equalToConstant: arButtonSize).isActive = true
        arButtonContainer.heightAnchor.constraint(equalToConstant: arButtonSize).isActive = true
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Collection View DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return momentsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MomentsCardCell.identifier, for: indexPath) as! MomentsCardCell
        let moment = momentsData[indexPath.row]
        cell.configure(with: moment)
        return cell
    }
    
    // MARK: Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItem at \(indexPath.row)")
    }

}
