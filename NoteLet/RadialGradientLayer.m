//
//  RadialGradientLayer.m
//  
//
//  Created by Connor Taylor on 2/21/15.
//
//

#import "RadialGradientLayer.h"

@implementation RadialGradientLayer

- (instancetype)init{
    self = [super init];
    if (self){
        
    }
    return self;
}

- (void)drawInContext:(CGContextRef)context
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray* colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor];
    
    CGFloat locations[] = {.01, .99};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locations);
    CGPoint center = (CGPoint){self.bounds.size.width / 2, self.bounds.size.height  / 2};
    CGContextDrawRadialGradient(context, gradient, center, 0, center, 30, kCGGradientDrawsBeforeStartLocation);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}

@end
