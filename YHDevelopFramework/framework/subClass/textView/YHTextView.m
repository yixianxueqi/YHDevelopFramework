//
//  YHTextView.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/28.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHTextView.h"
#import "NSString+RegularCheck.h"

@interface YHTextView ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation YHTextView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _regularLength = NSIntegerMax;
        [self addPlaceHold];
        [self addRegularCheckForSelf];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _regularLength = NSIntegerMax;
        [self addPlaceHold];
        [self addRegularCheckForSelf];
    }
    return self;
}

#pragma mark - private
- (void)addPlaceHold {

    [self addSubview:self.placeHolderLabel];
    [self setValue:self.placeHolderLabel forKey:@"_placeholderLabel"];
    
}

- (void)addRegularCheckForSelf {

    self.delegate = self;
}


/**
 中文判断处理

 @param textView UITextView
 @return 是否处于高亮状态
 */
- (BOOL)checkChineseCharacter:(UITextView *)textView {

    UITextRange *range = textView.markedTextRange;
    UITextPosition *posit = [textView positionFromPosition:range.start offset:0];
    if (range && posit) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:range.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:range.end];
        NSRange range = NSMakeRange(startOffset, startOffset-endOffset);
        if (range.location < self.regularLength) {
            //..是否越界
        }
        return YES;
    }
    return NO;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {

    BOOL result = [self checkChineseCharacter:textView];
    if (result) {
        return;
    }
    if (textView.text.length > self.regularLength) {
        textView.text = [textView.text substringToIndex:self.regularLength];
        if (self.resultBlock) {
            self.resultBlock(0);
        }
        return;
    }
    if (self.resultBlock) {
        self.resultBlock(self.regularLength - textView.text.length);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if (self.regularLength != NSIntegerMax) {
        BOOL result = [self checkChineseCharacter:textView];
        if (result) {
            return YES;
        }
    }
    if (self.regularRule) {
        NSString *inputStr = [NSString stringWithFormat:@"%@%@",textView.text,text];
        return [inputStr regularCheck:self.regularRule];
    }
    return true;
}

#pragma mark - getter/setter
- (UILabel *)placeHolderLabel {

    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        [_placeHolderLabel sizeToFit];
    }
    return _placeHolderLabel;
}

- (void)setPlaceHolder:(NSString *)placeHolder {

    _placeHolder = placeHolder;
    self.placeHolderLabel.text = placeHolder;
}

@end
