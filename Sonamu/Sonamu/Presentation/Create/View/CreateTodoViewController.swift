//
//  CreateTodoViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-23.
//

import UIKit

class CreateTodoViewController: BaseUIViewController {
    //MARK: - 코디네이터
    weak var coordinator: CreateTodoViewCoordinatorImpl?
    
    //MARK: - 뷰 모델
    var viewModel: CreateTodoViewModel?
    
    //MARK: - UI 컴포넌트
    private var createView = UIView()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        return view
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "내용"
        textField.font = UIFont(name: "SUITE-Medium", size: 38.0)
        textField.tintColor = ColorManager.kPrimaryColor
        textField.textColor = ColorManager.kPrimaryColor
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        toolbar.sizeToFit()
        let photoButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(photoButtonTapped(_:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [photoButton]
        return toolbar
    }()
    
    private lazy var cancelButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Cancel"
        button.style = .plain
        button.isEnabled = true
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        print("할일 추가 화면")
    }
    
    override func setUI() {
        view.addSubview(textField)
        textField.inputAccessoryView = toolbar
    }
    
    override func setLayout() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 380),
            textField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    override func setTitle() {
        self.title = "나는 오늘 무엇을 해야하지?"
    }
    
    override func setDelegate() {
        self.navigationItem.rightBarButtonItem = cancelButtonItem
        textField.delegate = self
    }
    
    override func addTarget() {
        cancelButtonItem.target = self
        cancelButtonItem.action = #selector(cancelButtonTapped(_:))
    }
    
    @objc
    private func imagePickerButtonTapped(_ button: UIButton) {
        self.view.endEditing(true)
    }
    
    @objc
    private func closeToolbarButtonTapped(_ button: UIBarButtonItem) {
        toolbar.isHidden = true
    }
    
    @objc
    private func closeButtonTapped(_ button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped(_ button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - 키보드
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - 이미지피커
extension CreateTodoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        
        dismiss(animated:true, completion:nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion:nil)
    }
    
    @objc
    private func photoButtonTapped(_ button: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
}

//MARK: - 텍스트필드
extension CreateTodoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let title = textField.text, !title.isEmpty else { return true }
        viewModel?.createTodo(with: title)
        textField.text = ""
        dismiss(animated: true, completion: nil)
        return true
    }
}
