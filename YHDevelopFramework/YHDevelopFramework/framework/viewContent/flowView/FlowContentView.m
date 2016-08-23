//
//  FlowContentView.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "FlowContentView.h"

#define kTag 101

@interface FlowContentView ()

@property (nonatomic,strong) NSMutableArray *widthList;

@end

@implementation FlowContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemHeight = 18.0;
        self.itemFontSize = 13.0;
        self.rowSpace = 10;
        self.lineSpace = 10;
    }
    return self;
}
#pragma mark - define

//自定义布局子视图
- (void)customSubView {

    CGRect preFrame = CGRectMake(self.rowSpace, self.lineSpace, 0, 0);
    for (int i = 0; i < self.itemList.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        btn.tag = i + kTag;
        if (self.delegate && [self.delegate respondsToSelector:@selector(customButtonAttribute:)]) {
            [self.delegate customButtonAttribute:btn];
        } else {
            //设置按钮样式
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            btn.layer.borderWidth = 0.5;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:self.itemFontSize];
        [btn setTitle:self.itemList[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = [self getFrame:preFrame index:i];
        preFrame = btn.frame;
    }
}
//按钮点击事件
- (void)clickBtn:(UIButton *)btn {

    if (self.delegate && [self.delegate respondsToSelector:@selector(itemClickIncident:)]) {
        [self.delegate itemClickIncident:btn.tag - kTag];
    }
}
//计算按钮位置
- (CGRect)getFrame:(CGRect)preFrame index:(NSUInteger)index {

    CGRect frame;
    CGFloat rowWidth = CGRectGetMaxX(preFrame);
    if (rowWidth + self.rowSpace +[self.widthList[index] doubleValue] > self.bounds.size.width) {
        //换行
        frame = CGRectMake(self.rowSpace, CGRectGetMaxY(preFrame) + self.lineSpace, [self.widthList[index] doubleValue], self.itemHeight);
    } else {
        //不换行
        frame = CGRectMake(rowWidth + self.rowSpace, preFrame.origin.y, [self.widthList[index] doubleValue], self.itemHeight);
    }
    return frame;
}

//计算每一项的宽度
- (void)caculateWidth {

    for (NSString *str in self.itemList) {
        [self.widthList addObject:@([self stringWidth:str])];
    }
    [self customSubView];
}
//计算文本宽度
- (CGFloat)stringWidth:(NSString *)str {

    return[str boundingRectWithSize:CGSizeMake(MAXFLOAT, self.itemHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.itemFontSize]} context:nil].size.width + 16;
}

#pragma mark - getter/setter
- (void)setItemList:(NSArray *)itemList {

    _itemList = itemList;
    [self caculateWidth];
}

- (NSMutableArray *)widthList {

    if (!_widthList) {
        _widthList = [NSMutableArray array];
    }
    return _widthList;
}

@end
