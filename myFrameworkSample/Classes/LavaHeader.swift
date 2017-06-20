//
//  LavaHeader.swift
//  MasterApp
//
//  Created by srinath on 19/06/17.
//  Copyright © 2017 com.codecraft.coredata. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

let majorVersion = "0"
let minorVersion = "13"
let buildNumber = "0"

public typealias LavaCompletion = (_ error: NSError?) -> Void
public typealias LavaUserCompletion = (_ error: NSError?) -> Void
public typealias LavaResultCompletion = (_ result: Any?) -> Void

public typealias LavaDictionaryCompletion = (_ result: Any?) -> Void


class LavaUserProfile {
    init() {
        
    }
}


var LavasharedInstance: Lava? = nil

///The protocol that defines callbacks from beacon and circular region.
@objc public protocol LavaAreaManagerDelegate : NSObjectProtocol
{
    ///This gets called when a beacon enter event occurs.
    func didEnterBeaconRegion(_ region: CLBeaconRegion)
    ///This gets called when a beacon exit event occurs.
    func didExitBeaconRegion(_ region: CLBeaconRegion)
    ///This gets called when a circular region enter event occurs.
    func didEnterCircularRegion(_ region: CLCircularRegion)
    ///This gets called when a circular region exit event occurs.
    func didExitCircularRegion(_ region: CLCircularRegion)
    ///This gets called when user is within the beacon region.
    func didRangeBeacon(beacon: CLBeacon)
}


//TODO: profile update notification.

///Posted when user logs in to the application.
public let lavaUserDidLoginNotification = "lavaUserDidLoginNotification"

///Posted when user logs out of the application.
public let lavaUserDidLogoutNotification = "lavaUserDidLogoutNotification"

///Posted when user session token gets expired. This may happen after a fixed interval or while using multiple device with same account.
///Use this notification log out the user.
public let lavaUserTokenExpiredNotification = "lavaUserTokenExpiredNotification"

///Posted when user list download request completes.
public let lavaUserListDownloadedNotification = "lavaUserListDownloadedNotification"

///Posted when user location gets updated
public let lavaLocationUpdatedNotification = "lavaLocationUpdatedNotification"

///The different SDK keys that need to be provided while initialising the SDK. Use the keys that is provided while creating the app in dashboard.
public struct LavaSDKKey {
    ///The client id is used to find the right mobile backend.
    public static let clientId = "ClientId"
    ///The app key is used to authorize to backend.
    public static let appKey = "AppKey"
    ///The id used to uniquely differentiate the application.
    public static let appId = "AppId"
    static let domain = "Domain"
    static let pathContext = "PathContext"
}

///The different login types used in the SDK.
public enum LavaLoginType: String {
    ///The anonymous login.
    case Anonymous  = "anonymous"
    ///Login using facebook account.
    case Facebook   = "facebook"
    ///Login using email.
    case Email      = "email"
    ///Login using phone number.
    case Phone      = "phoneNumber"
}

///Defines the user types.
enum LavaUserType: String {
    ///The user before login.
    case Anonymous  = "anonymous"
    ///The user after login.
    case Regular = "regular"
}

///Defines the different error codes used in the SDK.
public enum LavaErrorCode: Int {
    ///The request is a succes.
    case sucesss = 200
    ///The request resulted in a account creation.
    case created = 201
    case noContent = 204
    ///The credentilas used to login is invalid. This may occur while login.
    case invalidCredentials = 601
    ///The account with given credentials already exists. This may occur while registration.
    case accountAlreadyExists = 602
    ///The provided password for the account is incorrect. This may occur while login.
    case passwordMismatch = 603
    ///This error may occur when user try to login with existing account for which verification is pending.
    case accountExistsVerificationPending = 604
    ///The user session token expired error.
    case tokenExpired = 605
    ///This error may occur when user try to login using account in which he is alreay logged-in in another device.
    case userAlreadyLoggedIn = 606
    case emailDoesNotExists = 607
    ///This error may occur when user tries to verify account which has been already verified.
    case userAlreadyVerified = 608
}

