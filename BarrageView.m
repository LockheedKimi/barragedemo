//
//  BarrageView.m
//  BarrageDemo
//
//  Created by kimi.zhang on 16/4/15.
//  Copyright © 2016年 kimi.zhang. All rights reserved.
//

#import "BarrageView.h"

#define ITEMTAG 154


@interface BarrageView()

@property (nonatomic, assign) NSInteger selectedItem;
@property (nonatomic, assign) NSInteger timeRuning;

@end

@implementation BarrageView {
    NSTimer *_barrageTimer;
    NSInteger _curIndex;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.userInteractionEnabled = YES;
        [self setClipsToBounds:YES];
        
        _curIndex = 0;
        self.selectedItem = -1;
        self.timeRuning = 0;
    }
    return self;
}

- (void)start {
    if (self) {
        self.hidden = NO;
        if (_dataArray && _dataArray.count > 0) {
            if (!_barrageTimer) {
                _barrageTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(postView) userInfo:nil repeats:YES];
            }
        }
    }
}

- (void)stop {
    if (self) {
        self.hidden = YES;
        if (_barrageTimer) {
            [_barrageTimer invalidate];
            _barrageTimer = nil;
        }
    }
}

- (void)continueRun {
    self.selectedItem = -1;
}

- (void)postView {
    
    self.timeRuning++;
    
    for (BarrageItemView *view in self.subviews) {
        if ([view isKindOfClass:[BarrageItemView class]]) {
            
            if (view.itemIndex != self.selectedItem) {
                view.left -= 0.5;
                if (view.left <= -view.width) {
                    [view removeFromSuperview];
                }
            } else {
                if ([self.delegate respondsToSelector:@selector(didSelectCLBarrageItem:inCLBarrageView:)]) {
                    [self.delegate didSelectCLBarrageItem:view inCLBarrageView:self];
                }
            }
        }
    }
    
    if (_dataArray && _dataArray.count > 0 && self.timeRuning % 100 == 0) {
        
        self.timeRuning = 0;
        
        int indexPath = random()%(int)((self.frame.size.height)/40);
        int top = indexPath * 42;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        _curIndex = _dataArray.count <= _curIndex ? 0 : _curIndex;
        NSDictionary *dict = _dataArray[_curIndex];
        
        id avatar = [dict objectForKey:@"avatar"];
        NSString *content = [dict objectForKey:@"content"];
        
        for (BarrageItemView *view in self.subviews) {
            if ([view isKindOfClass:[BarrageItemView class]] && view.tag == indexPath + ITEMTAG) {
                return;
            }
            
            if (view.itemIndex == _curIndex) {
                return;
            }
            
            if (view.frame.origin.y == top) {
                return;
            }
        }
        
        BarrageItemView *item = [[BarrageItemView alloc] initWithFrame:CGRectMake(screenWidth, top, 10, 30)];
        [item setAvatar:avatar withContent:content];
        item.itemIndex = _curIndex;
        item.tag = indexPath + ITEMTAG;
        [self addSubview:item];
        _curIndex++;
    }
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    NSInteger clickItem = -1;
    
    if ([touch.view isKindOfClass:[BarrageItemView class]]) {
        BarrageItemView *item = (BarrageItemView *)touch.view;
        clickItem = item.itemIndex;
    } else if ([touch.view isKindOfClass:[UIImageView class]] || [touch.view isKindOfClass:[UILabel class]]) {
        clickItem = touch.view.tag;
    }
    
    self.selectedItem = clickItem;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
