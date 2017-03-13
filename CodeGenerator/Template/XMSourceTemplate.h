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

@property (nonatomic, readonly, strong)NSArray *propertyLines;

@property (nonatomic, readonly, strong)NSMutableArray<NSString*> *lines;

//构造器
+ (instancetype)templateWithProperties:(NSArray<XMSourceOCProperty*>*)properties;
- (instancetype)initWithProperties:(NSArray<XMSourceOCProperty*>*)properties;

//内部转换器
+ (NSArray*)linesTemplateFormProperty:(XMSourceOCProperty*)property;

//生成器,子类应该调用该方法
- (BOOL)generateLines;

@end
