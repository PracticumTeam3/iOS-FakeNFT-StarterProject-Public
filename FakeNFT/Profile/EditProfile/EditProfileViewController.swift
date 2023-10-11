//
//  EditProfileViewController.swift
//  FakeNFT
//
//  Created by Artem Novikov on 05.10.2023.
//

import UIKit

// MARK: - EditProfileViewController
final class EditProfileViewController: UIViewController {

    // MARK: - Private properties
    private let editProfileView: EditProfileView
    private let viewModel: ProfileViewModel

    private var isProfileEdited: Bool {
        let oldProfileModel = EditProfileModel(
            name: viewModel.model?.name ?? "",
            description: viewModel.model?.description ?? "",
            website: viewModel.model?.website ?? ""
        )
        let newProfileModel = editProfileView.editProfileModel
        return oldProfileModel != newProfileModel
    }

    // MARK: - Initializers
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        self.editProfileView = EditProfileView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        presentationController?.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func loadView() {
        view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        editProfileView.closeButton.addTarget(self, action: #selector(onCloseButtonTap), for: .touchUpInside)
    }

    // MARK: - Private methods
    @objc private func onCloseButtonTap() {
        closeAction()
    }

    private func showAlert() {
        AlertPresenter.show(in: self, model: .confirmChanging(
            agreeCompletion: { [weak self] in
                guard let self else { return }
                self.viewModel.editProfile(editProfileModel: self.editProfileView.editProfileModel)
                self.dismiss(animated: true)
            },
            cancelCompletion: { [weak self] in
                self?.dismiss(animated: true)
            })
        )
    }

    private func closeAction() {
        if isProfileEdited {
            showAlert()
        } else {
            dismiss(animated: true)
        }
    }

}

// MARK: - UIAdaptivePresentationControllerDelegate
extension EditProfileViewController: UIAdaptivePresentationControllerDelegate {

    func presentationControllerShouldDismiss(
        _ presentationController: UIPresentationController
    ) -> Bool {
        !isProfileEdited
    }

    public func presentationControllerDidAttemptToDismiss(
        _ presentationController: UIPresentationController
    ) {
        closeAction()
    }

}
