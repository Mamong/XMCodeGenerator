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

+ (void)checkAPICommand:(XCSourceEditorCommandInvocation*)invocation;

+ (void)cellGeneratorCommand:(XCSourceEditorCommandInvocation*)invocation;

+ (void)viewControllerGeneratorCommand:(XCSourceEditorCommandInvocation*)invocation;


@end
