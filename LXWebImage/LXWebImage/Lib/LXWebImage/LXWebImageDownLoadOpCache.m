//
//  LXWebImageDownLoadOpCache.m
//  LXWebImage
//
//  Created by 轩 on 2017/2/5.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import "LXWebImageDownLoadOpCache.h"
#import "LXDownloadWebImageOperation.h"

@interface LXWebImageDownLoadOpCache ()
@property (nonatomic,strong)NSOperationQueue *queue;
@property (nonatomic,strong)NSMutableDictionary *downloadOpCache;
/** 上一次在下载的操作 */
@property (nonatomic,copy)NSString *theLastOpUrl;
/** 当前正在下载的操作 */
@property (nonatomic,copy) NSString *currentOpUrl;
@end

@implementation LXWebImageDownLoadOpCache

+ (void)initialize{
    LXWebImageDownLoadOpCache *opCache = [self sharedInstance];
    [[NSNotificationCenter defaultCenter] addObserver:opCache selector:@selector(cancelLastOp) name:kCancelLastOp object:nil];
}

- (void)cancelCurrentOp{
    LXDownloadWebImageOperation *op = [self.downloadOpCache valueForKey:self.currentOpUrl];
    if (op != nil) {
        [op cancel];
        NSLog(@"当前正在下载的取消了");
        [self.downloadOpCache removeObjectForKey:self.currentOpUrl];
    }
}

- (void)cancelLastOp{
    //如果用OPeration来保存的话，就算取消了操作，但缓存池中还有，每次进来如果操作一样就会在缓存池中找到，但实际该操作是已经取消的了，不会下载，所以会没反应
    LXDownloadWebImageOperation *theLastOp = [self.downloadOpCache valueForKey:self.theLastOpUrl];
    if (theLastOp != nil) {
        [theLastOp cancel];
        [self.downloadOpCache removeObjectForKey:self.theLastOpUrl];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCancelLastOp object:nil];
}

- (void)LXWebImageDownLoadOpCacheWithUrl:(NSString *)url backImage:(void(^)(UIImage *img))webImageBack{
    
    if ([self checkOPHadWithUrl:url] == YES) {
        NSLog(@"该操作正在下载。。。");
        return;
    }
    
    //新建操作前把上一次没有完成的操作取消掉。
    [self cancelLastOp];
    NSLog(@"没有该操作，新建下载 ");
    self.currentOpUrl = url;
    LXDownloadWebImageOperation *downloadOp = [LXDownloadWebImageOperation LXDownloadWebImageOperationWithImageUrl:url withwebImageSuccess:^(UIImage *img) {
        webImageBack(img);
        [self.downloadOpCache removeObjectForKey:url];
    } withDownloadWebImageFailed:^{
        [self.downloadOpCache removeObjectForKey:url];
    }];
    
    [self.queue addOperation:downloadOp];
    self.theLastOpUrl = url;
    [self.downloadOpCache setObject:downloadOp forKey:url];
    
}



- (BOOL)checkOPHadWithUrl:(NSString *)url{
    if ([self.downloadOpCache objectForKey:url] != nil) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 懒加载 getter & setter
- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (NSMutableDictionary *)downloadOpCache{
    if (!_downloadOpCache) {
        _downloadOpCache = [NSMutableDictionary dictionary];
    }
    return _downloadOpCache;
}

KsingleTon_m(Instance)

@end
