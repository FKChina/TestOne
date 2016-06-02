//
//  UIImage+JSQuanJuImage.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/23.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "UIImage+JSQuanJuImage.h"

@implementation UIImage (JSQuanJuImage)

#pragma mark 返回拉伸好的图片
+ (UIImage *)resizeImage:(NSString *)imgName {
    return [[UIImage imageNamed:imgName] resizeImage];
}

- (UIImage *)resizeImage
{
    CGFloat leftCap = self.size.width * 0.5f;
    CGFloat topCap = self.size.height * 0.5f;
    return [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

- (UIImage *)cut:(CGSize)sizeScale
{
    CGFloat width = self.size.width * sizeScale.width;
    CGFloat height = self.size.height * sizeScale.height;
    CGFloat x = (self.size.width -  width) * 0.5;
    CGFloat y = (self.size.height - height) * 0.5;
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef ref = CGImageCreateWithImageInRect(self.CGImage, rect);
    return [UIImage imageWithCGImage:ref];
}

@end
