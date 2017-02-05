//
//  UIImageView+LXWebImage.m
//  LXWebImage
//
//  Created by 轩 on 2017/2/4.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import "UIImageView+LXWebImage.h"

@implementation UIImageView (LXWebImage)
- (void)lx_setImageWithURLStr:(NSString *)url{
    [self lx_setImageWithURLStr:url WithPlaceHoder:nil];
}

- (void)lx_setImageWithURLStr:(NSString *)url WithPlaceHoder:(UIImage *)placeHoderImg{
    if (placeHoderImg) {self.image = placeHoderImg;}
    __weak typeof(self) weakSelf = self;
    [[LXWebImageManger sharedInstance] lxWebImageMangerWithURL:url webImageBack:^(UIImage *img) {
        if (img) {weakSelf.image = img;}
    }];
}

- (void)dealloc{
    //取消正在执行的下载操作。
#pragma mark 换成列表加载多张图片，看一下是只要取消当前的正在下载的图片，还是取消全部。
    NSLog(@"%s",__func__);
    [LXWebImageManger cancleAllDownloadingOp];
}

@end
