//
//  QLKTextView.m
//  CloudsOutpatient
//
//  Created by 柴志勇 on 16/3/29.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "QLKTextView.h"
#import "NSString+Ext.h"
@interface QLKTextView()
@property(strong,nonatomic) NSString* tempText;
@end

@implementation QLKTextView

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
     [self addObserver];
}

- (void)addObserver {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replaceNormalSpacesWithNonBreakingSpaces) name:UITextViewTextDidBeginEditingNotification object:self];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replaceNormalSpacesWithTextChangeSpaces:) name:UITextViewTextDidChangeNotification object:self];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replaceNonBreakingSpacesWithNormalSpaces) name:UITextViewTextDidEndEditingNotification object:self];
}

- (void)replaceNormalSpacesWithNonBreakingSpaces
{
    // _tempText = self.text;
    if (self.eventEditingDidBegin) {
        self.eventEditingDidBegin(self);
    }
}

- (void)replaceNonBreakingSpacesWithNormalSpaces
{
   QLKDLog(@"replaceNonBreakingSpacesWithNormalSpaces %@",self.text);
   if (self.eventEditingDidDidEnd) {
      self.eventEditingDidDidEnd(self);
   }
}

- (NSString*)replaceSpecialCharactersInText:(NSString*)text
{
   NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
   NSString *trimmedString = [text stringByTrimmingCharactersInSet:set];
   return trimmedString;
}

- (void)replaceNormalSpacesWithTextChangeSpaces:(NSNotification *)notification
{
  
  NSString *toBeString = self.text;
  QLKDLog(@"toBeString %@",self.text);
  UITextRange *selectedRange = [self markedTextRange];
  NSRange range =  self.selectedRange;
  UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
  // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
  if (!position || !selectedRange){
    
    if(_tempText.length == toBeString.length  && (![_tempText isEqualToString:toBeString])){
        self.text = _tempText;
        self.selectedRange = range;
    }
    if (toBeString.length > self.textMaxLength){
     
      NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.textMaxLength];
      if (rangeIndex.length == 1){
        self.text = [NSString emojizedStringWithString:[toBeString substringToIndex:self.textMaxLength]];
        self.selectedRange = range;
      }else{
        NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.textMaxLength)];
        self.text = [NSString emojizedStringWithString:[toBeString substringWithRange:rangeRange]];
        self.selectedRange = range;
      }
      _tempText = [NSString stringWithString:self.text];
    }else{
        NSString* tempStr =  self.text;
        self.text =  [NSString emojizedStringWithString:tempStr];
        self.selectedRange = range;
    }
  }
  if (self.eventEditingDidChanged) {
      self.eventEditingDidChanged(self);
  }
}

@end
