//
//  XMSourceOCProperty.h
//  CodeGenerator
//
//  Created by marco on 3/12/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMSourceOCProperty : NSObject

@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) NSString *className;
@property (nonatomic, assign) BOOL isObject;

@end
