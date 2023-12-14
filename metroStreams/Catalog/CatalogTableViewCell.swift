//
//  CatalogTableViewCell.swift
//  yourProjectName
//
//  Created by Grigoriy on 04.12.2023.
//

import UIKit

final class CatalogTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()
    private let photoImageView = CustomImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [photoImageView, titleLabel, priceLabel].forEach {
            addSubview($0)
        }
        setVisualAppearance()
        setupImage()
        setupTitle()
        setupAlbumLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Life circle
extension CatalogTableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}

//MARK: - methods
extension CatalogTableViewCell {
    func cellConfigure(with model: CatalogUIModel) {
        let imageUrl =  "http://localhost:80/bucket-modelings/\(model.modelingImageUrl)"
        guard let photoUrl = URL(string: imageUrl) else {
            return
        }
        
        photoImageView.loadImage(with: photoUrl)
        titleLabel.text = model.modelingName
        priceLabel.text = "Цена: " + String(model.modelingPrice) + " рублей"
    }
}

//MARK: - private methods
private extension CatalogTableViewCell {
    func setVisualAppearance() {
        photoImageView.contentMode = .scaleAspectFit // обрезаем фото
        photoImageView.clipsToBounds = true
//        photoImageView.layer.cornerRadius = self.frame.width / 2
        [titleLabel, priceLabel].forEach {
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = UIFont(name: "Roboto", size: 17) // меняем шрифт
        }

        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)

//        titleLabel.font = uifo
//        self.backgroundColor = .systemCyan.withAlphaComponent(0.5)
    }

    func setupImage() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
//        photoImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        photoImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
    }

    func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        titleLabel.sizeToFit()
    }

    func setupAlbumLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        priceLabel.sizeToFit()
    }


}
