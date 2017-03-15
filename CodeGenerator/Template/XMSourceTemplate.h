//
//  XMSourceTemplate.h
//  CodeGenerator
//
//  Created by marco on 3/12/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMSourceOCProperty.h"


@interface XMSourceTemplate : NSObject

@property (nonatomic, readonly, strong)NSArray<XMSourceOCProperty*> *properties;

// only view or view like properties will be generated into lines
@property (nonatomic, readonly, strong)NSArray *focusPropertyLines;

//
@property (nonatomic, readonly, strong)NSArray *actionLines;

@property (nonatomic, readonly, strong)NSMutableArray<NSString*> *lines;

//构造器
+ (instancetype)templateWithProperties:(NSArray<XMSourceOCProperty*>*)properties;
- (instancetype)initWithProperties:(NSArray<XMSourceOCProperty*>*)properties;

//内部转换器
+ (NSArray*)linesTemplateFormProperty:(XMSourceOCProperty*)property;

//生成器,子类应该调用该方法
- (BOOL)generateLines;

@end
