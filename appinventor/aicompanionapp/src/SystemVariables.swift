// -*- mode: swift; swift-mode:basic-offset: 2; -*-
// Copyright 2021-2023 MIT, All rights reserved
// Released under the Apache License, Version 2.0
// http://www.apache.org/licenses/LICENSE-2.0

import Foundation

class SystemVariables {
  /**
   * Specifies whether the user is a new user. The default (true) is set in `AppDelegate.swift`.
   */
  static var newUser: Bool {
    get {
      /// Standard boolean defaults to false
      return UserDefaults.standard.bool(forKey: "isNewUser")
    }

    /// Run after Onboarding to ensure that it never runs again for the same user
    set(value) {
      UserDefaults.standard.set(value, forKey: "isNewUser")
    }
  }
  
  private static var libraryDict: [UUID: AppInfo] = loadLibrary() ?? [:]
  
  static var library: [UUID: AppInfo] {
    return libraryDict
  }
  
  private static func loadLibrary() -> [UUID:AppInfo]? {
    if let savedData = UserDefaults.standard.data(forKey: "savedLibrary"), let decodedData = try? JSONDecoder().decode([UUID:AppInfo].self, from: savedData) {
      return decodedData
    }
    return nil
  }
  
  private static func saveLibrary() -> Bool{
    do {
      let encodedData = try JSONEncoder().encode(libraryDict)
      UserDefaults.standard.set(encodedData, forKey: "savedLibrary")
      return true
    } catch {
      return false
    }
  }
  
  static func getLibrary() -> [UUID:AppInfo]? {
    return libraryDict
  }
  
  static func addApp(appInfo: AppInfo) -> Bool {
    let appId = UUID()
    libraryDict[appId] = appInfo
    return saveLibrary()
  }
  
  static func removeApp(appId: UUID) -> Bool {
    libraryDict.removeValue(forKey: appId)
    return saveLibrary()
  }
  
}
