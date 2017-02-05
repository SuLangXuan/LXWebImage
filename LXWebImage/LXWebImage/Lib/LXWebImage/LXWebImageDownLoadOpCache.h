//
//  LXWebImageDownLoadOpCache.h
//  LXWebImage
//
//  Created by 轩 on 2017/2/5.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LXWebImageDownLoadOpCache : NSObject
- (void)LXWebImageDownLoadOpCacheWithUrl:(NSString *)url backImage:(void(^)(UIImage *img))webImageBack;
/** 单例 */
//+ (instancetype)sharedInstance;
KsingleTon_h(Instance)
//取消当前正在下载的操作。
- (void)cancelCurrentOp;
@end
