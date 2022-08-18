//
//  WalletsListView.swift
//  Wallet
//
//  Created by Danila on 11.08.2022.
//

import UIKit
import WalletDesignKit

protocol WalletsScreenViewDelegate: AnyObject {
    func didTapWallet(at row: Int)
    func getWallet(at: Int) -> WalletViewModel?
    func getNumberOfRows() -> Int
}

class WalletsScreenView: UIView {
    weak var delegate: WalletsScreenViewDelegate?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.tintColor = .inputPlaceholderColor
        return refreshControll
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.isHidden = true
        activityIndicatorView.color = .darkTextPrimaryColor
        return activityIndicatorView
    }()
    
    private lazy var actionButton: BaseButton = {
        let button = BaseButton(title: "Создать кошелёк")
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        
        let config = UIImage.SymbolConfiguration(pointSize: CGFloat(ExitButtonSize), weight: .bold, scale: .large)
        let iconImage = UIImage(systemName: "rectangle.portrait.and.arrow.right", withConfiguration: config)?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)

        button.setImage(iconImage, for: .normal)
        
        return button
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .activeButtonBackground
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = CGFloat(MediumPadding)
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private lazy var commonBalanceLabel: UILabel = {
        let view = UILabel()
        view.text = "Общий баланс"
        view.font = .SFProMedium16
        view.textColor = .lightTextPrimaryColor
        view.alpha = 0.8
        return view
    }()
    
    private lazy var commonBalanceValue: UILabel = {
        let view = UILabel()
        view.text = "0,00"
        view.font = .SFProSemiBold32
        view.textColor = .lightTextPrimaryColor
        return view
    }()
    
    private lazy var commonIncomeLabel: UIView = BaseDottedText(color: .incomeColor, text: "Общий доход", textFont: .SFProRegular13)
    
    private lazy var commonIncomeValue: UILabel = {
        let view = UILabel()
        view.text = "0,00"
        view.font = .SFProMedium16
        view.textColor = .lightTextPrimaryColor
        return view
    }()
    
    private lazy var commonExpansesLabel: UIView = BaseDottedText(color: .designRedColor, text: "Общий расход", textFont: .SFProRegular13)
    
    private lazy var commonExpansesValue: UILabel = {
        let view = UILabel()
        view.text = "0,00"
        view.font = .SFProMedium16
        view.textColor = .lightTextPrimaryColor
        return view
    }()
    
    private lazy var emptyWalletsListLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас пока нет созданных кошельков"
        label.isHidden = true
        label.font = .SFProRegular16
        label.textColor = .darkTextPrimaryColor
        return label
    }()
    
    private lazy var walletsListView: UITableView = {
        let view = UITableView()
        view.register(WalletsListCell.self, forCellReuseIdentifier: "WalletsListCell")
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = nil
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .background
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateWalletsList() {
        walletsListView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func updateBalances(commonBalance: BalanceViewModel?, income: BalanceViewModel?, expanse: BalanceViewModel?) {
        // We shold update all values per update
        guard let common = commonBalance,
              let income = income,
              let expanse = expanse
        else { return }
        commonBalanceValue.text = common.toString()
        commonIncomeValue.text = income.toString()
        commonExpansesValue.text = expanse.toString()
    }
    
    private func addSubviews() {
        [
            loadingIndicator,
            emptyWalletsListLabel,
            walletsListView,
            actionButton,
            headerView
        ].forEach { self.addSubview($0) }
        
        [
            commonIncomeValue,
            commonIncomeLabel,
            commonBalanceValue,
            commonBalanceLabel,
            commonExpansesLabel,
            commonExpansesValue,
            exitButton
        ].forEach { headerView.addSubview($0) }
        walletsListView.addSubview(refreshControl)
    }
    
    private func setConstraints() {
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(MediumPadding)
        }
        
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(LargePadding)
            make.trailing.equalToSuperview().inset(MediumPadding)
        }
        
        commonBalanceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(MediumPadding)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(LargePadding)
        }
        
        commonBalanceValue.snp.makeConstraints { make in
            make.leading.equalTo(commonBalanceLabel.snp.leading)
            make.top.equalTo(commonBalanceLabel.snp.bottom)

        }
        
        commonIncomeLabel.snp.makeConstraints { make in
            make.top.equalTo(commonBalanceValue.snp.bottom).offset(LargePadding)
            make.leading.equalTo(commonBalanceValue.snp.leading)
        }
        
        commonIncomeValue.snp.makeConstraints { make in
            make.top.equalTo(commonIncomeLabel.snp.bottom).offset(SmallPadding)
            make.leading.equalTo(commonIncomeLabel.snp.leading)
        }
        
        commonExpansesLabel.snp.makeConstraints { make in
            make.top.equalTo(commonBalanceValue.snp.bottom).offset(LargePadding)
            make.leading.equalTo(snp.centerX)
        }
        
        commonExpansesValue.snp.makeConstraints { make in
            make.top.equalTo(commonExpansesLabel.snp.bottom).offset(SmallPadding)
            make.leading.equalTo(commonExpansesLabel.snp.leading)
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(commonIncomeValue.snp.bottom).offset(MediumPadding)
        }
        
        walletsListView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(actionButton.snp.top).offset(MediumPadding)
        }
        
        emptyWalletsListLabel.snp.makeConstraints { make in
            make.center.equalTo(walletsListView.snp.center)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalTo(walletsListView.snp.center)
        }
    }
    
    public func addrefreshControllTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        refreshControl.addTarget(target, action:action, for: controlEvents)
    }
    
    func addActionButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        actionButton.addTarget(target, action: action, for: controlEvents)
    }
    
    func addExitButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        exitButton.addTarget(target, action: action, for: controlEvents)
    }
    
    func changeLoadingIndicatorState(state: loadingIndicatorState) {
        switch state {
        case .loading:
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        case .stopped:
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimating()
        }
    }
    
    func changeWalletsList(isEmpty: Bool) {
        emptyWalletsListLabel.isHidden = isEmpty ? false : true
    }
}

extension WalletsScreenView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapWallet(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(TableViewCellHeight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WalletsListCell", for: indexPath) as? WalletsListCell else {
            return WalletsListCell()
        }
        guard let wallet = delegate?.getWallet(at: indexPath.row) else { return WalletsListCell() }
        
        cell.configure(with: wallet)
        
        return cell
    }
    
}
