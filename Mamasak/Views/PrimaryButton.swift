//
//  PrimaryButton.swift
//  Mamasak
//
//  Created by yxgg on 12/05/22.
//

import UIKit

class PrimaryButton: UIButton {
  convenience init() {
    self.init(type: .system)
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  func setup() {
    tintColor = .white
    backgroundColor = .color1
    titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    layer.cornerRadius = 10
    layer.masksToBounds = true
  }
}
