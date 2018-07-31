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

#import "SecondViewController.h"
#import "Utils.h"
#import "Mbaas.h"
#import "Constants.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
- (IBAction)SignupByEmail:(id)sender {
    
    if([Utils isEmptyOrBlank:self.txtSignupEmail]){
        [Utils showAlertIn:self message:MESSAGE_ERROR_EMAIL_DO_NOT_INPUT andOKHandler:nil];
    } else {
        [Mbaas signupByEmail:self.txtSignupEmail.text calbackOk:^{
            [Utils showAlertIn:self message:EMAIL_PW_REGISTRATION_COMPLETE andOKHandler:^(){
                [Utils showAlertIn:self message:MESSAGE_RESPONSE_REGISTRATION_COMPLETE andOKHandler:^(){
                    [self loadView];
                }];
            }];
        } callbackError:^(NSError *error){
            [self userError:EMAIL_PW_REGISTRATION_FAILURE error:error];
        }];
    }
}
- (IBAction)SigninByEmail:(id)sender {
    
    if([Utils isEmptyOrBlank:self.txtSigninEmail] || [Utils isEmptyOrBlank:self.txtSigninPassword]){
        [Utils showAlertIn:self message:MESSAGE_ERROR_NOT_INPUT andOKHandler:nil];
    } else {
        [Mbaas signinByEmail:self.txtSigninEmail.text password:self.txtSigninPassword.text callbackOK:^(NCMBUser *user) {
            [self userSuccess:EMAIL_PW_LOGIN_SUCCESS user:user];
        } callbackFailure:^(NSError *error) {
            [self userError:EMAIL_PW_LOGIN_FAILURE error:error];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [_txtSignupEmail resignFirstResponder];
    [_txtSigninEmail resignFirstResponder];
    [_txtSigninPassword resignFirstResponder];
}

@end
