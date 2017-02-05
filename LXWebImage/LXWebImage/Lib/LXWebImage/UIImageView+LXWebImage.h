//
//  UIImageView+LXWebImage.h
//  LXWebImage
//
//  Created by 轩 on 2017/2/4.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXWebImageManger.h"
@interface UIImageView (LXWebImage)
- (void)lx_setImageWithURLStr:(NSString *)url;
- (void)lx_setImageWithURLStr:(NSString *)url WithPlaceHoder:(UIImage *)placeHoderImg;

@end
