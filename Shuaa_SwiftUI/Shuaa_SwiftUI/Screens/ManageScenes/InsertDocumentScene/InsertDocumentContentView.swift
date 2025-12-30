//
//  InsertDocumentContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation
import SwiftUI
import PhotosUI

enum IDCardSectionType {
    case qatariID
    case passport
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isImagePicked: Bool?
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images // Only allow images
        configuration.selectionLimit = 1 // Limit to one selection

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator // Set the coordinator to handle the result
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
                return
            }

            // Load the image asynchronously
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self?.parent.selectedImage = image
                        self?.parent.isImagePicked = true
                    }
                }
            }
        }
    }
}


struct InsertDocumentContentView: View {
    

    var selectedIdCardSectionType: Binding<IDCardSectionType>
    @State private var isFrontImagePicked: Bool?
    @State private var selectedFrontImage: UIImage?
    @State private var isBackImagePicked: Bool?
    @State private var selectedBackImage: UIImage?
    @State private var isPassportImagePicked: Bool?
    @State private var selectedPassportImage: UIImage?
    @State private var enabledBtn: Bool = false

    @State private var isShowingPicker = false
    
    var frontImageName:Binding<String>
    var backImageName:Binding<String>
    var passportImageName:Binding<String>

    var idNumber: Binding<String>
    var passportNumber: Binding<String>
    var expiryDate: Binding<String>
    var passportExpiryDate: Binding<String>
    
    
    var onSelectFileTap:()->Void
    var onSaveTap:()->Void
    var onImageUpload: ((UIImage) -> Void)
    var onBackTap:()->Void
    var onFrontImageChange:(String)->Void
    var onBackImageChange:(String)->Void
    var onPassportImageChange:(String)->Void
    
