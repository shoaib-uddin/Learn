//
//  GBHFacebookHelper.swift
//  GBHFacebookImagePicker
//
//  Created by Florian Gabach on 28/09/2016.
//  Copyright (c) 2016 Florian Gabach <contact@floriangabach.fr>

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

/// - loginFailed: When Facebook login fail
enum LoginError: Error {
    case loginCancelled
    case permissionDenied
    case loginFailed
}


class GBHFacebookHelper {

    // MARK: - Singleton 

    static let shared = GBHFacebookHelper();

    
    // MARK: - Logout

    /// Logout with clear session, token & user's album
    fileprivate func logout() {
        FBSDKLoginManager().logOut()
    }

    // MARK: - Login

    /// Start login with Facebook SDK
    ///
    /// - parameters vc: source controller
    /// - parameters completion: (success , error if needed)
    func login(controller: UIViewController?,
               completion: @escaping (Bool, LoginError?) -> Void) {

        if FBSDKAccessToken.current() == nil {
            // No token, we need to login

            // Start Facebook's login
            let loginManager = FBSDKLoginManager()
            loginManager.logIn(withReadPermissions: ["public_profile", "email"],
                               from: controller) { (response, error) in
                                if error != nil {
                                    // Failed
                                    print("Failed to login")
                                    print(error.debugDescription)
                                    completion(false, .loginFailed)
                                } else {
                                    // Success
                                    if response?.isCancelled == true {
                                        // Login Cancelled
                                        completion(false, .loginCancelled)
                                    } else {
                                        if response?.token != nil {
                                            
                                            print(response?.token ?? "TOKEN == Random");
                                            // Check "user_photos" permission statut
                                            if let permission = response?.declinedPermissions {
                                                if permission.contains("email") {
                                                    // "email" is dennied
                                                    self.logout() // Flush fb session
                                                    completion(false, .permissionDenied)
                                                } else {
                                                    // "email" is granted, let's get user's pictures
                                                    completion(true, nil)
                                                }
                                            } else {
                                                // Failed to get permission 
                                                print("Failed to get permission...")
                                                completion(false, .loginFailed)
                                            }
                                        } else {
                                            // Failed
                                            print("Failed to get token")
                                            completion(false, .loginFailed)
                                        }
                                    }
                                }
            }
        } else {
            // Already logged in, check User_photos permission
            if FBSDKAccessToken.current().permissions.contains("email") {
                // User_photos's permission ok
                
                print(FBSDKAccessToken.current());
                completion(true, nil)
            } else {
                // User_photos's permission denied
                self.logout() // Flush fb session
                print("Permission for user's photos are denied")
                completion(false, .permissionDenied)
            }
        }
    }
    
    // MARK: - checkLogin
    
    /// check login with Facebook SDK
    ///
    /// - parameters completion: (success , error if needed)
    func checklogin(
               completion: @escaping (Bool, LoginError?) -> Void) {
        
        if FBSDKAccessToken.current() == nil {
            // No token, we need to login
            completion(false, .loginFailed);
        } else {
            completion(true, nil);
        }
    }
    
    // MARK: - checkLogin
    
    /// check login with Facebook SDK
    ///
    /// - parameters completion: (success , error if needed)
    func isTokenExist() -> Bool {
        return (FBSDKAccessToken.current() == nil) ? false : true;
    }
    
    // MARK: - checkLogin
    
    /// check login with Facebook SDK
    ///
    /// - parameters completion: (success , error if needed)
    func dologout() {
        
        if FBSDKAccessToken.current() == nil {
            // No token, we need to login
            print("Already logged out");
        } else {
            self.logout();
        }
    }

}
