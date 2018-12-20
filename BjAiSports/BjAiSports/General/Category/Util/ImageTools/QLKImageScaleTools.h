//
//  QLKImageScaleTools.h
//  CloudsOutpatient
//
//  Created by 吴林丰 on 2018/7/17.
//  Copyright © 2018年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QLKImageScaleTools : NSObject
/**
 * 参照微信压缩的思路进行压缩图片
 * 宽高均<= 1280，图片尺寸大小保持不变
 * 宽或高> 1280 &&宽高比<= 2，取较大值等于1280，较小值等比例压缩
 * 宽或高> 1280 &&宽高比> 2 &&宽或高<1280，图片尺寸大小保持不变
 * 宽高均> 1280 &&宽高比> 2，取较小值等于1280，较大值等比例压缩
 * 优点：压缩速度相对较快，清晰度基本可以要求达到
 * 缺点：可能达不到指定压缩大小
 */
+ (NSData*)compressOfImageWithWeiChat:(UIImage*)source_image
                              maxSize:(NSInteger)maxSize;

/**
 * 图像进行等比例压缩
 * 图像宽度参照1242px进行等比例缩
 * 优点：图像不会变形，压缩时间适中
 * 缺点：可能达不到指定压缩大小
 */
+ (NSData *)compressOfImageWithEqualProportion:(UIImage *)source_image
                                       maxSize:(NSInteger)maxSize;


/**
 * 二分法压缩图像
 * 先判断当前质量是否满足要求，再不满足进行压缩图像
 * 优点：压缩能到指定大小
 * 缺点：压缩相对较慢，图像清晰度可能达不到，不建议小图片用此方法
 */
+ (NSData *)compressOfImageWithTwoPoints:(UIImage *)source_image
                                 maxSize:(NSInteger)maxSize;

/**
 压缩图片保证不虚
 
 @param image 原图
 @param size 限制大小，单位：M
 @return 压缩后的图片数据
 */
+ (NSData *)zipImageWithImage:(UIImage *)image maxSize:(CGFloat)size;
@end
