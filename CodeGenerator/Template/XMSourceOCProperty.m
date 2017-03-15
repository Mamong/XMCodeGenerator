//
//  XMSourceOCProperty.m
//  CodeGenerator
//
//  Created by marco on 3/12/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import "XMSourceOCProperty.h"

@implementation XMSourceOCProperty


- (XMVariableInferType)inferType
{
    NSString *className = [self.className lowercaseString];
    if (className.length == 0) {
        return XMVariableInferTypeUnknown;
    }
    if (!self.isObject) {
        return XMVariableInferTypeValue;
    }else{
        if ([className hasSuffix:@"view"]||[className hasSuffix:@"textfield"]||
            [className hasSuffix:@"button"]||[className hasSuffix:@"switch"]
            ||[className hasSuffix:@"slider"]||[className hasSuffix:@"label"]||
            [className hasSuffix:@"bar"]||[className hasSuffix:@"picker"]) {
            return XMVariableInferTypeView;
        }else if ([className hasSuffix:@"model"]) {
            return XMVariableInferTypeModel;
        }else if ([className hasSuffix:@"request"]) {
            return XMVariableInferTypeRequest;
        }else{
            return XMVariableInferTypeObject;
        }
    }
}
@end
