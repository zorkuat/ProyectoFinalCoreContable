//
//  ConceptoCell.m
//  ProyectoFinalCoreContable
//
//  Created by cice on 17/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "ConceptoCell.h"


@interface ConceptoCell()

@end

@implementation ConceptoCell


- (UITableViewCell*)init
{
    self=[super init];
    if(self)
    {
        self.conceptoTextView = [[UITextField alloc] init];
        CGFloat tamFont = 14.0 ;
        UIFont *fontStyle = [self.conceptoTextView.font fontWithSize:tamFont];
        self.conceptoTextView.font = fontStyle;
        
        /*UIButton* overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [overlayButton setImage:[UIImage imageNamed:@"bookmark"] forState:UIControlStateNormal];
        [overlayButton addTarget:self action:@selector(displayBookmarks:)
                forControlEvents:UIControlEventTouchUpInside];
        overlayButton = CGRectMake(0, 0, 28, 28);
        
        // Assign the overlay button to a stored text field
        self.textField.leftView = overlayButton;
        self.textField.leftViewMode = UITextFieldViewModeAlways;*/
        
        [self addSubview:self.conceptoTextView];
    }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
