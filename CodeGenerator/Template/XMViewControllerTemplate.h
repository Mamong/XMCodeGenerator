//
//  XMViewControllerTemplate.h
//  CodeGeneratorDemo
//
//  Created by marco on 3/13/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import "XMSourceTemplate.h"

@interface XMViewControllerTemplate : XMSourceTemplate

@property (nonatomic, strong) NSArray *renderLines;

//生成器
- (BOOL)generateLines;


@end
