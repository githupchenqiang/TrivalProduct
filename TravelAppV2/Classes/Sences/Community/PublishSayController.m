//
//  PublishSayController.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/12.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "PublishSayController.h"
#import "LoginController.h"

@interface PublishSayController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *tutuImg;
@property (weak, nonatomic) IBOutlet UIButton *addImgButton;


@end

@implementation PublishSayController
- (IBAction)sendAction:(id)sender {
    NSData *imageData = UIImagePNGRepresentation(self.tutuImg.image);
    AVFile *imageFile = [AVFile fileWithName:@"imageComment.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            AVObject *post = [AVObject objectWithClassName:@"Post"];
            post[@"byUser"] = [AVUser currentUser];
            post[@"content"] = self.text4Say.text;
            //            post[@"imageComments"] = imageFile;
            [post setObject:imageFile forKey:@"imageComments"];
            post[@"byUsername"] = [AVUser currentUser][@"nickname"];
            [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                }else{
                    NSLog(@"发表说说失败.");
                }
            }];
        }else{
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (IBAction)addImgAction:(id)sender {
    NSLog(@"呀!被点了!");
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.delegate = self;
    pick.allowsEditing = YES;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera; //默认 是相机
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    pick.sourceType = sourceType;
    [self presentViewController:pick animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.text4Say.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(pushSay)];
}

- (void)pushSay{
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.delegate = self;
    pick.allowsEditing = YES;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //默认 是相机
    pick.sourceType = sourceType;
    [self presentViewController:pick animated:YES completion:nil];
}

#pragma mark Camera View Delegate Methods
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
 
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:) withObject:img afterDelay:0];
    [picker dismissViewControllerAnimated:YES completion:nil];

}

    //在此处将头像保存到 服务器
- (void)saveImage:(UIImage *)img{
    if ([AVUser currentUser] == nil) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"发表说说失败!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cencel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *confirm =  [UIAlertAction actionWithTitle:@"去登陆?" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *  action) {
            //去登陆
            LoginController *lg = [[LoginController alloc] init];
            [self showDetailViewController:lg sender:nil];
        }];
        [alertVC addAction:cencel];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    self.tutuImg.image = img;
    self.addImgButton.hidden = YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.text4Say resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.text4Say resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
