//
//  ViewController.swift
//  ChangeColorApp
//
//  Created by Дмитрий Кузнецов on 16/10/2020.
//  Copyright © 2020 Дмитрий Кузнецов. All rights reserved.
//

import UIKit

class SettingColorViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var colorView: UIView!
    @IBOutlet var rgbValueLabels: [UILabel]!
    @IBOutlet var rgbSliders: [UISlider]!
    @IBOutlet var rgbTextFields: [UITextField]!
    
    
    //MARK: - Properties
    var color: UIColor!
    var delegate: SettingColorViewControllerDelegate!
    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = color
        setupSliders()
        rgbTextFields.forEach {
            $0.delegate = self
            $0.addDoneButton()
        }
    }
    
    // Метод для скрытия клавиатуры тапом по экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    //MARK: - IBActions
    @IBAction func sliderChangeColor(_ sender: UISlider) {
        updateUI(tag: sender.tag, newValue: sender.value)
    }
    
    @IBAction func doneButtonClick() {
        delegate.setColor(color)
        dismiss(animated: true)
    }
    
    
    //MARK: - Methods
    private func setupSliders() {
        guard var rgbComponents = color.cgColor.components else { return }
        rgbComponents.removeLast()          // remove alpha cofficient
        for (index, colorComponent) in rgbComponents.enumerated() {
            rgbValueLabels[index].text = String(format: "%.2f", Float(colorComponent))
            rgbSliders[index].value = Float(colorComponent)
            rgbTextFields[index].text = String(format: "%.2f", Float(colorComponent))
        }
    }
    
    private func updateUI(tag: Int, newValue: Float) {
        rgbValueLabels[tag].text = String(format: "%.2f", newValue)
        rgbSliders[tag].value = newValue
        rgbTextFields[tag].text = String(format: "%.2f", newValue)
        
        
        guard var rgbComponents  = self.color.cgColor.components else { return }
        rgbComponents[tag] = CGFloat(newValue)
        let strRgbComponents = rgbComponents.map { String(Float($0)) }.joined(separator: " ")
        let color = CIColor(string: strRgbComponents)
        self.color = UIColor(ciColor: color)
        colorView.backgroundColor = self.color
    }
}


// MARK: -  Extensions
extension SettingColorViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = Float(textField.text ?? "1") else { return }
        if newValue < 0 || newValue > 1 {
            let alertController = UIAlertController(title: "Error",
                                                    message: "The value must be between 0 and 1",
                                                    preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok",
                                       style: .default,
                                       handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true)
            
            textField.text = rgbValueLabels[textField.tag].text
            return
        }
        updateUI(tag: textField.tag, newValue: newValue)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        guard let stringRange = Range(range, in: text) else { return false }
        
        let updatedText = text.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 4
    }
}

extension UITextField {
    
    func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                         target: nil,
                                         action: nil),
                         UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneButtonTapped))]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}
