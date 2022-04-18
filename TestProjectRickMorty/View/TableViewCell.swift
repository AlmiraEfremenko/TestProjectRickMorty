//
//  TableViewCell.swift
//  TestProjectRickMorty
//
//  Created by MAC on 18.04.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifire = "TableViewCell"
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.font = .systemFont(ofSize: 15, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var race: UILabel = {
        let race = UILabel()
        race.font = .systemFont(ofSize: 15)
        race.translatesAutoresizingMaskIntoConstraints = false
        return race
    }()
    
    lazy var gender: UILabel = {
        let gender = UILabel()
        gender.font = .systemFont(ofSize: 15)
        gender.translatesAutoresizingMaskIntoConstraints = false
        return gender
    }()
    
    lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFit
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    var character: Character? {

        didSet {
            self.name.text = character?.name
            self.race.text = character?.species.rawValue
            self.gender.text = character?.gender.rawValue

            guard let imagePath = character?.image,
                  let avatarUrl = URL(string: imagePath),
                  let imageData = try? Data(contentsOf: avatarUrl)
            else {
                self.avatar.image = UIImage(named: "guru")
                return
            }
            self.avatar.image = UIImage(data: imageData)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(avatar)
        addSubview(name)
        addSubview(race)
        addSubview(gender)
    }
    
    private func setupLayout() {
        avatar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        avatar.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        name.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 70).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        race.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 70).isActive = true
        race.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        
        gender.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 70).isActive = true
        gender.topAnchor.constraint(equalTo: race.bottomAnchor, constant: 10).isActive = true
    }
}
