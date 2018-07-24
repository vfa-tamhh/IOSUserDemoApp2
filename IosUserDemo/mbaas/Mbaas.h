/*
 Copyright 2017-2018 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Utils.h"
#import "NCMB/NCMBUser.h"

@interface Mbaas : NSObject
+(void) signupByID:(NSString*)userId
          password:(NSString*)pwd
  uiviewController:(UIViewController *)controller;
+(void) signinByID:(NSString*)userId
          password:(NSString*)pwd
  uiviewController:(UIViewController *)controller;
+(void) signupByEmail:(NSString*)mailAddress
     uiviewController:(UIViewController *)controller;
+(void) signinByEmail:(NSString*)mailAddress
          password:(NSString*)pwd
  uiviewController:(UIViewController *)controller;
+(void) signinByAnonymousID:(UIViewController *)controller;
+(void) logout:(UIViewController *)controller;
+(void) userSuccess:(NSString*)message
               user:(NCMBUser*) u
   uiviewController:(UIViewController *)controller;
+(void) userError:(NSString*)message
               error:(NSError*) err
   uiviewController:(UIViewController *)controller;
@end
