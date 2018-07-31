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

#import "DemoViewController.h"
#import "Utils.h"
#import "Constants.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 失敗
-(void) userError:(NSString*)message
            error:(NSError*) err{
    NSString *errorDisplay = [NSString stringWithFormat: @"%@ %@", message, [err.userInfo objectForKey:@"NSLocalizedDescription"]];
    [Utils showAlertIn:self message:errorDisplay andOKHandler:nil];
}

// 成功
-(void) userSuccess:(NSString*)message user:(NCMBUser*) user{
    /* 処理成功 */
    NSString *displayMessage = [NSString stringWithFormat: @"%@ %@ %@", message, @" objectId: ", user.objectId];
    [Utils showAlertIn:self message:displayMessage andOKHandler:^(){
        [NCMBUser logOut];
        [Utils showAlertIn:self message:LOGGED_OUT andOKHandler:^(){
            [self loadView];
        }];
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
