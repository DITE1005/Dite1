//
//  PublishTextView.m
//  POPDecayAnimation
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PublishTextView.h"
#import "UIView+Extension.h"

@interface PublishTextView ()
@property (nonatomic, weak) UILabel *placehoderLable;

@end

@implementation PublishTextView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        // 添加一个显示提醒文字的label
        UILabel *placehoderLabel = [[UILabel alloc] init];
        // 设置只适应高度
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
     
        [self addSubview:placehoderLabel];
        
        self.placehoderLable = placehoderLabel;
        // 设置默认的占位文字颜色
        self.placehoderColor = [UIColor lightGrayColor];
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        // 监听内部文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
// 移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- 监听文字改变 --
-(void)textDidChange{
    // 是否隐藏 ==
    // hasText: 一个一个布尔值,用于显示的文本对象是否有任何文本
    self.placehoderLable.hidden = self.hasText;
}
// 标签的文本设置为🈯️ 的字符串
// 设置文本属性
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

-(void)setPlacehoder:(NSString *)placehoder{
    _placehoder = [placehoder copy];
    //  设置文字
    self.placehoderLable.text = placehoder;
    // 重新计算子控件
    [self setNeedsLayout];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placehoderLable.font = [UIFont systemFontOfSize:15];
    // 重新计算子控件的frame
    [self setNeedsLayout];
}

-(void)setPlacehoderColor:(UIColor *)placehoderColor{
    _placehoderColor = placehoderColor;
    // 设置颜色
    self.placehoderLable.textColor = placehoderColor;
}

-(void)setContentInset:(UIEdgeInsets)contentInset{
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}

//- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.placehoderLable.x = 5;
    self.placehoderLable.y = 8;
    self.placehoderLable.width = self.width - 2 * self.placehoderLable.x;
    
    // 根据文字计算label的高度
    CGSize maxSize = CGSizeMake(self.placehoderLable.width, MAXFLOAT);
#warning message ----
    
    CGSize placehoderSize = [self.placehoder sizeWithFont:self.placehoderLable.font maxSize:maxSize];
    
    self.placehoderLable.height = placehoderSize.height;
    
}

//+(CGFloat)textHeightFromMode:(PublishTextView *)string{
//     CGRect rect = [string.placehoder boundingRectWithSize:CGSizeMake(kScreenWidth, 500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
//    return rect.size.height;
//}
//+(CGFloat *)cellHeight:(PublishTextView *)string{
//    CGSize maxSize = CGSizeMake(string.placehoderLable.width, MAXFLOAT);
//    
//}

//// cell整体的高度
//+ (CGFloat)cellHeight:(Person *)person {
//    // cell固定部分高度（代指实际开发中不需自适应，有固定高度的控件和间隙所共同占有高度的总和）
//    CGFloat staticHeight = 10;
//    // cell不固定部分的高度（需要自适应，因内容而变化的控件的高度）
//    CGFloat dynamicHeight = [self textHeightFromMode:person];
//    // cell的高度等于固定内容 + 变化的部分
//    return staticHeight + dynamicHeight;
//    
//}
//
//


@end
