//
//  LoginController.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/10.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
//#import "WeiboSDK.h"
#import "GetUserHelp.h"
#import "ForgetPwdController.h"


@interface LoginController ()<UITextFieldDelegate>

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(missSelf:) name:@"weiboUser" object:nil];
}


- (void)missSelf:(NSNotification *)no{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"登陆成功" object:nil userInfo:@{@"information":no.userInfo[@"information"]}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender {
    [AVUser logInWithUsernameInBackground:_username4Text.text password:_pwd4Text.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"登陆成功" object:nil userInfo:@{@"information":user}];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"登陆失败！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cencel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *confirm =  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:cencel];
            [alertVC addAction:confirm];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }];

}
- (IBAction)weiboLogin:(id)sender {
    
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
//    request.scope = @"all";
//    request.userInfo = @{@"where":NSStringFromClass(self.class)};
//
//    [WeiboSDK sendRequest:request];
    
}

- (IBAction)ForgetPwd:(id)sender {
    
    ForgetPwdController *forgetVC = [[ForgetPwdController alloc]initWithNibName:@"ForgetPwdController" bundle:nil];
    [self presentViewController:forgetVC animated:YES completion:nil];
}

- (IBAction)registerAction:(id)sender {

    RegisterController *regVC = [[RegisterController alloc]initWithNibName:@"RegisterController" bundle:nil];
    [self presentViewController:regVC animated:YES completion:nil];
}

-(IBAction)ButtonSender{
    [self  dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField ==self.username4Text) {
        [self.pwd4Text becomeFirstResponder];
    }else{
        [self.pwd4Text resignFirstResponder];
    }
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.pwd4Text resignFirstResponder];
    [self.username4Text resignFirstResponder];
}



@end
