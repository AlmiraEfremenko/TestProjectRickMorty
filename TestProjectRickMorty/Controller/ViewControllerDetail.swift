//
//  File.swift
//  TestProjectRickMorty
//
//  Created by MAC on 18.04.2022.
//

// создать 2 экран - имя раса пол статус аватарка местоположение кол-во эпизодов

import UIKit

class ViewControllerDetail: UIViewController {
    
    // MARK: - Property
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var avatar: UIImageView = {
        var avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private lazy var name: UILabel = {
        var name = UILabel()
        name.font = .systemFont(ofSize: 24, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var race: UILabel = {
        var race = UILabel()
        race.font = .systemFont(ofSize: 17)
        race.translatesAutoresizingMaskIntoConstraints = false
        return race
    }()
    
    private lazy var gender: UILabel = {
        var gender = UILabel()
        gender.font = .systemFont(ofSize: 17)
        gender.translatesAutoresizingMaskIntoConstraints = false
        return gender
    }()
    
    private lazy var status: UILabel = {
        var status = UILabel()
        status.font = .systemFont(ofSize: 17)
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    private lazy var location: UILabel = {
        var location = UILabel()
        location.font = .systemFont(ofSize: 17)
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()
    
    private lazy var episode: UILabel = {
        var episode = UILabel()
        episode.font = .systemFont(ofSize: 17)
        episode.translatesAutoresizingMaskIntoConstraints = false
        return episode
    }()
    
    var character: Character? {
        
        didSet {
            self.name.text = character?.name
            self.race.text = character?.species.rawValue
            self.gender.text = character?.gender.rawValue
            self.status.text = character?.status.rawValue
            self.location.text = character?.location?.name
            self.episode.text = String("\(character?.episode.count ?? 0)")
            
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Hierarchy
    
    private func setupHierarchy() {
        view.addSubview(stackView)
        stackView.addSubview(avatar)
        stackView.addSubview(name)
        stackView.addSubview(race)
        stackView.addSubview(gender)
        stackView.addSubview(status)
        stackView.addSubview(location)
        stackView.addSubview(episode)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        avatar.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        avatar.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 7).isActive = true
        
        name.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 20).isActive = true
        
        race.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        race.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20).isActive = true
        
        gender.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        gender.topAnchor.constraint(equalTo: race.bottomAnchor, constant: 20).isActive = true
        
        status.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        status.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 20).isActive = true
        
        location.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        location.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 20).isActive = true
        
        episode.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        episode.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 20).isActive = true
    }
}
