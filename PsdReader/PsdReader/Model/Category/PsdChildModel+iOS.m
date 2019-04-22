//
//  PsdChildModel+iOS.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/16.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdChildModel+iOS.h"

@implementation PsdChildModel (iOS)

- (CGFloat)iOS_top
{
    return self.top * 0.5;
}

-(CGFloat)iOS_left
{
    return self.left * 0.5;
}

-(CGFloat)iOS_right
{
    return self.right * 0.5;
}

-(CGFloat)iOS_bottom
{
    return self.bottom * 0.5;
}

-(CGFloat)iOS_width
{
    return self.width * 0.5;
}

-(CGFloat)iOS_height
{
    return self.height * 0.5;
}

@end
