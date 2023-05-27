//
//  CatCell.swift
//  catsApp
//
//  Created by santiago calvo on 27/05/23.
//

import UIKit

final class CatCell: UITableViewCell {
    
    static let identifier = "catCell"
    
    let breedName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let originLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let affectionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let intelligenceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let catImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with cat: Cat) {
        breedName.text = cat.breedName
        originLabel.text = cat.origin
        affectionLabel.text = "Affection: \(cat.affectionLevel)"
        intelligenceLabel.text = "Affection: \(cat.intelligence)"
        
        DispatchQueue.global().async { [weak self] in
            if let url = cat.imageURL {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self?.catImage.image = UIImage(data: data)
                    }
                }
            }
        }

    }
    
    private func addSubviews() {
        contentView.addSubview(breedName)
        contentView.addSubview(originLabel)
        contentView.addSubview(affectionLabel)
        contentView.addSubview(intelligenceLabel)
        contentView.addSubview(catImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            breedName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            breedName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            breedName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            
            originLabel.topAnchor.constraint(equalTo: breedName.bottomAnchor, constant: 14),
            originLabel.leadingAnchor.constraint(equalTo: breedName.leadingAnchor),
            originLabel.trailingAnchor.constraint(equalTo: breedName.trailingAnchor),
            
            affectionLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 14),
            affectionLabel.leadingAnchor.constraint(equalTo: originLabel.leadingAnchor),
            affectionLabel.trailingAnchor.constraint(equalTo: originLabel.trailingAnchor),
            
            intelligenceLabel.topAnchor.constraint(equalTo: affectionLabel.bottomAnchor, constant: 14),
            intelligenceLabel.leadingAnchor.constraint(equalTo: affectionLabel.leadingAnchor),
            intelligenceLabel.trailingAnchor.constraint(equalTo: affectionLabel.trailingAnchor),
//            intelligenceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            
            catImage.topAnchor.constraint(equalTo: intelligenceLabel.bottomAnchor, constant: 14),
            catImage.leadingAnchor.constraint(equalTo: intelligenceLabel.leadingAnchor),
            catImage.trailingAnchor.constraint(equalTo: intelligenceLabel.trailingAnchor),
            catImage.heightAnchor.constraint(equalToConstant: 200),
            catImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
        ])
    }
    
}
