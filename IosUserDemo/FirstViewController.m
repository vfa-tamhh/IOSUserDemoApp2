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

#import "FirstViewController.h"
#import "Utils.h"
#import "Mbaas.h"
#import "Constants.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)Signup:(id)sender {
    if(![self.txtSignupId hasText] || ![self.txtSignupPassword hasText] || ![self.txtSignupPasswordConfirm hasText]){
        [Utils showAlertIn:self message:MESSAGE_ERROR_NOT_INPUT andOKHandler:nil];
    } else if(self.txtSignupPassword.text != self.txtSignupPasswordConfirm.text){
        [Utils showAlertIn:self message:MESSAGE_ERROR_PWD_DO_NOT_MATCH andOKHandler:nil];
    } else {
        [Mbaas signupByID:self.txtSignupId.text password:self.txtSignupPassword.text uiviewController:self];
    }
}
- (IBAction)Signin:(id)sender {
    if(![self.txtSigninId hasText] || ![self.txtSigninPassword hasText]){
        [Utils showAlertIn:self message:MESSAGE_ERROR_NOT_INPUT andOKHandler:nil];
    } else {
        [Mbaas signinByID:self.txtSigninId.text password:self.txtSigninPassword.text uiviewController:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
