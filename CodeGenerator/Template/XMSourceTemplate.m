//
//  XMSourceTemplate.m
//  CodeGenerator
//
//  Created by marco on 3/12/17.
//  Copyright © 2017 xiaoma. All rights reserved.
//

#import "XMSourceTemplate.h"
#import "NSString+MC.h"

@interface XMSourceTemplate ()

@property (nonatomic, strong)NSArray<XMSourceOCProperty*> *properties;
@property (nonatomic, strong)NSArray *propertyLines;

@end


@implementation XMSourceTemplate

+ (instancetype)templateWithProperties:(NSArray<XMSourceOCProperty*>*)properties
{
    return [[self alloc]initWithProperties:properties];
}

- (instancetype)initWithProperties:(NSArray<XMSourceOCProperty*>*)properties
{
    if (self = [super init]) {
        _properties = properties;
        _lines = [NSMutableArray array];
    }
    return self;
}

- (BOOL)generateLines
{
    if (self.properties.count == 0) {
        return YES;
    }
    [self.lines removeAllObjects];
    for (int i =0; i<self.properties.count; i++) {
        XMSourceOCProperty *property = [self.properties objectAtIndex:i];
        [self.lines addObjectsFromArray:[XMSourceTemplate linesTemplateFormProperty:property]];
    }
    self.propertyLines = [self.lines copy];
    return YES;
}


+ (NSArray*)linesTemplateFormProperty:(XMSourceOCProperty*)property
{
    NSMutableArray *lines = [NSMutableArray array];
    if (property.isObject) {
        if ([property.className isEqualToString:@"UILabel"]) {
            
            return [XMSourceTemplate labelTemplatelines:property];
            
        }else if ([property.className isEqualToString:@"UIButton"]) {
            
            return [XMSourceTemplate buttonTemplatelines:property];
            
        }else if ([property.className isEqualToString:@"UIView"]) {
            
            return [XMSourceTemplate viewTemplatelines:property];
            
        }else if ([property.className isEqualToString:@"UIImageView"]) {
            
            return [XMSourceTemplate imageViewTemplatelines:property];
            
        }else if ([property.className isEqualToString:@"UITextField"]) {
            
            return [XMSourceTemplate textFieldTemplatelines:property];
            
        }else if ([property.className isEqualToString:@"UITextView"]) {
            
            return [XMSourceTemplate textViewTemplatelines:property];

        }
        else{
            if (property.inferType ==  XMVariableInferTypeView) {
                return [XMSourceTemplate commonViewTemplatelines:property];
            }else{
                //return [XMSourceTemplate commonTemplatelines:property];
            }
        }
    }
    return lines;
}

+ (NSArray*)labelTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];",
             @"\t\tlabel.font = FONT(12);",
             @"\t\tlabel.textColor = Color_Gray153;",
             @"\t\tlabel.text = @\"<#label#>\";",
             @"\t\t[label sizeToFit];",
             [NSString stringWithFormat:@"\t\t_%@ = label;",property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
    
    
    
    //[NSString stringWithFormat:@"- (UILabel *)%@\n{\tif (!_%@) {\n\t\tUILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];\n\t\tlabel.font = FONT(12);\n\t\tlabel.textColor = Color_Gray153;\n\t\tlabel.text = @\"联系商家\";\n\t\t[label sizeToFit];\n\t\t_%@ = label;\n\t}\n\treturn _%@;\n}",name,name,name,name];
}

+ (NSArray*)buttonTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];",
             @"\t\tbutton.layer.cornerRadius = 16;",
             @"\t\tbutton.layer.masksToBounds = YES;",
             @"\t\tbutton.backgroundColor = Color_White;",
             @"\t\t[button setTitleColor:Color_Black forState:UIControlStateNormal];",
             @"\t\tbutton.titleLabel.font = FONT(15);",
             @"\t\t[button setTitle:@\"<#button#>\" forState:UIControlStateNormal];",
             [NSString stringWithFormat:@"\t\t[button addTarget:self action:@selector(handle%@:) forControlEvents:UIControlEventTouchUpInside];",[property.propertyName stringByUpperFirstCharacter]],
             [NSString stringWithFormat:@"\t\t_%@ = button;",property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

/*
 - (UIButton *)payButton{
 if (!_payButton) {
 UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 61, 32)];
 button.layer.cornerRadius = 16;
 button.layer.masksToBounds = YES;
 button.backgroundColor = RGB(255, 151, 41);
 [button setTitleColor:Color_White forState:UIControlStateNormal];
 button.titleLabel.font = FONT(15);
 [button setTitle:@"买单" forState:UIControlStateNormal];
 [button addTarget:self action:@selector(handlePayButton) forControlEvents:UIControlEventTouchUpInside];
 _payButton = button;
 }
 return _payButton;
 }*/

+ (NSArray*)viewTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, LINE_WIDTH)];",
             @"\t\tview.backgroundColor = Color_Gray224;",
             [NSString stringWithFormat:@"\t\t_%@ = view;",property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

/*
 - (UIView*)line
 {
 if (!_line) {
 UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, LINE_WIDTH)];
 view.backgroundColor = Color_Gray224;
 _line = view;
 }
 return _line;
 }
 */

+ (NSArray*)imageViewTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];",
             @"\t\timageView.layer.cornerRadius = 22;",
             @"\t\timageView.layer.masksToBounds = YES;",
             @"\t\timageView.image = [UIImage imageNamed:@\"<#imageName#>\"];",
             [NSString stringWithFormat:@"\t\t_%@ = imageView;",property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

/*
 - (UIImageView *)iconView{
 if (!_iconView) {
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 143)];
 _iconView = imageView;
 }
 return _iconView;
 }
 */

+ (NSArray*)textFieldTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];",
             @"\t\ttextField.font = FONT(14);",
             @"\t\ttextField.placeholder = @\"<#PlaceHolder#>\";",
             @"\t\ttextField.keyboardType = UIKeyboardTypeDecimalPad;",
             @"\t\ttextField.delegate = self;",
             @"\t\t[textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];",
             [NSString stringWithFormat:@"\t\t_%@ = textField;",property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

/*
 - (UITextField *)payTextField{
 if (!_payTextField) {
 UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 250, 40)];
 //label.textColor = Color_Gray204;
 textField.font = FONT(14);
 textField.placeholder = @"到店服务后可买单支付";
 textField.keyboardType = UIKeyboardTypeDecimalPad;
 textField.delegate = self;
 [textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
 _payTextField = textField;
 }
 return _payTextField;
 }
 */

+ (NSArray*)textViewTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];",
             @"\t\ttextView.font = FONT(14);",
             @"\t\ttextView.delegate = self;",
             [NSString stringWithFormat:@"\t\t_%@ = textView;",property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

+ (NSArray*)commonViewTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             [NSString stringWithFormat:@"\t\t%@ *%@ = [[%@ alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];",property.className,property.propertyName,property.className],
             [NSString stringWithFormat:@"\t\t_%@ = %@;",property.propertyName,property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

+ (NSArray*)commonTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             [NSString stringWithFormat:@"\t\t%@ *%@ = [[%@ alloc] init];",property.className,property.propertyName,property.className],
             [NSString stringWithFormat:@"\t\t_%@ = %@;",property.propertyName,property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

@end
