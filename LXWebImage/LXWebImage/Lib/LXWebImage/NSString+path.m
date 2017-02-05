//
//  NSString+path.m
//  04-沙盒演练
//
//  Created by Apple on 16/5/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

+ (NSString *)appendDocuments:(NSString *)icon
{
    // 获取Documents文件路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取图片的文件名
    NSString *fileName = [icon lastPathComponent];
    
    // Documents文件路径 拼接 文件名
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    return filePath;

}

- (NSString *)appendDocuments
{
    // 获取Documents文件路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取图片的文件名
    NSString *fileName = [self lastPathComponent];
    
    // Documents文件路径 拼接 文件名
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    return filePath;
    
}

- (NSString *)appendCaches
{
    // 获取Caches文件路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取图片名字
    NSString *fileName = [self lastPathComponent];
    
    // 拼接
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

- (NSString *)appendTmp
{
    // 获取tmp文件路径
    NSString *tmpPath = NSTemporaryDirectory();
    
    // 获取图片名字
    NSString *fileName = [self lastPathComponent];
    
    // 拼接
    NSString *filePath = [tmpPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

@end
