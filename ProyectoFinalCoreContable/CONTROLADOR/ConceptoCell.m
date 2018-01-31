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
        self.conceptoTextView = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, 400, 45)];
        self.conceptoTextView.layoutMargins = UIEdgeInsetsMake(40, 0, 0, 10);
        CGFloat tamFont = 14.0 ;
        UIFont *fontStyle = [self.conceptoTextView.font fontWithSize:tamFont];
        self.conceptoTextView.font = fontStyle;

        
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
