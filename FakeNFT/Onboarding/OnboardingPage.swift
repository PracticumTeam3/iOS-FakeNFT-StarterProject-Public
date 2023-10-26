//
//  OnboardingPage.swift
//  FakeNFT
//
//  Created by Artem Novikov on 25.10.2023.
//

// MARK: - OnboardingPage
enum OnboardingPage {

    static let first = OnboardingViewController(props: .init(
        image: A.Images.Onboarding.page1.image,
        title: L.Onboarding.Page1.title,
        subtitle: L.Onboarding.Page1.subtitle,
        buttonText: nil
    ))

    static let second = OnboardingViewController(props: .init(
        image: A.Images.Onboarding.page2.image,
        title: L.Onboarding.Page2.title,
        subtitle: L.Onboarding.Page2.subtitle,
        buttonText: nil
    ))

    static let third = OnboardingViewController(props: .init(
        image: A.Images.Onboarding.page3.image,
        title: L.Onboarding.Page3.title,
        subtitle: L.Onboarding.Page3.subtitle,
        buttonText: L.Onboarding.Page3.button
    ))

}
