//
//  DroiOAuthTest.m
//  CoreSDKDemo
//
//  Created by Jon on 16/8/25.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiOAuthTest.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "DroiLog.h"
@interface DroiOAuthTest ()

@end

@implementation DroiOAuthTest



- (void)demoQQBind{
    
    [self bindWithType:AUTH_TYPE_QQ];
}

- (void)demoQQLogin{
    
    [self loginWithType:AUTH_TYPE_QQ];

}

- (void)demoWeiXBind{
    
    [self bindWithType:AUTH_TYPE_WEIXIN];
}

- (void)demoWeiXLogin{
    
    [self loginWithType:AUTH_TYPE_WEIXIN];
}

- (void)demoWeiboBind{
    
    [self bindWithType:AUTH_TYPE_SINA];
}

- (void)demoWeiboLogin{
    
    [self loginWithType:AUTH_TYPE_SINA];
}



- (void)bindWithType:(AuthType)type{
    
    DroiOAuthProvider* provider = [DroiOAuthProvider providerWithType:type];
    DroiUser* user = [DroiUser getCurrentUser];
    [user bindOAuth:provider callback:^(BOOL result, DroiError *error) {
        if (error.isOk) {
            DroiLog(@"bind sucess");
        }
        else{
            DroiLog(@"bind error:%@",error.message);
        }
    }];
    
}

- (void)loginWithType:(AuthType)type{

    DroiOAuthProvider* provider = [DroiOAuthProvider providerWithType:type];
    [DroiUser loginWithOAuth:provider callback:^(DroiUser *user, DroiError *error) {
        if (error.isOk) {
            DroiLog(@"loginWithOAuth sucess:%@",user);
        }
        else{
            DroiLog(@"bind error:%@",error.message);
        }
    }];
}

@end