/**
 The Lava class. All Lava APIs are available in this class.
 */

public final class Lava: NSObject {
    
    /**
     Initialize the SDK with SDK keys and launch options.
     
     - Parameter sdkKeys: You will be provided with these keys when you create an app in dashboard. The dictionary keys that need to be used are mentioned in `LavaSDKKey`.
     - Parameter launchOptions: You will get this launchOptions in `application:didFinishLaunchingWithOptions:` method.
     
     */
    @objc public static func initialize(_ sdkKeys: [String: String], launchOptions: [AnyHashable: Any]?) {
        LavasharedInstance = Lava(sdkKeys: sdkKeys)
    }
    
    /**
     Request to allow sign in using Facebook.
     
     - Parameter id : The facebook app id that is created for the app.
     */
    public static func enableFacebookLoginWithAppId(_ id: String) {
    }
    
    ///Set this to `true` to enable debug logging. The default value is `false`.
    public static var debuggingEnabled = false
    

    
    ///Set this to get callabcks of beacon and region enter/exit/range callbacks.
    public static var areaDelegate: LavaAreaManagerDelegate? {
        didSet {
        }
    }

    
    
    fileprivate init(sdkKeys: [String: String]) {
        super.init()
        
        self.validateSDKKeys(sdkKeys: sdkKeys)
        
        //initialisations on launch.

        
    }
    
    /**
     Set the device token information. Used for sending remote notification regarding offers.
     */
    public static func setDeviceTokenFromData(tokenData: Data) {
        let token = tokenData.reduce("", {$0 + String(format: "%02X", $1)})

    }
    
    /**
     The SDK version.
     */
    public static var apiVersion: String {
        return "\(majorVersion).\(minorVersion).\(buildNumber)"
    }
    

    
    private func validateSDKKeys(sdkKeys: [String: String]) {
        
        guard let appKey = sdkKeys[LavaSDKKey.appKey], appKey.characters.count >= 0 else {
            fatalError("AppKey not provided!!")
        }
        guard let appId = sdkKeys[LavaSDKKey.appId], appId.characters.count >= 0 else {
            fatalError("AppId  not provided!!")
        }
        guard let clientId = sdkKeys[LavaSDKKey.clientId], clientId.characters.count >= 0 else {
            fatalError("ClientId  not provided!!")
        }
    }
    
    /**
     Returns Login status of the user.
     
     - Returns : `true` if user is logged in.
     */
    public static func isLoggedIn() -> Bool {
        return false
    }
    
    /**
     Returns `true` if either regular or anonymous session exists. This is an internal function.
     
     - Returns : `true` if if either regular or anonymous session exists.
     */
    internal static func hasSession() -> Bool {
        return false
    }

    

    
    /**
     An array of users.
     */
    public static var userList: [Any] {
        get {
            return []
        }
    }
    
    /**
     The total count of users.
     */
    public static var totalCount: Int {
        get {
            return 0
        }
    }
    
    /**
     State if the users are being downloaded at the moment.
     */
    
    public static var isDownloadingUsers: Bool {
        get {
            return false
        }
    }
    
    
    //MARK:-
    //MARK: Registration
    
    /**
     Request to sign up the user with Email.
     
     - Parameter email : The email of the user.
     - Parameter password : The password of the user.
     - Parameter completion : The block to execute after the signup success or failure.
     */
    public static func signUpWithEmail(email: String, password: String, completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.signUpWithEmail(email, password: password, completion: completion)
    }
    
    /**
     Request to sign up the user with Phone Number.
     
     - Parameter phoneNumber : The Phone number of the user.
     - Parameter password : The password of the user.
     - Parameter completion : The block to execute after the signup success or failure.
     */
    public static func signUpWithPhoneNumber(phoneNumber: String, password: String, completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.signUpWithPhoneNumber(phoneNumber, password: password, completion: completion)
    }
    
