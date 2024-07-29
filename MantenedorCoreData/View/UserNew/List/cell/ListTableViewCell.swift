//
//  ListTableViewCell.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 28-07-24.
//  Copyright © 2024 Jose David Bustos H. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
 
    lazy var trackImageView: UIImageView = {
        let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFit
           imageView.layer.cornerRadius = 10.0
           imageView.layer.masksToBounds = true
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.image = UIImage(named: "users")
           return imageView
    }()
    
    lazy var nombreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var apellidoLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(trackImageView)
        contentView.addSubview(nombreLabel)
        contentView.addSubview(apellidoLabel)

        NSLayoutConstraint.activate([
            trackImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            trackImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            trackImageView.widthAnchor.constraint(equalToConstant: 80),
            trackImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nombreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            nombreLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 15),
            nombreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            apellidoLabel.topAnchor.constraint(equalTo: nombreLabel.bottomAnchor, constant: 10),
            apellidoLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 15),
            apellidoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
