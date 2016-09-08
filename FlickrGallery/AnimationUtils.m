//
//  AnimationUtils.m
//  FlickrGallery
//
//  Created by Stephen on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "AnimationUtils.h"

@implementation AnimationUtils

+ (CAKeyframeAnimation*)wiggleAnimation {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CGFloat wobbleAngle = 0.04f;
    
    NSValue* valLeft = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(wobbleAngle, 0.0f, 0.0f, 1.0f)];
    NSValue* valRight = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-wobbleAngle, 0.0f, 0.0f, 1.0f)];
    animation.values = [NSArray arrayWithObjects:valLeft, valRight, nil];
    
    animation.autoreverses = YES;
    animation.duration = 0.125;
    animation.repeatCount = 1;
    
    return animation;
}

@end
