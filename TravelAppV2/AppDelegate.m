//
//  AppDelegate.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "AppDelegate.h"
//#import "WeiboSDK.h"
#import "GetUserHelp.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>

#define KAppkey @"2479872985"
#define KRedirectURL @"https://api.weibo.com/oauth2/default.html"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [WeiboSDK enableDebugMode:YES];
//    BOOL result = [WeiboSDK registerApp:KAppkey];
    
    
    [AVOSCloud setApplicationId:@"iLY7WbQ3UX0bTt5kGi7GIbB0"
                      clientKey:@"b1wBNXMJqdA0Kt8tiingJe7b"];
    //存储用户的偏好设置,存储在本地,比如:程序是否是第一次加载
    if (! [[NSUserDefaults standardUserDefaults] boolForKey:@"aa"]) {
        NSLog(@"第一次启动");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"aa"];
        //立即同步
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController * VC = [story instantiateViewControllerWithIdentifier:@"GuideFigure"];
        self.window.rootViewController = VC;
        
    }else{
        NSLog(@"不是第一次启动");
    }
    
    //5bce95ecf1f556b828000315
    
    [UMConfigure initWithAppkey:@"5bce95ecf1f556b828000315" channel:@""];
    [[UMSocialManager defaultManager]openLog:YES];
    [self configUSharePlatforms];
//    [AVUser logOut];
//
    return YES;
}

- (void)configUSharePlatforms{
 
//     设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx4926d8d360997439" appSecret:@"9cbc53902ab0130527f6310b6d26fcd9" redirectURL:@"http://mobile.umeng.com/social"];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1107920956"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];

}


#pragma mark -- WeiboSDKDelegate --
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
    
}



//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}

//- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
//    NSLog(@"%@",request);
//}
//
//- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
//
//    if (response.userInfo!=nil) {
//        NSLog(@"收到响应,token:%@,uid:%@",response.userInfo[@"access_token"],response.userInfo[@"uid"]);
//        NSString *access = response.userInfo[@"access_token"];
//        NSString *uid = response.userInfo[@"uid"];
//        NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",access,uid];
//        [GetUserHelp shareHandle].userInfoUrl = url;
//        [[GetUserHelp shareHandle]getUserInfoWithBlock:^{
//            AVUser *user = [AVUser user];
//            user[@"nickname"] = [GetUserHelp shareHandle].username;
//            user.username = [GetUserHelp shareHandle].username;
//            user.password = @"111111";
//            AVFile *file = [AVFile fileWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[GetUserHelp shareHandle].imgUrl]]];
//            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    user[@"Avatar"] = file;
//                    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                        if (succeeded) {
//                            NSLog(@"微博用户信息保存成功");
//                                [[NSNotificationCenter defaultCenter] postNotificationName:@"weiboUser" object:nil userInfo:@{@"information":user}];
//                        }else{
//                        }
//                    }];
//                }else{
//                    NSLog(@"微博用户图像上传失败");
//                }
//            }];
//
//        }];
//    }
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
