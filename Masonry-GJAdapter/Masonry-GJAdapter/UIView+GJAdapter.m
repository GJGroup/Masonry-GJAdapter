
//
//  UIView+GJAdapter.m
//  MasonryAdapter
//
//  Created by wangyutao on 16/1/17.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "UIView+GJAdapter.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@implementation UIView (GJAdapter)

+ (void)load {
    Method oldMethod = class_getInstanceMethod(self, @selector(addConstraint:));
    Method newMethod = class_getInstanceMethod(self, @selector(gjAdapter_addConstraint:));
    method_exchangeImplementations(oldMethod, newMethod);
}

- (void)gjAdapter_addConstraint:(NSLayoutConstraint *)constraint {

    BOOL dontAdapter = NO;
    
    Class _UILayoutGuideClass = NSClassFromString(@"_UILayoutGuide");
    
    //filter _UILayoutGuide
    if ([constraint.firstItem isKindOfClass:_UILayoutGuideClass]) {
        dontAdapter = YES;
    }
    
    if ([self gjAdapter_checkKeyboardView:constraint.firstItem] ||
        [self gjAdapter_checkKeyboardView:constraint.secondItem]) {
        dontAdapter = YES;
    }
    
    if (dontAdapter) {
        [self gjAdapter_addConstraint:constraint];
        return;
    }
    
    if ([constraint isMemberOfClass:[NSLayoutConstraint class]]) {
        NSLayoutConstraint *newConstraint
        = [MASLayoutConstraint constraintWithItem:constraint.firstItem
                                        attribute:constraint.firstAttribute
                                        relatedBy:constraint.relation
                                           toItem:constraint.secondItem
                                        attribute:constraint.secondAttribute
                                       multiplier:constraint.multiplier
                                         constant:constraint.constant];

        MASViewAttribute *firstAttribute = [[MASViewAttribute alloc] initWithView:newConstraint.firstItem
                                                                  layoutAttribute:newConstraint.firstAttribute];
        MASViewConstraint *masConstraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:firstAttribute];
        if (newConstraint.secondItem && newConstraint.secondAttribute) {
            MASViewAttribute *secondAttribute = [[MASViewAttribute alloc] initWithView:newConstraint.secondItem
                                                                       layoutAttribute:newConstraint.secondAttribute];
            [masConstraint setValue:secondAttribute forKey:@"_secondViewAttribute"];
        }
        
        
        [masConstraint setValue:self forKey:@"installedView"];
        [masConstraint setValue:newConstraint forKey:@"layoutConstraint"];
        MAS_VIEW *firstItemView = newConstraint.firstItem;
        NSMutableSet *installedConstraints = [firstItemView valueForKey:@"mas_installedConstraints"];
        [installedConstraints addObject:masConstraint];

        [self gjAdapter_addConstraint:newConstraint];
        return;
    }
    

    [self gjAdapter_addConstraint:constraint];
    
}

- (BOOL)gjAdapter_checkKeyboardView:(id)item {
    if ([item isKindOfClass:NSClassFromString(@"UIInputSetHostView")] ||
        [item isKindOfClass:NSClassFromString(@"UIInputSetContainerView")] ||
        [item isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
        return YES;
    }
    return NO;
}


@end

