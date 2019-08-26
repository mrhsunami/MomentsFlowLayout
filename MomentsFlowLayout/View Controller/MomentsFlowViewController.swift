//
//  MomentsFlowViewController.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-17.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentsFlowViewController: UIViewController {

    var momentsData: [MomentCardData] = DemoDataStore.momentsData
    var momentsCollectionView: MomentsCollectionView?
    var headerView: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureMomentsCollectionView()
        configureHeader()
        configureButtons()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    func configureMomentsCollectionView() {

        let layout = MomentsFlowLayout(superViewFrame: view.frame)
        momentsCollectionView = MomentsCollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        
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
        
        let captionLabel = UILabel()
        captionLabel.lineBreakMode = .byWordWrapping
        captionLabel.numberOfLines = 0
        captionLabel.preferredMaxLayoutWidth = currentLayoutItemSize.width
        captionLabel.text = "Browse to explore how home \nautomation can simplify your life"
        captionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        captionLabel.textColor = .white

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

extension MomentsFlowViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let story = MomentStoriesViewController()
        present(story, animated: true, completion: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let cell = momentsCollectionView?.highlightedCell {
            momentsCollectionView?.unhighlight(cell: cell)
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if let cell = momentsCollectionView?.highlightedCell {
            momentsCollectionView?.unhighlight(cell: cell)
            let story = MomentStoriesViewController()
            present(story, animated: true, completion: nil)
        }
    }

}
