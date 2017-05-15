//
//  AppDelegate.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/3/8.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "AppDelegate.h"
#import "JDSKViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //获得系统全局的导航栏
    UINavigationBar* navBar = [UINavigationBar appearance];//appearance 通过这个获得一个全局的单例对象
    //设置标题属性 ----  自身.导航控制器.导航条  setTitle设置标题文本的属性,下面设置的属性有 ：参数1：字体大小(bold是黑体)   参数2:标题前景色
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:HHQ_HEX_COLOR(0xffffff),}];
    navBar.barTintColor = HHQ_HEX_COLOR(0x171717);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:[[JDSKViewController alloc] init]];
    
    self.window.rootViewController = naviVC;
    [self.window makeKeyAndVisible];
    return YES;

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
