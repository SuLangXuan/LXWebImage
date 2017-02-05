//
//  LXDownloadWebImageOperation.h
//  LXWebImage
//
//  Created by 轩 on 2017/2/4.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXDownloadWebImageOperation : NSOperation

+ (instancetype)LXDownloadWebImageOperationWithImageUrl:(NSString *)imageUrl withwebImageSuccess:(void(^)(UIImage *img))lxWebImageSuccess withDownloadWebImageFailed:(void(^)())webImageFailed;
@end
