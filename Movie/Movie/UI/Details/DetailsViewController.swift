//
//  DetailsViewController.swift
//  Movies
//
//  Created by Camila Storck on 20/03/2024.
//

import SwiftUI

final class DetailsViewController: UIHostingController<DetailsView> {
    
    private let _view: DetailsView
    weak var coordinator: MoviesCoordinator?
    
    init(viewModel: DetailsViewModel) {
        _view = DetailsView(viewModel: viewModel)
        super.init(rootView: _view)
        viewModel.delegate = self
    }
    
    @MainActor
    required dynamic init?(coder aDecoder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
}

extension DetailsViewController: DetailsDelegate {
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
