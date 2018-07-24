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

#import "Constants.h"

@implementation Constants

NSString * const ID_PW_TITLE = @"ID/PW認証";
NSString * const EMAIL_PW_TITLE = @"Email/PW認証";
NSString * const ANONYMOUS_TITLE = @"匿名認証";
NSString * const LOADING_TITLE = @"Please wait...";

NSString * const LOGIN_SUCCESS = @"【ID/PW認証】ログイン成功:";
NSString * const ID_PW_REGISTRATION_FAILURE = @"【ID / PW 認証】新規登録失敗:";

NSString * const EMAIL_PW_REGISTRATION_COMPLETE = @"【Email/PW認証】新規登録メール配信完了";
NSString * const MESSAGE_RESPONSE_REGISTRATION_COMPLETE = @"届いたメールに記載されているURLにアクセスし、パスワードを登録してください。";
NSString * const EMAIL_PW_REGISTRATION_FAILURE = @"【Email/PW認証】新規登録メールの配信に失敗しました:";

NSString * const EMAIL_PW_LOGIN_SUCCESS = @"【Email/PW認証】ログイン成功:";
NSString * const EMAIL_PW_LOGIN_FAILURE = @"【Email/PW認証】ログイン失敗:";

NSString * const ANONYMOUS_LOGIN_SUCCESS = @"【匿名認証】ログイン成功:";
NSString * const ANONYMOUS_LOGIN_FAILURE = @"【匿名認証】ログイン失敗:";

NSString * const LOGGED_OUT = @"ログアウトしました";

NSString * const MESSAGE_ERROR_NOT_INPUT = @"入力されていない項目があります";
NSString * const MESSAGE_ERROR_PWD_DO_NOT_MATCH = @"パスワードが不一致です";
NSString * const MESSAGE_ERROR_EMAIL_DO_NOT_INPUT = @"メールアドレスが入力されていません";

@end
