//
//  MainScreenViewController.swift
//  ChangeColorApp
//
//  Created by Дмитрий Кузнецов on 01/11/2020.
//  Copyright © 2020 Дмитрий Кузнецов. All rights reserved.
//

import UIKit

protocol SettingColorViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class MainScreenViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingColorVC = segue.destination as? SettingColorViewController
            else { return }
        settingColorVC.color = view.backgroundColor
        settingColorVC.delegate = self
    }
}

extension MainScreenViewController: SettingColorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
