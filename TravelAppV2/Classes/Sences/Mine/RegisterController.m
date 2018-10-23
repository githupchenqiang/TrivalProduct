//
//  RegisterController.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/10.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()<UITextFieldDelegate>

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username4Text.delegate =self;
    self.pwd4Text.delegate = self;
    self.emil4Text.delegate = self;
    self.surePwd4Text.delegate = self;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view from its nib.
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (IBAction)registerAction:(id)sender {
    
    if ([_surePwd4Text.text isEqualToString: _pwd4Text.text]) {
        
        if ([self validateEmail:_emil4Text.text] ) {
            
            AVUser *user = [AVUser user];
            user.username = _username4Text.text;
            user.password =  _pwd4Text.text;
            user.email = _emil4Text.text;
            user[@"nickname"] = _username4Text.text;
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注册成功!" message:@"请到邮箱进行验证,否则不能登录." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirm =  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alertVC addAction:confirm];
                    [self presentViewController:alertVC animated:YES completion:nil];
                } else {
                    
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"注册失败！" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirm =  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alertVC addAction:confirm];
                    [self presentViewController:alertVC animated:YES completion:nil];
                }
            }];
        }else{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"邮箱错误,请重新确认!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm =  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:confirm];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
        
    }else{
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码输入不一致,请重新确认!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm =  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
        //        _surePwd4Text.text = nil;
        
    }}

-(IBAction)backButtonsender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)validateEmail:(NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark   --回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.username4Text resignFirstResponder];
    [self.pwd4Text  resignFirstResponder];
    [self.surePwd4Text  resignFirstResponder];
    [self.emil4Text  resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.username4Text resignFirstResponder];
    [self.pwd4Text resignFirstResponder];
    [self.surePwd4Text resignFirstResponder];
    [self.emil4Text resignFirstResponder];
    return YES;
}

@end
