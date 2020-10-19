//
//  ViewController.swift
//  ChangeColorApp
//
//  Created by Дмитрий Кузнецов on 16/10/2020.
//  Copyright © 2020 Дмитрий Кузнецов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    //MARK: - Properties, словарь соотношения слайдера и его label со значением
    private var sliderValueDict: Dictionary<Int, UILabel> = [:]
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliders()
        setupValueLabels()
        colorView.layer.cornerRadius = 10
        sliderValueDict = [redSlider.tag: redValueLabel, greenSlider.tag: greenValueLabel, blueSlider.tag: blueValueLabel]
    }
    
    //MARK: - IBActions
    @IBAction func sliderChangeColor(_ sender: UISlider) {
        sliderValueDict[sender.tag]?.text = String(format: "%.2f", sender.value)
        colorView.backgroundColor = UIColor(red: CGFloat(Float(redValueLabel.text!)!), green: CGFloat(Float(greenValueLabel.text!)!), blue: CGFloat(Float(blueValueLabel.text!)!), alpha: 1)
    }
    
    //MARK: - Methods, методы первоначальной настройки
    private func setupSliders() {
        redSlider.minimumValue = 0
        redSlider.maximumValue = 1
        redSlider.tintColor = .red
        redSlider.value = 1
        
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 1
        greenSlider.tintColor = .green
        greenSlider.value = 1
        
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 1
        blueSlider.tintColor = .blue
        blueSlider.value = 1
    }
    
    private func setupValueLabels() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f",greenSlider.value)
        blueValueLabel.text = String(format: "%.2f",blueSlider.value)
        
    }
}

