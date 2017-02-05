//
//  LXDownloadWebImageOperation.m
//  LXWebImage
//
//  Created by 轩 on 2017/2/4.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import "LXDownloadWebImageOperation.h"
#import "NSString+path.h"
#import "LXWebImageCache.h"
@interface LXDownloadWebImageOperation ()
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) void(^webImageSuccess)(UIImage *img);
@property (nonatomic,copy) void(^webImageDownLoadFailed)();
@end

@implementation LXDownloadWebImageOperation

+ (instancetype)LXDownloadWebImageOperationWithImageUrl:(NSString *)imageUrl withwebImageSuccess:(void (^)(UIImage *))lxWebImageSuccess withDownloadWebImageFailed:(void (^)())webImageFailed{
    LXDownloadWebImageOperation *op = [[LXDownloadWebImageOperation alloc] init];
    op.imageUrl = imageUrl;
    [op setWebImageSuccess:^(UIImage *img) {
        lxWebImageSuccess(img);
    }];
    [op setWebImageDownLoadFailed:^{
        webImageFailed();
    }];
    return op;
}

- (void)main{
    
    if (self.isCancelled) {
        return;
    }
    
    [NSThread sleepForTimeInterval:3];
    if (self.isCancelled) {
        return;
    }
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]];
    UIImage *img = [UIImage imageWithData:data];
    if (self.isCancelled) {
        return;
    }
    [[LXWebImageCache sharedInstance] addImageDataToAppCache:data withUrl:self.imageUrl];
    if (self.isCancelled) {
        return;
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (self.isCancelled) {
            return;
        }
        if (img) {
            
            NSLog(@"从网络下载成功 %@ %@",img,[NSThread currentThread]);
            [[LXWebImageCache sharedInstance] addImageToMemoryCache:img WithUrl:self.imageUrl];
            
            if (self.webImageSuccess) {
                self.webImageSuccess(img);
            }
        }else{
            NSLog(@"从网络下载失败");
            if (self.webImageDownLoadFailed) {
                self.webImageDownLoadFailed();
            }
        }
    }];
    
}



- (void)cancel{
    [super cancel];
    NSLog(@"上一次没下载完的操作取消了 %@",[NSThread currentThread]);
}

@end
