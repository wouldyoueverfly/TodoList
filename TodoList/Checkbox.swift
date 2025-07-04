//
//  Checkbox.swift
//  CustomUIView
//
//  Created by Ruslan Khusainov on 23.06.2025.
//

import UIKit

@IBDesignable
class Checkbox: UIControl {

    private weak var imageView: UIImageView!
    
    private var image: UIImage {
        checked ? UIImage(systemName: "checkmark.square.fill")! : UIImage(systemName: "square")!
    }
    
    @IBInspectable
    public var checked: Bool = false {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        self.imageView = imageView
        
        backgroundColor = .clear
        
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }
    
    @objc func touchUpInside() {
        checked.toggle()
        sendActions(for: .valueChanged)
    }
}
