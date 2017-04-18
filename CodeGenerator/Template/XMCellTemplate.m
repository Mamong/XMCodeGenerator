//
//  XMCellTemplate.m
//  CodeGenerator
//
//  Created by marco on 3/12/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import "XMCellTemplate.h"
#import "NSString+MC.h"

@implementation XMCellTemplate

//生成器
- (BOOL)generateLines
{
    BOOL success = [super generateLines];
    self.drawCellLines = [XMCellTemplate drawCellTemplatelines:self.properties];
    self.reloadLines = [XMCellTemplate reloadTemplatelines];
    self.heightLines = [XMCellTemplate heightTemplatelines];
    NSRange range = NSMakeRange(0,[self.heightLines count]);
    [self.lines insertObjects:self.heightLines atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    
    range.length = self.reloadLines.count;
    [self.lines insertObjects:self.reloadLines atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];

    range.length = self.drawCellLines.count;
    [self.lines insertObjects:self.drawCellLines atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    
    //[self.lines addObjectsFromArray:self.actionLines];
    return success;
}

+ (NSArray*)drawCellTemplatelines:(NSArray<XMSourceOCProperty*>*)properties
{
    NSMutableArray *lines = [NSMutableArray array];
    [lines addObject:@"- (void)drawCell"];
    [lines addObject:@"{"];
    [lines addObject:@"\tself.backgroundColor = Color_White;"];
    for (int i = 0; i < properties.count; i++) {
        XMSourceOCProperty *property = properties[i];
        if (property.inferType == XMVariableInferTypeView) {
            [lines addObject:[NSString stringWithFormat:@"\t[self cellAddSubView:self.%@];",property.propertyName]];
        }
    }
    [lines addObject:@"}"];
    [lines addObject:@"\n"];
    return lines;
}

+ (NSArray*)reloadTemplatelines
{
    return @[@"- (void)reloadData",
             @"{",
             @"\tif (self.cellData) {",
             @"\t}",
             @"}",
             @"\n",
             ];
}

+ (NSArray*)heightTemplatelines
{
    return @[@"+ (CGFloat)heightForCell:(id)cellData",
             @"{",
             @"\tCGFloat height = 0;",
             @"\tif (cellData) {",
             @"\t\theight = 46;",
             @"\t}",
             @"\treturn height;",
             @"}",
             @"\n",
             ];
}


@end
