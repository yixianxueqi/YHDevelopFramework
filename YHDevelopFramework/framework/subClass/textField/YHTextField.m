//
//  YHTextField.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/29.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHTextField.h"
#import "NSString+RegularCheck.h"

@interface YHTextField ()<UITextFieldDelegate>

@end

@implementation YHTextField

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _regularLength = NSIntegerMax;
        [self addRegularCheckForSelf];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _regularLength = NSIntegerMax;
        [self addRegularCheckForSelf];
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - private
- (void)addRegularCheckForSelf {

    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}


/**
 中文判断处理
 
 @param textView UITextView
 @return 是否处于高亮状态
 */
- (BOOL)checkChineseCharacter:(UITextField *)textField {
    
    UITextRange *range = textField.markedTextRange;
    UITextPosition *posit = [textField positionFromPosition:range.start offset:0];
    if (range && posit) {
        NSInteger startOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:range.start];
        NSInteger endOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:range.end];
        NSRange range = NSMakeRange(startOffset, startOffset-endOffset);
        if (range.location < self.regularLength) {
            //..是否越界
        }
        return YES;
    }
    return NO;
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    
    BOOL result = [self checkChineseCharacter:self];
    if (result) {
        return;
    }
    if (self.text.length > self.regularLength) {
        self.text = [self.text substringToIndex:self.regularLength];
        if (self.resultBlock) {
            self.resultBlock(0);
        }
        return;
    }
    if (self.resultBlock) {
        self.resultBlock(self.regularLength - self.text.length);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (self.regularLength != NSIntegerMax) {
        BOOL result = [self checkChineseCharacter:textField];
        if (result) {
            return YES;
        }
    }
    if (self.regularRule) {
        NSString *inputStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
        return [inputStr regularCheck:self.regularRule];
    }
    return true;
}

@end