    //MARK: Verification
    
    /**
     Request to verify the user phone number using the verification key.
     
     - Parameter phoneNumber : The Phone number of the user.
     - Parameter verficationKey : The verification key or one time password that is sent to user phone number.
     - Parameter completion : The block to execute after the verification success or failure.
     */
    public static func verifyPhoneNumber(phoneNumber: String, verficationKey: String, completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.phoneNumberWithVerifyOTP(externalID: phoneNumber, otpNumber:verficationKey, completion: completion)
    }
    
    /**
     Request to resend verification key to user phone number.
     
     - Parameter phoneNumber : The phone number of the user.
     - Parameter completion : The block to execute after the request success or failure.
     */
    public static func resendVerificationForPhoneNumber(phoneNumber: String, completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.resendMobileOTP(externalID: phoneNumber, completion: completion)
    }
    
    /**
     Request to resend verification key to user email.
     
     - Parameter emailAddress : The email of the user.
     - Parameter completion : The block to execute after the request success or failure.
     */
    public static func resendVerificationForEmail(emailAddress: String, completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.resendEmailVerification(emailAddress, completion: completion)
    }
    
    //MARK: Login
    
    /**
     Request to sign in the user with email.
     
     - Parameter email : The email of the user.
     - Parameter password : The password of the user.
     - Parameter completion : The block to execute after the sign in success or failure.
     */
    public static func signInWithEmail(emailAddress: String, password: String, forceLogin: Bool = true, completion: @escaping LavaUserCompletion) {
//        LavaModule.sharedModule.loginManager?.signInWithEmail(emailAddress, password: password, forceLogin: forceLogin, completion: completion)
    }
    
    /**
     Request to sign in the user with phone number.
     
     - Parameter phoneNumber : The phone number of the user.
     - Parameter password : The password of the user.
     - Parameter completion : The block to execute after the sign in success or failure.
     */
    public static func signInWithPhoneNumber(phoneNumber: String, password: String, forceLogin: Bool = true, completion: @escaping LavaUserCompletion) {
//        LavaModule.sharedModule.loginManager?.signInWithPhoneNumber(phoneNumber, password: password, forceLogin: forceLogin, completion: completion)
    }
    

    

    //MARK: Profile
    
    /**
     Request to retrive the user profile of logged in user.
     
     - Parameter completion : The block to execute after the profile fetch success or failure.
     */
    public static func getUserProfile(completion: @escaping LavaUserCompletion) {
//        LavaModule.sharedModule.loginManager?.getUserProfile(completion)
    }

    
    /**
     Request to update the profile picture of logged in user.
     
     - Parameter userProfilePricture : updates user profile picture of logged in user.
     - Parameter completion : The block to execute after the profile picture update success or failure.
     */
    public static func updateUserProfilePicture(_ userProfilePricture: UIImage, completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.updateUserProfilePicture(userProfilePricture, completion: completion)
    }
    
    /**
     Request to upload chat image of logged in user.
     
     - Parameter user chat picture : uploads the chat picture of logged in user.
     - Parameter caht ID : the chat id information of the chat image.
     - Parameter metadata : metadata for the upload.
     - Parameter completion : The block to execute after the profile picture update success or failure.
     */
    public static func uploadChatPicture(_ chatPicture: UIImage, chatId: String?, metaData: [String:String]?, completion: @escaping LavaResultCompletion) {
//        LavaModule.sharedModule.lavaManager?.uploadChatPicture(chatPicture, chatId: chatId, metaData: metaData, completion: completion)
    }
    
    
    //MARK: Link Accounts
    
    /**
     Request to add new email to the current account.
     
     - Parameter email : The email to be added.
     - Parameter password : The new password for fresh email account.
     - Parameter completion : The block to execute after the link account success or failure.
     */
    public static func linkWithEmail(email: String, password: String, completion: @escaping LavaUserCompletion) {
//        LavaModule.sharedModule.loginManager?.linkWithEmail(email, password: password, completion: completion)
    }
    
