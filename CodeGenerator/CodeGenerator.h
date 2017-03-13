//
//  CodeGenerator.h
//  CodeGenerator
//
//  Created by marco on 3/11/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>


@interface CodeGenerator : NSObject

+ (void)cellGeneratorCommand:(XCSourceEditorCommandInvocation*)invocation;

+ (void)checkAPICommand:(XCSourceEditorCommandInvocation*)invocation;

@end
