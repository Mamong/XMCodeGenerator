//
//  XMCellTemplate.h
//  CodeGenerator
//
//  Created by marco on 3/12/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import "XMSourceTemplate.h"

@interface XMCellTemplate : XMSourceTemplate

@property (nonatomic, strong) NSArray *drawCellLines;
@property (nonatomic, strong) NSArray *reloadLines;
@property (nonatomic, strong) NSArray *heightLines;


//生成器
- (BOOL)generateLines;

@end
