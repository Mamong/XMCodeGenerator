//
//  XMSourceOCProperty.h
//  CodeGenerator
//
//  Created by marco on 3/12/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XMVariableInferType) {
    XMVariableInferTypeValue     =   0x00000,
    XMVariableInferTypeObject    =   0x10000,
    XMVariableInferTypeView      =   0x10001,
    XMVariableInferTypeModel     =   0x10010,
    XMVariableInferTypeRequest   =   0x10011,
    XMVariableInferTypeUnknown   =   0x100000,
};

@interface XMSourceOCProperty : NSObject

@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) NSString *className;
@property (nonatomic, assign) BOOL isObject;
@property (nonatomic, readonly) XMVariableInferType inferType;

@end
