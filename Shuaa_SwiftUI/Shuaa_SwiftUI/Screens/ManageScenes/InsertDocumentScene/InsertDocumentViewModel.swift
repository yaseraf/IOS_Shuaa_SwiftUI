//
//  InsertDocumentViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation
import SwiftUI
import PhotosUI

class InsertDocumentViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    
    @Published var selectedIdCardSectionType: IDCardSectionType = .qatariID
    @Published var idNumber: String = ""
    @Published var passportNumber: String = ""
    @Published var expiryDate: String = ""
    @Published var passportExpiryDate: String = ""
    @Published var uploadScreenshotInputValue:String = ""
    var base64Image:String?
    var frontByteArray:[Int]?
    var backByteArray:[Int]?
    var passportByteArray:[Int]?
    @Published var frontImageName: String = ""
    @Published var backImageName: String = ""
    @Published var passportImageName: String = ""

    @Published var updateIdValidity3APIResult: APIResultType<Bool>?
    @Published var uploadClientDocumentsAPIResult: APIResultType<Bool>?
    
    @State private var authorizationStatus = PHAuthorizationStatus.notDetermined

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol, idNumber: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.idNumber = idNumber
        
        frontByteArray = []
        backByteArray = []
    }
}


// MARK: Routing
extension InsertDocumentViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func onSaveTap() {
        if selectedIdCardSectionType == .qatariID {
            callUpdateIdValidity3API(succecss: true)
        } else {
            callUploadClientDocumentsAPI(succecss: true)
        }
    }
}

// MARK: API Calls
extension InsertDocumentViewModel {
    func callUpdateIdValidity3API(succecss: Bool) {
        
        uploadClientDocumentsAPIResult = .onLoading(show: true)

        debugPrint("ID Number: \(idNumber)")
        debugPrint("expiry date: \(convertDateFormat(expiryDate))")
                
        let requestModel = UpdateIdValidity3RequestModel(
            clientID: KeyChainController().clientID ?? "",
            docType: selectedIdCardSectionType == .qatariID ? "ID1" : "ID2",
            fileName: frontImageName,
            fileName2: backImageName,
            fileType: ".png",
            fileType2: ".png",
            idNumber: idNumber,
            isBase64: "",
            imageFile: frontByteArray ?? [],
            imageFile2: backByteArray ?? [],
            issueDate: "",
            mainClientID: KeyChainController().mainClientID ?? "",
            requestID: 0,
            typeCode: "1",
            validityDate: convertDateFormat(expiryDate),
            webCode: KeyChainController().webCode ?? "",
            isIndivual: false
        )
        
        Task.init {
            await useCase.UpdateIdValidity3(requestModel: requestModel) {[weak self] result in
                self?.updateIdValidity3APIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.updateIdValidity3APIResult = .onSuccess(response: success)
                    if !success {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "failed_document".localized)
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "document_upload_success".localized)
                    }
                    self?.coordinator.popViewController()
                    
                case .failure(let failure):
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "failed_document".localized)
                    self?.updateIdValidity3APIResult = .onFailure(error: failure)
                }
            }
        }
    }

    func callUploadClientDocumentsAPI(succecss: Bool) {
        
        uploadClientDocumentsAPIResult = .onLoading(show: true)

        debugPrint("ID Number: \(idNumber)")
        debugPrint("expiry date: \(convertDateFormat(expiryDate))")
                
        let requestModel = UploadClientDocumentsRequestModel(
            A_DESC: "مرفق إضافي",
            ClientID: KeyChainController().clientID ?? "",
            E_DESC: "Additional Documents",
            ExpiryDate: passportExpiryDate,
            FileType: ".png",
            IDNumber: passportNumber,
            ISBase64: "",
            ImageFile: passportByteArray,
            ImageFileString: "",
            IssueDate: "",
            MainClientID: KeyChainController().mainClientID ?? "",
            WebCode: KeyChainController().webCode ?? "",
            isIBAN: "N"
        )
        
        Task.init {
            await useCase.UploadClientDocument(requestModel: requestModel) {[weak self] result in
                self?.uploadClientDocumentsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.uploadClientDocumentsAPIResult = .onSuccess(response: success)
                    if !success {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "failed_document".localized)
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "document_upload_success".localized)
                    }

                    self?.coordinator.popViewController()
                    
                case .failure(let failure):
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "failed_document".localized)
                    self?.uploadClientDocumentsAPIResult = .onFailure(error: failure)
                }
            }
        }
    }

}


// MARK: Functions
extension InsertDocumentViewModel {
    
    func convertDateFormat(_ input: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yy" // Input format
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "ddMMyyyyHHmmss" // Desired output format
        
        // Convert string to Date
        guard let date = inputFormatter.date(from: input) else {
            return "" // Return empty if conversion fails
        }
        
        // Convert Date to desired format
        return outputFormatter.string(from: date)
    }


    func uploadAttachmentAction() {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            self.authorizationStatus = status
            if status == .authorized || status == .limited {
                DispatchQueue.main.async {
                    self.uploadScreenshotInputValue = "ImageUploaded"
                }
            }
        }
    }
    
    func resizeImageData(imageData: Data, targetWidth: CGFloat) async -> String? {
        // Convert Data to UIImage
        guard let image = UIImage(data: imageData) else { return nil }
        
        // Calculate the scaling factor to get the target width
        let scale = targetWidth / image.size.width
        let targetHeight = image.size.height * scale
        
        // Resize the image using UIGraphicsImageRenderer
        let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: targetWidth, height: targetHeight)).image { _ in
            image.draw(in: CGRect(origin: .zero, size: CGSize(width: targetWidth, height: targetHeight)))
        }
        
        // Compress the resized image (change 0.8 to adjust compression quality)
        guard let compressedData = resizedImage.jpegData(compressionQuality: 0.8) else { return nil }
        
        // Convert to Base64 string
        return compressedData.base64EncodedString()
    }

    
    func onImageUpload(image: UIImage) async {
        if let imageData = image.pngData() {
            let base64Image = await resizeImageData(imageData: imageData, targetWidth: 500)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd_HHmmss"

            if let byteArray = base64ToByteArray(base64Image ?? "") {
                debugPrint("Byte array count:", byteArray.count)
                debugPrint("First few bytes:", byteArray.prefix(10))
                if selectedIdCardSectionType == .qatariID {
                    if frontByteArray?.isEmpty == true {
                        self.frontByteArray = byteArray.map({Int($0)})
                        DispatchQueue.main.async {
                            self.frontImageName = "FRONT_IMG_\(dateFormatter.string(from: Date())).png"
                        }
                    } else {
                        self.backByteArray = byteArray.map({Int($0)})
                        DispatchQueue.main.async {
                            self.backImageName = "BACK_IMG_\(dateFormatter.string(from: Date())).png"
                        }
                    }
                } else {
                    self.passportByteArray = byteArray.map({Int($0)})
                    DispatchQueue.main.async {
                        self.passportImageName = "PASSPORT_IMG_\(dateFormatter.string(from: Date())).png"
                    }
                }
                
            }
        }
    }
    
    func onFrontImageNameChange() {
        frontByteArray = []
        frontImageName = ""
    }
    
    func onBackImageNameChange() {
        backByteArray = []
        backImageName = ""
    }
    
    func onPassportImageNameChange() {
        passportByteArray = []
        passportImageName = ""
    }
    
    func base64ToByteArray(_ base64String: String) -> [UInt8]? {
        guard let data = Data(base64Encoded: base64String) else {
            debugPrint("❌ Invalid Base64 string")
            return nil
        }
        return [UInt8](data)
    }

}
