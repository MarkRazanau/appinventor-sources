//
//  AppLibraryViewController.swift
//  AICompanionApp
//
//  Created by Mark Razanau on 2/22/25.
//  Copyright © 2025 Massachusetts Institute of Technology. All rights reserved.
//

import UIKit

class AppLibraryViewController: UIViewController {
  @IBOutlet var libraryView: UIView!
  let scrollView = UIScrollView()
  
  override func viewWillAppear(_ animated: Bool){
    super.viewWillAppear(animated)
//    if (SystemVariables.addApp(appInfo: AppInfo(appTitle: "Alarm", appDescription: "Alarm clock app", appIcon: "123")) &&
//    SystemVariables.addApp(appInfo: AppInfo(appTitle: "Duolingo", appDescription: "Language learning app", appIcon: "456")) &&
//        SystemVariables.addApp(appInfo: AppInfo(appTitle: "Youtube", appDescription: "Video Watching app", appIcon: "789"))) {
      configure()
  }
  
  private func configure(){

    scrollView.translatesAutoresizingMaskIntoConstraints = false
    libraryView.addSubview(scrollView)
    let apps = SystemVariables.library
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: libraryView.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: libraryView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: libraryView.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: libraryView.bottomAnchor)
    ])
    
    let pageView = UIView()
    pageView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(pageView)
    NSLayoutConstraint.activate([
      pageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      pageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      pageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      pageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      pageView.heightAnchor.constraint(equalTo: libraryView.heightAnchor, multiplier: 2)
    ])
    
    var labelTitles : [String] = []
    for (_, appInfo) in apps {
      labelTitles.append(appInfo.appTitle)
    }
    
    var previousLabel: UILabel? = nil
    
    for title in labelTitles {
      let label = UILabel()
      label.text = title
      label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
      label.textAlignment = .center
      label.translatesAutoresizingMaskIntoConstraints = false
      pageView.addSubview(label)
      
      NSLayoutConstraint.activate([
        label.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
        label.topAnchor.constraint(equalTo: previousLabel?.bottomAnchor ?? pageView.topAnchor, constant: 15)
      ])
      
      previousLabel = label
    }
  }
}
