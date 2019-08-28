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
    var popTransition = PopTransition()
    var elementInsets = UIEdgeInsets()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureMomentsCollectionView()
        configureHeader()
        configureButtons()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    /// Initial Setup
    private func configureMomentsCollectionView() {

        let layout = MomentsFlowLayout(containerViewFrame: view.frame)
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
    private func configureHeader() {
        
        // Use itemSize of UICollectionViewFlowLayout to calculate placement of header.
        let cellSize = (momentsCollectionView?.collectionViewLayout as! MomentsFlowLayout).currentItemSize
        
        let momentsLabel = UILabel(frame: CGRect(x: 35, y: 80, width: self.view.frame.width, height: 70))
        momentsLabel.text = "Try it"
        momentsLabel.font = UIFont.systemFont(ofSize: 39, weight: .bold)
        momentsLabel.textColor = .white
        
        let captionLabel = UILabel()
        captionLabel.lineBreakMode = .byWordWrapping
        captionLabel.numberOfLines = 0
        captionLabel.preferredMaxLayoutWidth = cellSize.width
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
        let collectionViewLayout = momentsCollectionView?.collectionViewLayout as! MomentsFlowLayout
        let cellCenterXOffset = collectionViewLayout.cellCenterXOffset // Amount the cell is shifted horizontally from center
        let leadingEdgeOfFocusedCell = (view.frame.width - cellSize.width) / 2 + cellCenterXOffset
        let trailingEdgeOfFocusedCell = leadingEdgeOfFocusedCell + cellSize.width

        let availableSpaceForLabel = momentsCollectionView!.contentInset.top
        let labelPositionBetweenCellAndTop = 0.35 // 35 % down from the top of the available space
        let labelTopInset = availableSpaceForLabel * 0.35 // Sets the label to start at 35%
        
        elementInsets.left = leadingEdgeOfFocusedCell
        elementInsets.right = leadingEdgeOfFocusedCell
        elementInsets.top = labelTopInset
        elementInsets.bottom = labelTopInset * 1.7

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOfFocusedCell).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingEdgeOfFocusedCell).isActive = true
        stackView.topAnchor.constraint(equalTo: momentsCollectionView!.topAnchor, constant: labelTopInset).isActive = true
        stackView.bottomAnchor.constraint(equalTo: momentsCollectionView!.bottomAnchor, constant: -((momentsCollectionView!.frame.size.height-cellSize.height)/2) - cellSize.height - labelTopInset + availableSpaceForLabel).isActive = true
        
        headerView = stackView
        
    }
    private func configureButtons() {
        
        // Use itemSize of UICollectionViewFlowLayout to calculate placement of header.
        let currentLayoutItemSize = (momentsCollectionView?.collectionViewLayout as! MomentsFlowLayout).currentItemSize
        
        /// Shop Button
        let shopButtonSize: CGFloat = 60
        let shopButton = UIButton(frame: CGRect(x: 0, y: 0, width: shopButtonSize, height: shopButtonSize))
        let shopButtonImage = UIImage(named: "shopButton")
        shopButton.setImage(shopButtonImage, for: .normal)
        shopButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        shopButton.layer.masksToBounds = false
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
        arButton.layer.masksToBounds = false
        arButton.layer.cornerRadius = shopButton.frame.width / 2
        
        let arButtonContainer = UIView()
        view.addSubview(arButtonContainer)
        arButtonContainer.addSubview(arButton)
        
        arButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        arButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -elementInsets.bottom).isActive = true
        arButtonContainer.leadingAnchor.constraint(equalTo: headerView!.leadingAnchor, constant: currentLayoutItemSize.width + (currentLayoutItemSize.width * 0.15) - arButtonSize).isActive = true
        arButtonContainer.widthAnchor.constraint(equalToConstant: arButtonSize).isActive = true
        arButtonContainer.heightAnchor.constraint(equalToConstant: arButtonSize).isActive = true
    }
    
    /// Custom Methods for Presenting Stories
    private func presentViewController(from cell: UICollectionViewCell, at indexPath: IndexPath) {
        scrollToItem(at: indexPath) // In case the user selects a cell that is not the focused cell, this will scroll it to the front
        let moment = momentsData[indexPath.row]
        let story = createViewControllerToPresent(with: moment, from: cell)
        present(story, animated: true, completion: nil)
    }
    
    // In case the user selects a cell that is not the focused cell, use this to scroll it to the front
    private func scrollToItem(at indexPath: IndexPath) {
        guard let collectionView = momentsCollectionView else { return }
        let layout = collectionView.collectionViewLayout as! MomentsFlowLayout
        let itemWidth = layout.currentItemSize.width
        let lineSpacing = layout.lineSpacingBetweenCells
        let insetX = (collectionView.bounds.size.width - itemWidth)/2
        let offsetX = CGFloat(indexPath.row) * (itemWidth + lineSpacing) - insetX
        let offsetY = collectionView.contentOffset.y // unchanged
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: offsetY), animated: true)
        
        collectionView.focusedCell = collectionView.cellForItem(at: indexPath) // Setting this allows the popTransition to ask it for its frame right before dismissal. Asking for the frame now would be incorrect because the content may not have finished scrolling yet.
    }
    
    private func createViewControllerToPresent(with moment: MomentCardData, from cell: UICollectionViewCell) -> MomentStoriesViewController {
        let story = MomentStoriesViewController()
        story.moment = moment
        story.transitioningDelegate = popTransition
        applyTransitionStartingFrame(from: cell)
        return story
    }
    
    private func applyTransitionStartingFrame(from cell: UICollectionViewCell) {
        let cellCurrentPresentationFrame = cell.convert(cell.contentView.layer.presentation()!.frame, to: nil)
        popTransition.startingCardFrame = cellCurrentPresentationFrame
        popTransition.startingCardCornerRadius = cell.contentView.layer.presentation()!.cornerRadius
        popTransition.presentedCell = cell
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
        guard let cell = collectionView.cellForItem(at: indexPath) else { fatalError("cell nil")}
        presentViewController(from: cell, at: indexPath)
    }

    // Scrolling unhighlights a cell
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let cell = momentsCollectionView?.highlightedCell {
            momentsCollectionView?.unhighlight(cell: cell)
        }
    }
    
    // After highlighting a cell by catching it, letting it go without velocity (which cancels a highlight) will pop it open.
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        guard let momentsCollectionView = momentsCollectionView else { fatalError("momentsCollectionView nil")}
        if let cell = momentsCollectionView.highlightedCell {
            momentsCollectionView.unhighlight(cell: cell)
            guard let indexPath = momentsCollectionView.indexPath(for: cell) else { fatalError("indexPath nil") }
            presentViewController(from: cell, at: indexPath)
        }
    }

}