    /**
     Request to add new phone number to the current account.
     
     - Parameter phoneNumber : The phone number to be added.
     - Parameter password : The new password for fresh phone number account.
     - Parameter completion : The block to execute after the link account success or failure.
     */
    public static func linkWithPhoneNumber(phoneNumber: String, password: String, completion: @escaping LavaUserCompletion) {
//        LavaModule.sharedModule.loginManager?.linkWithPhoneNumber(phoneNumber, password: password, completion: completion)
    }
    
    /**
     Request to link Facebook account with the current account.
     
     - Parameter currentViewController : The view controller over which Facebook login view controller presented.
     - Parameter completion : The block to execute after the link account success or failure.
     */
    public static func linkWithFacebook(currentViewController: UIViewController, completion: @escaping LavaUserCompletion) {
//        LavaModule.sharedModule.loginManager?.linkWithFacebook(currentViewController, completion: completion)
    }
    
    /**
     Request to link existing email account with the current account.
     
     - Parameter email :      The email to be linked.
     - Parameter password :   The password of the existing email account.
     - Parameter completion : The block to execute after the link account success or failure.
     */
    public static func linkWithExistingEmail(email: String, password: String, completion: @escaping LavaUserCompletion) {
//        LavaModule.sharedModule.loginManager?.linkWithExistingEmail(email, password: password, completion: completion)
    }
    
    /**
     Request to link existing phone number account with the current account.
     
     - Parameter phoneNumber : The phone number to be linked.
     - Parameter password :    The password of the existing phone number account.
     - Parameter completion :  The block to execute after the link account success or failure.
     */
    public static func linkWithExistingPhoneNumber(phoneNumber: String, password: String, completion: @escaping LavaUserCompletion) {
//        LavaModule.sharedModule.loginManager?.linkWithExistingPhoneNumber(phoneNumber, password: password, completion: completion)
    }
    
    /**
     Request to check if account with particular phone number or email exists.
     
     - Parameter externalId : The phone number or email.
     - Parameter completion : The block to execute after the check success or failure.
     */
    public static func checkIfAccountExists(externalId: String, completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.checkIfAccountExists(externalId: externalId,completion: completion)
    }
    
    /**
     Request to check if email or phone number is verified.
     
     - Parameter externalId : The phone number or email.
     - Parameter completion : The block to execute after the check success or failure.
     */
    public static func checkVerificationStatus(externalId: String, completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.checkVerificationStatus(externalId: externalId,completion: completion)
    }
    
    //MARK: Account settings
    
    /**
     Request to change password of the user.
     
     - Parameter oldPassword : The old password of the user.
     - Parameter newPassword : The new password of the user.
     - Parameter completion :  The block to execute after the password change success or failure.
     */
    public static func changePassword(oldPassword: String, newPassword: String, completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.changePassword(oldPassword, newPassword: newPassword, completion: completion)
    }
    
    /**
     Request to reset password for email account.
     
     - Parameter emailAddress : The email address of the user.
     - Parameter completion :   The block to execute after the request success or failure.
     */
    public static func forgotPasswordForEmail(_ emailAddress: String , completion: @escaping LavaCompletion){
//        LavaModule.sharedModule.loginManager?.forgotPasswordForExternalId(emailAddress, completion: completion)
    }
    
    /**
     Request to send verification key in order to reset password for phone number account.
     
     - Parameter phoneNumber : The phone number of the user.
     - Parameter completion :  The block to execute after the request success or failure.
     */
    
    public static func forgotPasswordForPhoneNumber(phoneNumber: String , completion: @escaping LavaCompletion){
//        LavaModule.sharedModule.loginManager?.forgotPasswordForExternalId(phoneNumber, completion: completion)
    }
    
