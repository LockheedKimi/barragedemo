//
//  BarrageView.h
//  BarrageDemo
//
//  Created by kimi.zhang on 16/4/15.
//  Copyright © 2016年 kimi.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarrageItemView.h"
#import "UIView+Sizes.h"

@class BarrageView;
@protocol BarrageViewDelegate <NSObject>
@required
- (void)didSelectCLBarrageItem:(BarrageItemView *)barrageItem inCLBarrageView:(BarrageView *)barrageView;

@end


@interface BarrageView : UIView

@property (strong, nonatomic) NSArray *dataArray;
@property (nonatomic, retain) id<BarrageViewDelegate> delegate;

- (void)start;
- (void)stop;

- (void)continueRun;

@end
