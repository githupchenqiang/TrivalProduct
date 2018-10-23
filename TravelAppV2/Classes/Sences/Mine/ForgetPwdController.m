//
//  ForgetPwdController.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/15.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "ForgetPwdController.h"

@interface ForgetPwdController ()

@end

@implementation ForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)sendToEmail:(id)sender {
    
    if (_username4Text.text != nil && _email4Text.text != nil) {
        
        [AVUser requestPasswordResetForEmailInBackground:_email4Text.text block:^(BOOL succeeded, NSError *error) {
            
            if (succeeded) {
                
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"邮件已发送,请查收!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm =  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertVC addAction:confirm];
                [self presentViewController:alertVC animated:YES completion:nil];
                
            } else {
                
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"邮件发送失败,请再次确认验证邮箱!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm =  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertVC addAction:confirm];
                [self presentViewController:alertVC animated:YES completion:nil];
                _email4Text.text = nil;
                
            }
        }];
    }

}
- (IBAction)goBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.username4Text resignFirstResponder];
    [self.email4Text  resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
