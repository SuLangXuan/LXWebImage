//
//  LXWebImageManger.m
//  LXWebImage
//
//  Created by 轩 on 2017/2/4.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import "LXWebImageManger.h"
#import "LXDownloadWebImageOperation.h"
#import "NSString+path.h"
#import "LXWebImageCache.h"
#import "LXWebImageDownLoadOpCache.h"

@interface LXWebImageManger ()

@end

@implementation LXWebImageManger

KsingleTon_m(Instance)

- (void)lxWebImageMangerWithURL:(NSString *)imageUrl webImageBack:(void(^)(UIImage *img))webImageBack{
    [[LXWebImageCache sharedInstance] queryImageWithUrl:imageUrl haveImageBlock:^(UIImage *img) {
        //有返回。
        webImageBack(img);
    } downLoadImage:^{
        [[LXWebImageDownLoadOpCache sharedInstance] LXWebImageDownLoadOpCacheWithUrl:imageUrl backImage:^(UIImage *img) {
            webImageBack(img);
        }];
    }];
}


+ (void)cleanWebCache{
    [LXWebImageCache cleanWebImageMemoryCache];
}

+ (void)cancleAllDownloadingOp{
    [[LXWebImageDownLoadOpCache sharedInstance] cancelCurrentOp];
}


@end
