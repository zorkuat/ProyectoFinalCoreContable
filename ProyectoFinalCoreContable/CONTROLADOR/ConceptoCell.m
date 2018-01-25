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
        self.conceptoTextView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
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
