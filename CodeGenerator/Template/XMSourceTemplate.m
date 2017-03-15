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
@property (nonatomic, strong)NSArray *focusPropertyLines;
@property (nonatomic, strong)NSArray *actionLines;

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
    self.focusPropertyLines = [XMSourceTemplate focusPropertiesTemplatelines:self.properties];
    self.actionLines = [XMSourceTemplate actionsTemplatelines:self.properties];
    [self.lines addObjectsFromArray:self.focusPropertyLines];
    [self.lines addObjectsFromArray:self.actionLines];
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

        }else if ([property.className isEqualToString:@"UISearchBar"]) {
            
            return [XMSourceTemplate searchBarTemplatelines:property];
            
        }else if ([property.className isEqualToString:@"UIDatePicker"]) {
            
            return [XMSourceTemplate datePickerTemplatelines:property];
            
        }else if ([property.className isEqualToString:@"UISegmentedControl"]) {
            
            return [XMSourceTemplate segmentedControlTemplatelines:property];

        }else if ([property.className isEqualToString:@"UIPickerView"]) {
            
            return [XMSourceTemplate pickerViewTemplatelines:property];
            
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
             @"\t\timageView.centerY = 22;",
             @"\t\t//imageView.layer.cornerRadius = 22;",
             @"\t\t//imageView.layer.masksToBounds = YES;",
             @"\t\t//imageView.image = [UIImage imageNamed:@\"<#imageName#>\"];",
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

+ (NSArray*)searchBarTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 44)];",
             @"\t\tsearchBar.placeholder = @\"<#通过手机号、昵称搜索#>\"",
             @"\t\tsearchBar.searchBarStyle = UISearchBarStyleMinimal;",
             @"\t\tsearchBar.delegate = self;",
             [NSString stringWithFormat:@"\t\t_%@ = searchBar;",property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

+ (NSArray*)datePickerTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUIDatePicker *pickerView = [[UIDatePicker alloc] initWithFrame:(0, 0, SCREEN_WIDTH, 234)];",
             @"\t\tNSDate* maxDate = [NSDate date];",
             @"\t\tNSDateComponents *dc =[[NSDateComponents alloc] init];",
             @"\t\tdc.year = 2016;",
             @"\t\tdc.month = 11;",
             @"\t\tdc.day = 1;",
             @"\t\tdc.hour = 0;",
             @"\t\tdc.minute = 0;",
             @"\t\tNSCalendar *gregorian =[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];",
             @"\t\tNSDate *minDate =[gregorian dateFromComponents:dc];",
             @"",
             @"\t\tpickerView.minimumDate = minDate;",
             @"\t\tpickerView.maximumDate = maxDate;",
             @"\t\tpickerView.date = maxDate;",
             @"\t\tpickerView.datePickerMode = UIDatePickerModeDate;",
             @"\t\tpickerView.backgroundColor = Color_White;",
             @"\t\t[pickerView addTarget:self action:@selector(datePickerChange:)forControlEvents:UIControlEventValueChanged];",
             [NSString stringWithFormat:@"\t\t_%@ = pickerView;",property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

+ (NSArray*)pickerViewTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 234)];",
             @"\t\tpickerView.delegate = self;",
             @"\t\tpickerView.dataSource = self;",
             @"\t\tpickView.showsSelectionIndicator = YES;",
             @"\t\tpickView.backgroundColor = Color_White;",
             [NSString stringWithFormat:@"\t\t_%@ = pickerView;",property.propertyName],
             @"\t}",
             [NSString stringWithFormat:@"\treturn _%@;",property.propertyName],
             @"}",
             @"\n"
             ];
}

