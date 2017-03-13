//
//  XMViewControllerTemplate.m
//  CodeGeneratorDemo
//
//  Created by marco on 3/13/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import "XMViewControllerTemplate.h"

@implementation XMViewControllerTemplate

//生成器
- (BOOL)generateLines
{
    BOOL success = [super generateLines];
    self.renderLines = [XMViewControllerTemplate renderTemplatelines:self.properties];
    
    NSRange range = NSMakeRange(0,[self.renderLines count]);
    [self.lines insertObjects:self.renderLines atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    
    return success;
}

+ (NSArray*)renderTemplatelines:(NSArray<XMSourceOCProperty*>*)properties
{
    NSMutableArray *lines = [NSMutableArray array];
    [lines addObject:@"- (void)render"];
    [lines addObject:@"{"];
    for (int i = 0; i < properties.count; i++) {
        XMSourceOCProperty *property = properties[i];
        if (property.inferType == XMVariableInferTypeView) {
            [lines addObject:[NSString stringWithFormat:@"\t[self.view addSubView:self.%@];",property.propertyName]];
        }
    }
    [lines addObject:@"}"];
    [lines addObject:@"\n"];
    return lines;
}
@end
