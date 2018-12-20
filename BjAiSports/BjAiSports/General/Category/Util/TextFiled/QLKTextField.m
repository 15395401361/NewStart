//
//  QLKTextField.m
//  CloudsOutpatient
//
//  Created by 柴志勇 on 16/3/29.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "QLKTextField.h"
static NSString *normal_space_string = @" ";
static NSString *non_breaking_space_string = @"\u00a0";//占位

@interface QLKTextField ()
@property (strong,nonatomic)NSString* tempText;
@end

@implementation QLKTextField

- (id)initWithFrame:(CGRect)frame{
  
    self = [super initWithFrame:frame];
    if (self) {
        [self setupItem];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
  
  self = [super initWithCoder:aDecoder];
  if (self) {
     [self setupItem];
  }
  return self;
}

- (void)dealloc{
  
}

- (void)setupItem{
  
    self.textMaxLength = 300;
    //开始编辑
    [self addTarget:self action:@selector(replaceNormalSpacesWithNonBreakingSpaces)
    forControlEvents:UIControlEventEditingDidBegin];
    //编辑中
    [self addTarget:self action:@selector(replaceNormalSpacesWithTextChangeSpaces:)
    forControlEvents:UIControlEventEditingChanged];
    //编辑结束
    [self addTarget:self action:@selector(replaceNonBreakingSpacesWithNormalSpaces)
    forControlEvents:UIControlEventEditingDidEnd];
}

- (void)replaceNormalSpacesWithNonBreakingSpaces
{
    if(self.textAlignment == NSTextAlignmentRight){
      self.text = [self.text stringByReplacingOccurrencesOfString:normal_space_string
                                                       withString:non_breaking_space_string];
    }
    if (self.eventEditingDidBegin) {
      self.eventEditingDidBegin(self);
    }
}

- (void)replaceNormalSpacesWithTextChangeSpaces:(UITextField*)tempTextField
{
    NSString *toBeString = tempTextField.text;
    UITextRange *selectedRange = [tempTextField markedTextRange];
    UITextPosition *position = [tempTextField positionFromPosition:selectedRange.start offset:0];
    UITextRange *range = self.selectedTextRange;
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position || !selectedRange){
        if(_tempText.length == self.text.length  && (![_tempText isEqualToString:self.text])){
          
          self.text = _tempText;
          [self setSelectedTextRange:range];
        }
      if (toBeString.length > self.textMaxLength){
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.textMaxLength];
        if (rangeIndex.length == 1){
          tempTextField.text = [toBeString substringToIndex:self.textMaxLength];
          [self setSelectedTextRange:range];
        }else{
          NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.textMaxLength)];
          tempTextField.text = [toBeString substringWithRange:rangeRange];
          [self setSelectedTextRange:range];
        }
      }else{
//          BOOL flag = [NSString stringContainsEmoji:tempTextField.text];
//          tempTextField.text = [NSString disable_emoji:tempTextField.text];
//          if (flag) {
//              [ToastView showMessageCaption:@"暂不支持输入表情"];
//              return;
//          }
          _tempText = [NSString stringWithString:self.text];
      }
      
    }
    if (self.eventEditingDidChanged) {
      self.eventEditingDidChanged(self);
    }
}

- (void)replaceNonBreakingSpacesWithNormalSpaces
{
    if(self.textAlignment == NSTextAlignmentRight){
      self.text = [self.text stringByReplacingOccurrencesOfString:non_breaking_space_string
                                                       withString:normal_space_string];
    }
    if (self.eventEditingDidDidEnd) {
        self.eventEditingDidDidEnd(self);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
  if (toBeString.length > self.textMaxLength && range.length!=1){
    return NO;
  }
   return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
   if (action == @selector(paste:))//禁止粘贴
     return YES;
   if (action == @selector(select:))// 禁止选择
     return YES;
   if (action == @selector(selectAll:))// 禁止全选
     return YES;
   return [super canPerformAction:action withSender:sender];
}
@end