+ (NSArray*)segmentedControlTemplatelines:(XMSourceOCProperty*)property
{
    return @[[NSString stringWithFormat:@"- (%@ *)%@",property.className,property.propertyName],
             @"{",
             [NSString stringWithFormat:@"\tif (!_%@) {",property.propertyName],
             @"\t\tUISegmentedControl *segmentedControl = segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@\"订单\",@\"营收\"]]",
             @"\t\tsegmentedControl.tintColor = Color_Gray204;",
             @"\t\tsegmentedControl.height = 30;",
             @"\t\tsegmentedControl.width = 200;",
             @"\t\tsegmentedControl.centerX = SCREEN_WIDTH/2;",
             @"\t\tsegmentedControl.top = 6+20;",
             @"\t\tsegmentedControl.selectedSegmentIndex = 0;",
             @"\t\t//segmentedControl.layer.borderColor = Color_Black.CGColor;",
             @"\t\t//segmentedControl.layer.borderWidth = 1.;",
             @"\t\t//segmentedControl.layer.cornerRadius = 4.f;",
             @"\t\t//segmentedControl.layer.masksToBounds = YES;",
             @"\t\t[segmentedControl setTitleTextAttributes:@{NSFontAttributeName: FONT(13),NSForegroundColorAttributeName:Color_White} forState:UIControlStateNormal];",
             @"\t\t[segmentedControl setTitleTextAttributes:@{NSFontAttributeName: FONT(13),NSForegroundColorAttributeName:Color_White} forState:UIControlStateSelected];",
             @"\t\t[segmentedControl addTarget:self action:@selector(handleSegmentChange:) forControlEvents:UIControlEventValueChanged];",
             [NSString stringWithFormat:@"\t\t_%@ = segmentedControl;",property.propertyName],
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



#pragma mark - main
+ (NSArray*)focusPropertiesTemplatelines:(NSArray<XMSourceOCProperty*>*)properties
{
    NSMutableArray *lines = [NSMutableArray array];
    [lines addObject:@"#pragma mark - Subviews"];
    for (int i =0; i<properties.count; i++) {
        XMSourceOCProperty *property = [properties objectAtIndex:i];
        [lines addObjectsFromArray:[XMSourceTemplate linesTemplateFormProperty:property]];
    }
    return lines;
}

+ (NSArray*)actionsTemplatelines:(NSArray<XMSourceOCProperty*>*)properties
{
    NSMutableArray *lines = [NSMutableArray array];
    //NSMutableArray *buttons = [NSMutableArray array];
    NSMutableArray *textFields = [NSMutableArray array];
    NSMutableArray *segment = [NSMutableArray array];
    NSMutableArray *picker = [NSMutableArray array];

    [lines addObject:@"#pragma mark - Actions"];
    for (XMSourceOCProperty *property in properties) {
        if ([property.className isEqualToString:@"UIButton"]) {
            //[buttons addObject:property];
            [lines addObjectsFromArray:@[[NSString stringWithFormat:@"- (void)handle%@:(UIButton*)button",[property.propertyName stringByUpperFirstCharacter]],
                                         @"{",
                                         @"}",
                                         @"\n"
                                         ]];
        }else if ([property.className isEqualToString:@"UITextField"]) {
            
            [textFields addObject:property];
            
        }else if ([property.className isEqualToString:@"UISegmentedControl"]) {
            
            [segment addObject:property];

        }else if ([property.className isEqualToString:@"UIDatePicker"]) {
            
            [picker addObject:property];
            
        }
    }
    if (textFields.count > 0) {
        XMSourceOCProperty *property = textFields[0];
        [lines addObjectsFromArray:@[@"- (void)textFieldChanged:(UITextField*)textField",
                                     @"{",
                                     [NSString stringWithFormat:@"\tif (textField == self.%@) {",property.propertyName],
                                     @"",
                                     @"\t}",
                                     @"}",
                                     @"\n"
                                     ]];
    }
    
    if (segment.count > 0) {
        [lines addObjectsFromArray:@[@"- (void)handleSegmentChange:(UISegmentedControl*)segment",
                                     @"{",
                                     @"}",
                                     @"\n"
                                     ]];
    }
    
    if (picker.count > 0) {
        [lines addObjectsFromArray:@[@"- (void)datePickerChange:(UIDatePicker*)datePicker",
                                     @"{",
                                     @"}",
                                     @"\n"
                                     ]];
    }
    return lines;
}
@end
