//
//  BarrageItemView.h
//  BarrageDemo
//
//  Created by kimi.zhang on 16/4/15.
//  Copyright © 2016年 kimi.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarrageItemView : UIView

@property (assign, nonatomic) NSInteger itemIndex;


- (void)setAvatar:(id)avatar withContent:(NSString *)content;

- (void)setAvatarUrl:(NSString *)imageUrl withContent:(NSString *)content;

- (void)setAvatarWithImage:(UIImage *)image withContent:(NSString *)content;

- (void)setAvatarWithImageString:(NSString *)imageStr withContent:(NSString *)content;

@end
