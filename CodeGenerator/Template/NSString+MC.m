//
//  NSString+MC.m
//  CodeGenerator
//
//  Created by marco on 3/12/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import "NSString+MC.h"

@implementation NSString(MC)

- (NSString*)stringByUpperFirstCharacter
{
    if (self.length == 0) {
        return self;
    }
    NSString *firstUpperCharacter = [[self substringToIndex:1] uppercaseString];
    if (self.length == 1) {
        return firstUpperCharacter;
    }
    NSString *otherString = [self substringFromIndex:1];
    NSString *resultString = [NSString stringWithFormat:@"%@%@",firstUpperCharacter,otherString];
    return resultString;
}

@end