    var body: some View {
        VStack {
            headerView
            
            Divider()
            
            sectionsView
            
            if selectedIdCardSectionType.wrappedValue == .qatariID {
                qatariIdContentView
            } else {
                passportContentView
            }
            
            Spacer()
            
            bottomButtonView
        }
        .onChange(of: isFrontImagePicked) { newValue in
            if newValue == true, let selectedImage = selectedFrontImage {
                // Call the image upload function when image is selected
                onImageUpload(selectedImage)
                isShowingPicker = false
                enabledBtn = checkEnableBtn()
            }
        }
        .onChange(of: isBackImagePicked) { newValue in
            if newValue == true, let selectedImage = selectedFrontImage {
                // Call the image upload function when image is selected
                onImageUpload(selectedImage)
                isShowingPicker = false
                enabledBtn = checkEnableBtn()
            }
        }
        .onChange(of: isPassportImagePicked) { newValue in
            if newValue == true, let selectedImage = selectedPassportImage {
                // Call the image upload function when image is selected
                onImageUpload(selectedImage)
                isShowingPicker = false
                enabledBtn = checkEnableBtn()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(AppUtility.shared.isRTL ? "ic_rightArrow" : "ic_leftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    onBackTap()
                }
            
            Spacer()
            
            Text("id_card_data".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    private var sectionsView: some View {
        HStack(spacing: 0) {
            VStack(spacing: 16) {
                Text("qatari_id".localized)
                    .font(.apply(selectedIdCardSectionType.wrappedValue == .qatariID ? .semiBold : .regular, size: 14))
                    .foregroundStyle(selectedIdCardSectionType.wrappedValue == .qatariID ? Color.colorPrimary : Color.colorTextSecondary)
                if selectedIdCardSectionType.wrappedValue == .qatariID {
                    Color.colorPrimary.frame(maxHeight: 2).opacity(1)
                } else {
                    Color.colorBorder.frame(maxHeight: 1).opacity(1)
                }
            }
            .onTapGesture {
                selectedIdCardSectionType.wrappedValue = .qatariID
            }
            Spacer()
            VStack(spacing: 16) {
                Text("passport".localized)
                    .font(.apply(selectedIdCardSectionType.wrappedValue == .passport ? .semiBold : .regular, size: 14))
                    .foregroundStyle(selectedIdCardSectionType.wrappedValue == .passport ? Color.colorPrimary : Color.colorTextSecondary)
                if selectedIdCardSectionType.wrappedValue == .passport {
                    Color.colorPrimary.frame(maxHeight: 2).opacity(1)
                } else {
                    Color.colorBorder.frame(maxHeight: 1).opacity(1)
                }
            }
            .onTapGesture {
                selectedIdCardSectionType.wrappedValue = .passport
            }
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
    }
    
    private var qatariIdContentView: some View {
        
        var selectFileAttribute: AttributedString {
            var str = AttributedString("select_file".localized)
            str.underlineStyle = .single
            return str
        }

        
        return VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("id_number".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("type_your_id_number".localized, text: idNumber)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.bottom, 8)
                    .onSubmit {
                        enabledBtn = checkEnableBtn()
                    }

            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("expiry_date".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("DD/MM/YY".localized, text: expiryDate)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.bottom, 8)
                    .onSubmit {
                        enabledBtn = checkEnableBtn()
                    }

            }

            if frontImageName.wrappedValue.isEmpty == true || backImageName.wrappedValue.isEmpty == true {
                VStack {
                    Image("ic_upload")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    if frontImageName.wrappedValue.isEmpty == true {
                        Text("\("please_upload_front_id_image".localized)")
                            .font(.apply(.medium, size: 14))
                        
                        Button {
                            onSelectFileTap()
                            isShowingPicker = true
                        } label: {
                            Text("\(selectFileAttribute)")
                                .font(.apply(.medium, size: 14))
                                .foregroundStyle(Color.colorPrimary)
                        }
                        .sheet(isPresented: $isShowingPicker, content: {
                            ImagePicker(selectedImage: $selectedFrontImage, isImagePicked: $isFrontImagePicked)
                        })
                    } else {
                        Text("\("please_upload_back_id_image".localized)")
                            .font(.apply(.medium, size: 14))
                        
                        Button {
                            onSelectFileTap()
                            isShowingPicker = true
                        } label: {
                            Text("\(selectFileAttribute)")
                                .font(.apply(.medium, size: 14))
                                .foregroundStyle(Color.colorPrimary)
                        }
                        .sheet(isPresented: $isShowingPicker, content: {
                            ImagePicker(selectedImage: $selectedBackImage, isImagePicked: $isBackImagePicked)
                        })

                    }

                    Text("\("support".localized): JPG,PDF")
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Text("(\("max_file_size".localized): 25 MB)")
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)

                }
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
            }
            
            VStack {
                if frontImageName.wrappedValue.isEmpty == false {
                    HStack {
                        Button {
                            onFrontImageChange("")
                            isFrontImagePicked = false
                            enabledBtn = checkEnableBtn()
                        } label: {
                            Circle()
                                .fill(Color.colorBGSecondary)
                                .frame(width: 25, height: 25)
                                .overlay {
                                    Image("ic_xClose")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(Color.colorPrimary)
                                }
                        }
                        
                        Text(frontImageName.wrappedValue)
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(Color.colorTextSecondary)
                    }
                }
                if backImageName.wrappedValue.isEmpty == false {
                    HStack {
                        Button {
                            onBackImageChange("")
                            isBackImagePicked = false
                            enabledBtn = checkEnableBtn()
                        } label: {
                            Circle()
                                .fill(Color.colorBGSecondary)
                                .frame(width: 25, height: 25)
                                .overlay {
                                    Image("ic_xClose")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(Color.colorPrimary)
                                }
                        }
                        
                        Text(backImageName.wrappedValue)
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(Color.colorTextSecondary)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }

    private var passportContentView: some View {
        
        var selectFileAttribute: AttributedString {
            var str = AttributedString("select_file".localized)
            str.underlineStyle = .single
            return str
        }

        
        return VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("passport_number".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("type_your_passport_number".localized, text: passportNumber)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.bottom, 8)
                    .onSubmit {
                        enabledBtn = checkEnableBtn()
                    }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("expiry_date".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("DD/MM/YY".localized, text: passportExpiryDate)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.bottom, 8)
                    .onSubmit {
                        enabledBtn = checkEnableBtn()
                    }
            }

            
            if passportImageName.wrappedValue.isEmpty == true {
                VStack {
                    Image("ic_upload")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    HStack {
                        Text("\("please_upload_your_passport".localized), ")
                            .font(.apply(.medium, size: 14))
                        
                        Button {
                            onSelectFileTap()
                            isShowingPicker = true
                        } label: {
                            Text("\(selectFileAttribute)")
                                .font(.apply(.medium, size: 14))
                                .foregroundStyle(Color.colorPrimary)
                        }
                        .sheet(isPresented: $isShowingPicker, content: {
                            ImagePicker(selectedImage: $selectedPassportImage, isImagePicked: $isPassportImagePicked)
                        })
                    }

                    
                    Text("\("support".localized): JPG,PDF")
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Text("(\("max_file_size".localized): 25 MB)")
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
//                    HStack {
//                        Image("ic_documentDemoFront")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(maxWidth: .infinity)
//                            .frame(minHeight: 91)
//                        Image("ic_documentDemoBack")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(maxWidth: .infinity)
//                            .frame(minHeight: 91)
//                    }
//                    .padding(.horizontal, 16)


                }
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
            }
            
            VStack {
                if passportImageName.wrappedValue.isEmpty == false {
                    HStack {
                        Button {
                            onPassportImageChange("")
                            isPassportImagePicked = false
                            enabledBtn = checkEnableBtn()
                        } label: {
                            Circle()
                                .fill(Color.colorBGSecondary)
                                .frame(width: 25, height: 25)
                                .overlay {
                                    Image("ic_xClose")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(Color.colorPrimary)
                                }
                        }
                        
                        Text(passportImageName.wrappedValue)
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(Color.colorTextSecondary)
                    }
                }
            }

            
        }
        .padding(.horizontal, 20)
    }

    private var bottomButtonView: some View {
        Button {
            onSaveTap()
        } label: {
            Text("save".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(.white)
                .frame(minHeight: 48)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
                .opacity(checkEnableBtn() ? 1 : 0.5)
                .padding(.horizontal, 24)
        }
        .disabled(!enabledBtn)
    }
    
    private func checkEnableBtn() -> Bool {
        if selectedIdCardSectionType.wrappedValue == .qatariID {
            return idNumber.wrappedValue.isEmpty == false && expiryDate.wrappedValue.isEmpty == false && isFrontImagePicked == true && isBackImagePicked == true
        } else {
            return passportNumber.wrappedValue.isEmpty == false && passportExpiryDate.wrappedValue.isEmpty == false && isPassportImagePicked == true
        }
    }

}
