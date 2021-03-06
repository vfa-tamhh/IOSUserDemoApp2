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


@implementation Mbaas
/***** ID/PW認証：新規登録 *****/
+(void) signupByID:(NSString*) userId
          password:(NSString*) pwd
        callbackOK:(callbackUserOk) callBackOk
   callbackFailure:(callbackUserError) callBackFailure;{
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
                    if (callBackOk) {
                        callBackOk(user);
                    }
                } else {
                    /* 処理失敗 */
                    if (callBackFailure) {
                        callBackFailure(error);
                    }
                }
            }];
        } else {
            //hide the progress bar
            [ProgressHUD dismiss];
            /* 処理失敗 */
            if (callBackFailure) {
                callBackFailure(error);
            }
        }
    }];
}
/***** ID/PW認証：ログイン *****/
+(void) signinByID:(NSString*)userId
          password:(NSString*)pwd
        callbackOK:(callbackUserOk) callBackOk
   callbackFailure:(callbackUserError) callBackFailure{
    //show the progress bar
    [ProgressHUD show:LOADING_TITLE];
    // ID/PWでログイン
    [NCMBUser logInWithUsernameInBackground:userId password:pwd block:^(NCMBUser *user, NSError *error) {
        //hide the progress bar
        [ProgressHUD dismiss];
        if (!error) {
            /* 処理成功 */
            if (callBackOk) {
                callBackOk(user);
            }
        } else {
            /* 処理失敗 */
            if (callBackFailure) {
                callBackFailure(error);
            }
        }
    }];
}
/***** Email/PW認証：新規登録 *****/
+(void) signupByEmail:(NSString*)mailAddress
            calbackOk:(void (^)(void)) callBackOk
        callbackError:(callbackUserError) callBackError{
    //show the progress bar
    [ProgressHUD show:LOADING_TITLE];
    NSError *error = nil;
    // 設定したEmailに会員登録メールを送信
    [NCMBUser requestAuthenticationMail:mailAddress error:&error];
    //hide the progress bar
    [ProgressHUD dismiss];
    if (!error) {
        /* 処理成功 */
        if (callBackOk) {
            callBackOk();
        }
        
    } else {
        /* 処理失敗 */
        if (callBackError) {
            callBackError(error);
        }
        
    }
}
/***** Email/PW認証：ログイン *****/
+(void) signinByEmail:(NSString*)mailAddress
             password:(NSString*)pwd
           callbackOK:(callbackUserOk) callBackOk
      callbackFailure:(callbackUserError) callBackFailure{
    // Email/PWでログイン
    [NCMBUser logInWithMailAddressInBackground:mailAddress password:pwd block:^(NCMBUser *user, NSError *error) {
        if (!error){
            /* 処理成功 */
            if (callBackOk) {
                callBackOk(user);
            }
        } else {
            /* 処理失敗 */
            if (callBackFailure) {
                callBackFailure(error);
            }
        }
    }];
}
/***** 匿名認証：ログイン *****/
+(void) signinByAnonymousID:(callbackUserOk) callBackOk
            callbackFailure:(callbackUserError) callBackFailure{
    //show the progress bar
    [ProgressHUD show:LOADING_TITLE];
    [NCMBAnonymousUtils logInWithBlock:^(NCMBUser *user, NSError *error) {
        //hide the progress bar
        [ProgressHUD dismiss];
        if (!error) {
            /* 処理成功 */
            if (callBackOk) {
                callBackOk(user);
            }
            
        } else {
            /* 処理失敗 */
            if (callBackFailure) {
                callBackFailure(error);
            }
            
        }
    }];
}
/***** ログアウト *****/
+(void) logout{
    //show the progress bar
    [ProgressHUD show:LOADING_TITLE];
    // ログアウト
    [NCMBUser logOut];
    //hide the progress bar
    [ProgressHUD dismiss];
}
@end
