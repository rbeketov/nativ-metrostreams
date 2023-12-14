//
//  DetailInformationViewController.swift
//  yourProjectName
//
//  Created by Grigoriy on 11.12.2023.
//

import UIKit

class DetailInformationViewController: UIViewController {
    private let priceLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    private let descriptionaLabel: UILabel = UILabel()
    private let photoImageView = CustomImageView()
    private let detailInformatioModel = DetailInformatioModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        [photoImageView,descriptionaLabel, priceLabel,titleLabel].forEach {
            view.addSubview($0)
        }
        
        setVisualAppearance()
        setupImage()
        setPriceLabel()
        setDescriptionLabel()
        setTitleLabel()
    }
}

//MARK: - methods
extension DetailInformationViewController {
    func datailConfigure(with id: Int) {
        loadData(with: id)
    }
}

//MARK: - private methods
private extension DetailInformationViewController {
    func loadData(with id: Int) {
        detailInformatioModel.loadDetailInformation(with: id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let metroStation):
                DispatchQueue.main.async {
                    self.titleLabel.text = metroStation.modeling_name
                    self.descriptionaLabel.text = metroStation.modeling_description
                    self.priceLabel.text = "Цена:   " + metroStation.modeling_price + " рублей"
                    
                    let imageUrl =  "http://localhost:80/bucket-modelings/\(metroStation.modeling_image_url)"
                    guard let photoUrl = URL(string: imageUrl) else {
                        return
                    }

                    self.photoImageView.loadImage(with: photoUrl)

                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    func setVisualAppearance() {
        photoImageView.contentMode = .scaleAspectFit // обрезаем фото
        photoImageView.clipsToBounds = true
        [descriptionaLabel, titleLabel].forEach {
            $0.numberOfLines = 0
            $0.font = UIFont(name: "Roboto", size: 20) // меняем шрифт
        }
        priceLabel.font = UIFont(name: "Roboto", size: 20) // меняем шрифт
    }
    
    func setupImage() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 15).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        titleLabel.sizeToFit()
    }
    
    func setPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        priceLabel.sizeToFit()
    }
    
    func setDescriptionLabel() {
        descriptionaLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionaLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 50).isActive = true
        descriptionaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionaLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        descriptionaLabel.sizeToFit()
    }
}
