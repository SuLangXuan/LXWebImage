//
//  LXWebImageCache.m
//  LXWebImage
//
//  Created by 轩 on 2017/2/5.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import "LXWebImageCache.h"
#import "NSString+path.h"
@interface LXWebImageCache ()
@property (nonatomic,strong)NSMutableDictionary *imageCache;

@end

@implementation LXWebImageCache

KsingleTon_m(Instance)

- (void)addImageToMemoryCache:(UIImage *)img WithUrl:(NSString *)url{
    NSLog(@" 添加到内存中 %@",[NSThread currentThread]);
    [self.imageCache setObject:img forKey:url];
}

- (void)addImageDataToAppCache:(NSData *)imgData withUrl:(NSString *)url{
    if (imgData != nil) {
        NSLog(@" 写入沙盒中 %@",[NSThread currentThread]);
        [imgData writeToFile:[url appendCaches] atomically:YES];
    }
}

+ (void)cleanWebImageMemoryCache{
    [[LXWebImageCache sharedInstance].imageCache removeAllObjects];
}

///查询内存与沙盒中有没有图片
- (void)queryImageWithUrl:(NSString *)url haveImageBlock:(void(^)(UIImage *img))haveImage downLoadImage:(void(^)())downLoadImage{
    
    //检查内存中有没有图片
    if ([self queryImageInMemoryWithURL:url]) {
        NSLog(@"从内存中加载 %@",[NSThread currentThread]);
        haveImage([self.imageCache valueForKey:url]);
        //如果第二次的url内存中有，还要取消上一次的还在下载的操作。
        [[NSNotificationCenter defaultCenter] postNotificationName:kCancelLastOp object:nil];
        return;
    }
    
    //检查沙盒中有没有图片
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[url appendCaches]];
    //    NSData *data = [NSData dataWithContentsOfFile:cachePathForWebImage];
    if (cacheImage != nil) {
        NSLog(@"从沙盒中加载 %@",[NSThread currentThread]);
        [self.imageCache setValue:cacheImage forKey:url];
        //如果第二次的url沙盒中有，还要取消上一次的还在下载的操作。
        [[NSNotificationCenter defaultCenter] postNotificationName:kCancelLastOp object:nil];
        haveImage(cacheImage);
        return;
    }
    
    downLoadImage();
    
    
}

///检查内存中有没有对应网络图片的缓存
- (BOOL)queryImageInMemoryWithURL:(NSString *)url{
    if ([self.imageCache objectForKey:url] != nil) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 懒加载 getter & setter
- (NSMutableDictionary *)imageCache{
    if (!_imageCache) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}
@end
