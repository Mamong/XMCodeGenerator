//
//  SourceEditorCommand.m
//  CodeGenerator
//
//  Created by marco on 3/12/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "CodeGenerator.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    NSString *identifier = invocation.commandIdentifier;
    
    if ([identifier hasSuffix:@"GenerateCell"]) {
        //生成Cell代码
        [CodeGenerator cellGeneratorCommand:invocation];
    }else if ([identifier hasSuffix:@"CheckAPI"]) {
        //添加注释
        [CodeGenerator checkAPICommand:invocation];
    }else if ([identifier hasSuffix:@"GenerateVC"]) {
        //生成VC代码
        [CodeGenerator viewControllerGeneratorCommand:invocation];
    }else if ([identifier hasSuffix:@"CommentSelection"]) {
        [CodeGenerator commentSelectionCommand:invocation];
    }


    completionHandler(nil);
}

@end
