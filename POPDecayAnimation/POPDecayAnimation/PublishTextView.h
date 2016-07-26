//
//  PublishTextView.h
//  POPDecayAnimation
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishTextView : UITextView

// 占位文字
@property (nonatomic, copy) NSString *placehoder;

// 占位文字的颜色
@property (nonatomic, strong) UIColor *placehoderColor;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
