//
//  SetupCategoryView.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit
import SnapKit

protocol SetupCategoryViewDelegate: AnyObject {
    func textFieldDidChangeValue(text: String?)
    func getSelectedRowForColor() -> Int
    func cellSelectedForCategory(indexPathRow: Int)
    func cellSelectedForColor(indexPathRow: Int)
    func reloadData()
    func getSelectedRowForCategory() -> Int
}

class SetupCategoryView: UIView {
    
    weak var delegate: SetupCategoryViewDelegate?
    private var bottomConstraint: Constraint?
    
    private lazy var actionButton: BaseButton = {
        let button = BaseButton(title: "Создать")
        button.actionState = .inactive
        return button
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = BaseInputTextField(placeholder: "Название категории")
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    lazy var categoriesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: CGFloat(MediumCollectionItemTopInset), left: CGFloat(MediumPadding), bottom: CGFloat(SmallCollectionItemBottomInset), right: CGFloat(MediumPadding))
        layout.minimumInteritemSpacing = CGFloat(MediumInteritemSpacing)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .background
        view.register(SetupCategoryCell.self, forCellWithReuseIdentifier: "SetupCategoryCell")
        view.delegate = self
        
        return view
    }()
    
    lazy var colorsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: CGFloat(MediumCollectionItemTopInset), left: CGFloat(MediumPadding), bottom: CGFloat(SmallCollectionItemBottomInset), right: CGFloat(MediumPadding))
        layout.minimumInteritemSpacing = CGFloat(SmallInteritemSpacing)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .background
        view.register(SetupColorCell.self, forCellWithReuseIdentifier: "SetupColorCell")
        view.delegate = self
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .background
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        
        addSubviews()
        setConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        addSubview(categoriesCollectionView)
        addSubview(colorsCollectionView)
        addSubview(actionButton)
        addSubview(nameTextField)
    }
    
    func getCategoryName() -> String? {
        nameTextField.text
    }
    
    func getIconName() -> String? {
        nameTextField.text
    }
    
    func getIconColor() -> String? {
        nameTextField.text
    }
    func updateBottomInset(valueInset: CGFloat) {
        bottomConstraint?.update(inset: valueInset)
    }
    
    private func setConstraints() {
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
            bottomConstraint = make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(MediumPadding).constraint
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(LargePadding)
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(TableViewCellHeight)
        }
        
        colorsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(SmallPadding)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(60)
        }
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(colorsCollectionView.snp.bottom).offset(MediumPadding)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(actionButton.snp.top).offset(MediumPadding)
        }

    }
    
    private func addTargets() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChangeValue), for: .editingChanged)
    }
    
    func addButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        actionButton.addTarget(target, action: action, for: controlEvents)
    }
    
    @objc func textFieldDidChangeValue() {
        delegate?.textFieldDidChangeValue(text: nameTextField.text)
    }
    
       
    public func updateActionButtonState(actionState: BaseButtonState) {
        actionButton.actionState = actionState
    }
}

extension SetupCategoryView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView === categoriesCollectionView) {
            return SetupCategoryIconImages.icons.count
        } else {
            return SetupCategoryIconColors.colors.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView === categoriesCollectionView) {
            guard let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "SetupCategoryCell", for: indexPath) as? SetupCategoryCell else {
                return UICollectionViewCell()
            }
            
            cell.configurate(iconName: SetupCategoryIconImages.icons[indexPath.row], iconColor: SetupCategoryIconColors.colors[delegate?.getSelectedRowForColor() ?? 0])
            cell.layer.cornerRadius = CGFloat(cell.bounds.width / 2)
            
            let row = delegate?.getSelectedRowForCategory()
            
            DispatchQueue.main.async {
                if indexPath.row == row {
                    cell.isSelected = true
                    self.delegate?.cellSelectedForCategory(indexPathRow: indexPath.row)
                } else {
                    cell.isSelected = false
                }
            }
            
            return cell
        } else {
            guard let cell = colorsCollectionView.dequeueReusableCell(withReuseIdentifier: "SetupColorCell", for: indexPath) as? SetupColorCell else {
                return UICollectionViewCell()
            }
            
            cell.layer.cornerRadius = CGFloat(cell.bounds.width / 2)
            let row = delegate?.getSelectedRowForColor()
            
            DispatchQueue.main.async {
                if indexPath.row == row {
                    cell.isSelected = true
                    self.delegate?.cellSelectedForColor(indexPathRow: indexPath.row)
                } else {
                    cell.isSelected = false
                }
            }
            
            cell.configurate(iconName: "", iconColor: SetupCategoryIconColors.colors[indexPath.row])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView === categoriesCollectionView) {
            let row = delegate?.getSelectedRowForCategory() ?? 0
            DispatchQueue.main.async {
                collectionView.cellForItem(at: IndexPath(row: row, section: 0))?.isSelected = false
            }
            delegate?.cellSelectedForCategory(indexPathRow: indexPath.row)
        } else {
            let row = delegate?.getSelectedRowForColor() ?? 0
            DispatchQueue.main.async {
                collectionView.cellForItem(at: IndexPath(row: row, section: 0))?.isSelected = false
            }
            delegate?.cellSelectedForColor(indexPathRow: indexPath.row)
            delegate?.reloadData()
        }
    }
    
}

extension SetupCategoryView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView === categoriesCollectionView) {
            let widthCollectionView = collectionView.bounds.size.width
            let contentViewWidth = widthCollectionView - CGFloat(MediumPadding) * 2
            let itemInsets = CGFloat(MediumInteritemSpacing * 5)
            let totalItemsWidth = contentViewWidth - itemInsets
            let itemWidth = totalItemsWidth / 6
            
            return CGSize(width: itemWidth, height: itemWidth)
        } else {
            let widthCollectionView = collectionView.bounds.size.width
            let contentViewWidth = widthCollectionView - CGFloat(MediumPadding) * 2
            let itemInsets = CGFloat(SmallInteritemSpacing * 7)
            let totalItemsWidth = contentViewWidth - itemInsets
            let itemWidth = totalItemsWidth / 8
            
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
}

extension SetupCategoryView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
