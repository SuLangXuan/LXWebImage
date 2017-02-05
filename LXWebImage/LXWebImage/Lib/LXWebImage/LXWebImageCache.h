//
//  LXWebImageCache.h
//  LXWebImage
//
//  Created by 轩 on 2017/2/5.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 用于缓存的类。
 */
@interface LXWebImageCache : NSObject

/** 单例 */
//+ (instancetype)sharedInstance;
KsingleTon_h(Instance)

/**
 根据图片url查询缓存（先查内存，没有再查缓存）中有没有，如果有就返回图片，没有就下载然后再返回。

 @param url 图片url
 @param haveImage 图片的回调
 @param downLoadImage 下载图片的回调操作
 */
- (void)queryImageWithUrl:(NSString *)url haveImageBlock:(void(^)(UIImage *img))haveImage downLoadImage:(void(^)())downLoadImage;

///把图片添加到内存中
- (void)addImageToMemoryCache:(UIImage *)img WithUrl:(NSString *)url;
///把图片添加到沙盒中
- (void)addImageDataToAppCache:(NSData *)imgData withUrl:(NSString *)url;
///清除内存中的图片
+ (void)cleanWebImageMemoryCache;
@end
