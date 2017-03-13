//
//  CodeGenerator.m
//  CodeGenerator
//
//  Created by marco on 3/11/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import "CodeGenerator.h"
#import "XMCellTemplate.h"


@implementation CodeGenerator

+ (void)cellGeneratorCommand:(XCSourceEditorCommandInvocation*)invocation
{
    XCSourceTextBuffer *buffer = invocation.buffer;
    //NSString *complete = buffer.completeBuffer;
    XCSourceTextRange *current =  buffer.selections[0];
    NSInteger currentLine = current.start.line;
    //[buffer.lines insertObject:complete atIndex:currentLine];
    
    NSMutableArray *properties = [NSMutableArray array];
    for (int i = 0; i < buffer.lines.count; i++) {
        NSString *line = [buffer.lines objectAtIndex:i];
        line = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([line hasPrefix:@"@property"]) {
            XMSourceOCProperty *property = [XMSourceOCProperty new];
            NSRange range = [line rangeOfString:@")"];
            range.location += 1;
            range.length = line.length - range.location -1;
            NSString *propertyString = [line substringWithRange:range];
            propertyString = [propertyString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSArray *components;
            if ([propertyString rangeOfString:@"*"].location != NSNotFound) {
                property.isObject = YES;
                components = [propertyString componentsSeparatedByString:@"*"];
                
            }else{
                property.isObject = NO;
                components = [propertyString componentsSeparatedByString:@" "];
            }
            NSString  *propertyClass = [[components firstObject] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString  *propertyName = [[components lastObject] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            property.propertyName = propertyName;
            property.className = propertyClass;
            [properties addObject:property];
        }
        if ([line hasPrefix:@"@end"]) {
            break;
        }
    }
    if (properties.count == 0) {
        return;
    }
    XMCellTemplate *template = [XMCellTemplate templateWithProperties:properties];
    [template generateLines];
    NSArray *lines = template.lines;

    NSRange range = NSMakeRange(currentLine,[lines count]);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    [buffer.lines insertObjects:lines atIndexes:indexSet];

}

+ (void)checkAPICommand:(XCSourceEditorCommandInvocation*)invocation
{
    XCSourceTextBuffer *buffer = invocation.buffer;
    NSMutableArray *apis = [NSMutableArray array];
    NSMutableArray *apiURLs = [NSMutableArray array];
    NSMutableDictionary *count = [NSMutableDictionary dictionary];
    NSString *className = @"";
    NSString *result = @"";
    for (int i = 0; i < buffer.lines.count; i++) {
        NSString *line = [buffer.lines objectAtIndex:i];
        line = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([line hasPrefix:@"#define"]) {
            NSArray *components = [line componentsSeparatedByString:@" "];
            [apis addObject:components[1]];
            [apiURLs addObject:[components lastObject]];
        }else if ([line hasPrefix:@"@implementation"]) {
            NSArray *components = [line componentsSeparatedByString:@" "];
            className = components[1];
            if ([className hasSuffix:@"Request"]) {
                NSSet *urlSets = [NSSet setWithArray:apiURLs];
                if (urlSets.count != apiURLs.count) {
                    result = @"url duplicate;";
                }
            }else{
                break;
            }

        }else if ([line hasPrefix:@"[[TTNetworkManager"]) {
            for (NSString *api in apis) {
                if ([line rangeOfString:api].location != NSNotFound) {
                    NSInteger current = [[count objectForKey:api] integerValue];
                    [count setObject:@(++current) forKey:api];
                }
            }
        }
    }
    for (NSString *api in apis) {
        NSInteger current = [[count objectForKey:api] integerValue];
        if (current == 0) {
            result = [result stringByAppendingFormat:@" %@ not used.",api];
        }else if (current >= 2) {
            result = [result stringByAppendingFormat:@" %@ used too many times.",api];
        }
    }
    if (result.length != 0) {
        [buffer.lines insertObject:result atIndex:7];
    }
}

@end
