//
//  ViewController.m
//  BarrageDemo
//
//  Created by kimi.zhang on 16/4/15.
//  Copyright © 2016年 kimi.zhang. All rights reserved.
//

#import "ViewController.h"
#import "BarrageView.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *barrageView;
@property (weak, nonatomic) IBOutlet UITextField *addMeaage;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *starBtn;

@property (nonatomic, retain) NSMutableArray *barrageList;
@property (nonatomic, retain) BarrageView *showView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.showView = [[BarrageView alloc] initWithFrame:CGRectMake(0, 64,self.barrageView.frame.size.width, self.barrageView.frame.size.height)];
    [self.barrageView addSubview:self.showView];
    
    self.barrageList = [[NSMutableArray alloc] init];
    [self.barrageList addObject:@{@"avatar":@"barrage", @"content":@"1"}];
    [self.barrageList addObject:@{@"avatar":@"barrage", @"content":@"2"}];
    [self.barrageList addObject:@{@"avatar":@"barrage", @"content":@"3"}];
    [self.barrageList addObject:@{@"avatar":@"barrage", @"content":@"4"}];
    [self.barrageList addObject:@{@"avatar":@"barrage", @"content":@"这都是什么需求啊"}];
    [self.barrageList addObject:@{@"avatar":@"barrage", @"content":@"我也真是醉了"}];
    [self.barrageList addObject:@{@"avatar":@"barrage", @"content":@"吐槽吐槽，疯狂吐槽"}];
    [self.barrageList addObject:@{@"avatar":@"barrage", @"content":@"分分钟想把电脑砸了"}];
    
    self.addMeaage.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.addMeaage resignFirstResponder];
    return YES;
}

- (IBAction)barrageViewStaringShowAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if (!btn.selected) {
        NSArray *arr = [[NSArray alloc] initWithArray:self.barrageList];
        [self.showView setDataArray:arr];
        [self.showView start];
    } else {
        [self.showView stop];
    }
    btn.selected = !btn.selected;
}
- (IBAction)sendMessageAndShowMessageAction:(id)sender {
    NSString *message = self.addMeaage.text;
    if (message.length > 0) {
        NSDictionary *dic = @{@"avatar":@"Logo2", @"content":message};
        [self.barrageList addObject:dic];
        
        NSArray *arr = [[NSArray alloc] initWithArray:self.barrageList];
        [self.showView setDataArray:arr];
        
        self.addMeaage.text = @"";
    }
}
- (IBAction)cancelBarrageShowAction:(id)sender {
    [self.showView continueRun];
}

@end
