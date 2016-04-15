//
//  BarrageItemView.m
//  BarrageDemo
//
//  Created by kimi.zhang on 16/4/15.
//  Copyright © 2016年 kimi.zhang. All rights reserved.
//

#import "BarrageItemView.h"
#import "UIView+Sizes.h"

@interface BarrageItemView()

@property (nonatomic, retain) UIImageView *avatarView;

@property (nonatomic, retain) UILabel *contentLabel;

@end

@implementation BarrageItemView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
        
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 4, 22, 22)];
        [_avatarView.layer setCornerRadius:22 / 2];
        [_avatarView.layer setMasksToBounds:YES];
        [_avatarView setUserInteractionEnabled:YES];
        [_avatarView.layer setBorderWidth:1.0];
        [_avatarView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self addSubview:_avatarView];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 6, 1, 30)];
        [_contentLabel setBackgroundColor:[UIColor clearColor]];
        [_contentLabel setFont:[UIFont systemFontOfSize:14]];
        [_contentLabel setTextColor:[UIColor whiteColor]];
        [_contentLabel setNumberOfLines:1];
        [_contentLabel setUserInteractionEnabled:YES];
        [self addSubview:_contentLabel];
        
        [self setUserInteractionEnabled:YES];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:15];
        [self setClipsToBounds:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [_avatarView setTag:self.itemIndex];
    [_contentLabel setTag:self.itemIndex];
}

#pragma mark - set Method
- (void)setAvatar:(id)avatar withContent:(NSString *)content {
    if ([avatar isKindOfClass:[UIImage class]]) {
        [self setAvatarWithImage:avatar withContent:content];
    } else if ([avatar isKindOfClass:[NSString class]]){
        UIImage *image = [UIImage imageNamed:avatar];
        if (image) {
            [self setAvatarWithImage:image withContent:content];
        } else {
            [self setAvatarUrl:avatar withContent:content];
        }
    } else {
        [self setAvatarWithImageString:@"" withContent:content];
    }
}

- (void)setAvatarUrl:(NSString *)imageUrl withContent:(NSString *)content {
    //    [_avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    [_contentLabel setText:content];
    [_contentLabel sizeToFit];
    self.width = _contentLabel.width + 45;
}

- (void)setAvatarWithImage:(UIImage *)image withContent:(NSString *)content {
    [_avatarView setImage:image];
    [_contentLabel setText:content];
    [_contentLabel sizeToFit];
    self.width = _contentLabel.width + 45;
}

- (void)setAvatarWithImageString:(NSString *)imageStr withContent:(NSString *)content {
    [self setAvatarWithImage:[UIImage imageNamed:imageStr] withContent:content];
}

- (CGSize)getSizeWithText:(NSString *)text andFontSize:(CGFloat)size inWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    return [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size], NSParagraphStyleAttributeName:paragraphStyle}
                              context:nil].size;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
