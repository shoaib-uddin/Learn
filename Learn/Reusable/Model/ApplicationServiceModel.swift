//
//  ApplicationServiceModel.swift
//  
//
//  Created by Fez on 3/21/16.
//
//

import Foundation
import UIKit
import Alamofire
import EVReflection
import Contacts

class Font: EVObject{
    var family: String?
    var type: String?
}

class Background: EVObject{
    var background: String?
    var font: String?
    var bcolor: String?
    var fcolor: String?
    var ttype: String?
}

public class ResponseObject: EVObject {
    
    public var Message: String!
    public var Status: NSNumber!
    public var Data: NSArray!
}


class EnSignUp: EVObject {
    var password: String? = settings.gPassword;
    var Id: String? = ""
    var Name: String? = ""
    var Gender: String? = ""
    var Email: String? = ""
    var username: String? = ""
    var Token: String? = ""
    var FacebookId: String? = ""
    var ImageUrl: String? = ""
}

class EnFact: EVObject{
    var ID: String? = ""
    var likes: NSNumber? = 0
    var views: NSNumber? = 1
    var likebyme: BooleanLiteralType? = false
    var Name: String? = ""
    var Content: String? = ""
    var Reference: String? = ""
}

class EnDDL: EVObject {
    var ID: String? = ""
    var Name: String? = ""
}