    /**
     Request to reset password of phone number account using verification key.
     
     - Parameter verificationKey : The one time password (OTP) that is sent to the user phone number.
     - Parameter newPassword :     The new password for the phone number account.
     - Parameter completion :      The block to execute after the reset password success or failure.
     */
    public static func resetPasswordForPhoneNumberWithVerificationKey(verificationKey: String, phoneNumber: String, newPassword: String, completion: @escaping LavaCompletion){
//        LavaModule.sharedModule.loginManager?.forgotPasswordUsingOTP(verificationKey, phoneNumber: phoneNumber, password: newPassword, completion: completion)
    }
    
    /**
     Request to log out the user.
     
     - Parameter completion : The block to execute after the log out success or failure.
     */
    public static func logOut(completion: @escaping LavaCompletion){
//        LavaModule.sharedModule.loginManager?.logOut(completion)
    }
    
    /**
     Request to delete the current user account.
     
     - Parameter completion : The block to execute after the account deletion success or failure.
     */
    public static func deleteCurrentAccount(completion: @escaping LavaCompletion) {
//        LavaModule.sharedModule.loginManager?.deleteAccount(completion)
    }
    
    //MARK: Requests
    
    /**
     Get personalized content based on request parameters.
     
     - Parameter parameters : The request parameters. The dictionary should include a value for key "path" for which content need to be fetched.
     - Parameter completion : The block to execute after the request success or failure. The response dictionary has type and url keys using which user interface can be populated.
     */
    public static func getPersonalizedContent(parameters: [String: Any], completion: @escaping LavaDictionaryCompletion) {
//        LavaModule.sharedModule.lavaManager?.getPersonalizedContent(parameters: parameters, completion: completion)
    }

    //MARK: Handle Notification
    
    /**
     Handles the push notification received by the application.
     
     - Parameter  userInfo : The userInfo received with the notification.
     */
    public static func handleNotification(userInfo: [AnyHashable : Any]) -> Bool {
        return false
    }
    
    //MARK: Users
    
    /**
     Request to retrive the user list.
     
     - Parameter completion : The block to execute after the user list fetch success or failure.
     */
    
    public static func getUserList(completion: @escaping LavaCompletion) {
    }
    
    public static func getUserWithUserId(userId: String, completion: @escaping LavaResultCompletion) {
//        LavaModule.sharedModule.userManager?.getUserWithUserId(userId, completion: completion)
    }
    
    //MARK:- Gimbal API's
    
    /* User entered the specified place */
    public static func enterGimbalPlace(name: String, identifier: String, completion: LavaCompletion? = nil) {
//        LavaModule.sharedModule.areaManager?.handleEnterGimbalPlace(name: name, identifier: identifier, completion: completion)
    }
    
    /* User exited the specified place */
    public static func exitGimbalPlace(name: String, identifier: String, completion: LavaCompletion? = nil) {
//        LavaModule.sharedModule.areaManager?.handleExitGimbalPlace(name: name, identifier: identifier, completion: completion)
    }
    
    //MARK: Test APIs
    
    /**
     This API is only for testing purpose.
     */
    public static func getDebugInfo() -> [String:String]
    {
        var debugDict = [String:String]()

        
        var lastUserLocation = "Not available"
        

        debugDict["USER LAST LOCATION"] = lastUserLocation
        
        debugDict["SDK VERSION"] = apiVersion
        
        return debugDict
    }
    

    /*
     /**
     This API is only for testing purpose.
     */
     public static func getLavaServers() -> [LavaServer] {
     return LavaServerManager.getLavaServers()
     }
     
     /**
     This API is only for testing purpose.
     */
     public static func getCurrentServer() -> LavaServer {
     return LavaServerManager.currentServer
     }
     
     /**
     This API is only for testing purpose.
     */
     public static func setLavaServer(server: LavaServer) {
     LavaModule.sharedModule.setServer(server)
     }
     */
    
}

