//
//  NSString+path.h
//  04-沙盒演练
//
//  Created by Apple on 16/5/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (path)

/// 获取Documents文件 : 提示: 不可取
+ (NSString *)appendDocuments:(NSString *)icon;

- (NSString *)appendDocuments;

/// 获取Caches文件
- (NSString *)appendCaches;

/// 获取tmp文件
- (NSString *)appendTmp;

@end
