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

#import "Mbaas.h"
#import "NCMB/NCMBAnonymousUtils.h"
#import "ProgressHUD.h"
#import "Constants.h"

@implementation Mbaas
/***** ID/PW認証：新規登録 *****/
+(void) signupByID:(NSString*)userId
          password:(NSString*)pwd
  uiviewController:(UIViewController *)controller{
    //show the progress bar
    [ProgressHUD show:LOADING_TITLE];
    // user インスタンスの生成
    NCMBUser *user = [NCMBUser user];
    // ID/PWで新規登録
    user.userName = userId;
    user.password = pwd;
    // ユーザーの新規登録処理
    [user signUpInBackgroundWithBlock:^(NSError *error) {
        if (!error) {
            // userインスタンスでログイン
            [NCMBUser logInWithUsernameInBackground:userId password:pwd block:^(NCMBUser *user, NSError *error) {
                //hide the progress bar
                [ProgressHUD dismiss];
                if (!error) {
                    /* 処理成功 */
                    [self userSuccess:LOGIN_SUCCESS user:user uiviewController:controller];
                } else {
                    /* 処理失敗 */
                    [self userError:ID_PW_REGISTRATION_FAILURE error:error uiviewController:controller];
                }
            }];
        } else {
            //hide the progress bar
            [ProgressHUD dismiss];
            /* 処理失敗 */
            [self userError:ID_PW_REGISTRATION_FAILURE error:error uiviewController:controller];
        }
    }];
}
/***** ID/PW認証：ログイン *****/
+(void) signinByID:(NSString*)userId
          password:(NSString*)pwd
  uiviewController:(UIViewController *)controller{
    //show the progress bar
    [ProgressHUD show:LOADING_TITLE];
    // ID/PWでログイン
    [NCMBUser logInWithUsernameInBackground:userId password:pwd block:^(NCMBUser *user, NSError *error) {
        //hide the progress bar
        [ProgressHUD dismiss];
        if (!error) {
            /* 処理成功 */
            [self userSuccess:LOGIN_SUCCESS user:user uiviewController:controller];
        } else {
            /* 処理失敗 */
            [self userError:ID_PW_REGISTRATION_FAILURE error:error uiviewController:controller];
        }
    }];
}
/***** Email/PW認証：新規登録 *****/
+(void) signupByEmail:(NSString*)mailAddress
     uiviewController:(UIViewController *)controller{
    //show the progress bar
    [ProgressHUD show:LOADING_TITLE];
    NSError *error = nil;
    // 設定したEmailに会員登録メールを送信
    [NCMBUser requestAuthenticationMail:mailAddress error:&error];
    //hide the progress bar
    [ProgressHUD dismiss];
    if (!error) {
        /* 処理成功 */
        [Utils showAlertIn:controller message:EMAIL_PW_REGISTRATION_COMPLETE andOKHandler:^(){
            [Utils showAlertIn:controller message:MESSAGE_RESPONSE_REGISTRATION_COMPLETE andOKHandler:^(){
                [controller loadView];
            }];
        }];
    } else {
        /* 処理失敗 */
        [self userError:EMAIL_PW_REGISTRATION_FAILURE error:error uiviewController:controller];
    }
}
/***** Email/PW認証：ログイン *****/
+(void) signinByEmail:(NSString*)mailAddress
             password:(NSString*)pwd
     uiviewController:(UIViewController *)controller{
    // Email/PWでログイン
    [NCMBUser logInWithMailAddressInBackground:mailAddress password:pwd block:^(NCMBUser *user, NSError *error) {
        if (!error){
            /* 処理成功 */
            [self userSuccess:EMAIL_PW_LOGIN_SUCCESS user:user uiviewController:controller];
        } else {
            /* 処理失敗 */
            [self userError:EMAIL_PW_LOGIN_FAILURE error:error uiviewController:controller];
        }
    }];
}
/***** 匿名認証：ログイン *****/
+(void) signinByAnonymousID:(UIViewController *)controller{
    //show the progress bar
    [ProgressHUD show:LOADING_TITLE];
    [NCMBAnonymousUtils logInWithBlock:^(NCMBUser *user, NSError *error) {
        //hide the progress bar
        [ProgressHUD dismiss];
        if (!error) {
            /* 処理成功 */
            [self userSuccess:ANONYMOUS_LOGIN_SUCCESS user:user uiviewController:controller];
        } else {
            /* 処理失敗 */
            [self userError:ANONYMOUS_LOGIN_FAILURE error:error uiviewController:controller];
        }
    }];
}
/***** ログアウト *****/
+(void) logout:(UIViewController *)controller{
    //show the progress bar
    [ProgressHUD show:LOADING_TITLE];
    // ログアウト
    [NCMBUser logOut];
    //hide the progress bar
    [ProgressHUD dismiss];
}
/********** コールバック **********/
// 成功
+(void) userSuccess:(NSString*)message
               user:(NCMBUser*) u
   uiviewController:(UIViewController *)controller{
    /* 処理成功 */
    NSString *displayMessage = [NSString stringWithFormat: @"%@ %@ %@", message, @" objectId: ", u.objectId];
    [Utils showAlertIn:controller message:displayMessage andOKHandler:^(){
        [NCMBUser logOut];
        [Utils showAlertIn:controller message:LOGGED_OUT andOKHandler:^(){
            [controller loadView];
        }];
    }];
    
}
// 失敗
+(void) userError:(NSString*)message
            error:(NSError*) err
 uiviewController:(UIViewController *)controller{
    NSString *errorDisplay = [NSString stringWithFormat: @"%@ %@", message, [err.userInfo objectForKey:@"NSLocalizedDescription"]];
    [Utils showAlertIn:controller message:errorDisplay andOKHandler:nil];
}
@end
