//
//  InvoiceDetailsUseCase.swift
//  mahfazati
//
//  Created by FIT on 12/09/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

protocol UsersLogOffUseCaseProtocol {
    func UsersLogOff(requestModel: UsersLogOffRequestModel, completion: @escaping(Result<UsersLogOffUIModel, NetworkError>) -> Void) async
}

class UsersLogOffUseCase {
    private let repository: MenuRepositoryProtocol
    init(repository: MenuRepositoryProtocol = MenuRepository()) {
        self.repository = repository
    }
}

extension UsersLogOffUseCase: UsersLogOffUseCaseProtocol {
    func UsersLogOff(requestModel: UsersLogOffRequestModel, completion: @escaping (Result<UsersLogOffUIModel, NetworkError>) -> Void) async {
        let route = MenuRoute.UsersLogOff(requestModel: requestModel)
        await repository.UsersLogOff(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = UsersLogOffUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
