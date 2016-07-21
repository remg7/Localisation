//
//  UIView+Localisation.m
//
//  Copyright (c) 2014 Remigijus Skrebė.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "UIView+Localisation.h"

@implementation UIView (Localisation)

+ (NSString *)translateString:(NSString *)string
{
    return NSLocalizedString(string, nil);
}

+ (NSAttributedString *)translateAttributedString:(NSAttributedString *)attributed
{
    NSMutableAttributedString *translation = [NSMutableAttributedString new];
    [attributed enumerateAttributesInRange:NSMakeRange(0, attributed.string.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        [translation appendAttributedString:[[NSAttributedString alloc] initWithString:T([attributed.string substringWithRange:range]) attributes:attrs]];
    }];
    
    return translation;
}

- (void)localize
{
    if (![self translate]) {
        for (UIView *subview in self.subviews) {
            [subview localize];
        }
    }
}

- (BOOL)translate
{
    return NO;
}

@end


@interface UILabel (Localisation)

- (BOOL)translate;

@end

@implementation UILabel (Localisation)

- (BOOL)translate
{
    self.attributedText = TA(self.attributedText);
    return YES;
}

@end


@interface UITextField (Localisation)

- (BOOL)translate;

@end

@implementation UITextField (Localisation)

- (BOOL)translate
{
    self.attributedText        = TA(self.attributedText);
    self.attributedPlaceholder = TA(self.attributedPlaceholder);
    
    return YES;
}

@end


@interface UIButton (Localisation)

- (BOOL)translate;

@end

@implementation UIButton (Localisation)

- (BOOL)translate
{
    NSString *normal = [self titleForState:UIControlStateNormal];
    for (UIControlState state = 1; state <= (UIControlStateHighlighted | UIControlStateDisabled | UIControlStateSelected); state++) {
        if (![[self titleForState:state] isEqualToString:normal]) {
            [self setTitle:T([self titleForState:state]) forState:state];
        }
    }
    
    [self setTitle:T(normal) forState:UIControlStateNormal];
    
    return YES;
}

@end


@interface UISegmentedControl (Localisation)

- (BOOL)translate;

@end

@implementation UISegmentedControl (Localisation)

- (BOOL)translate
{
    for (NSInteger index = 0; index < self.numberOfSegments; index++) {
        [self setTitle:T([self titleForSegmentAtIndex:index]) forSegmentAtIndex:index];
    }
    
    return YES;
}

@end
