//
//  LXWebImageManger.h
//  LXWebImage
//
//  Created by 轩 on 2017/2/4.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LXWebImageManger : NSObject
- (void)lxWebImageMangerWithURL:(NSString *)imageUrl webImageBack:(void(^)(UIImage *img))webImageBack;
/** 单例 */
KsingleTon_h(Instance)
+ (void) cleanWebCache;
+ (void) cancleAllDownloadingOp;
@end
