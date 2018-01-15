//
//  DetalleFacturaController.m
//  ProyectoFinalCoreContable
//
//  Created by cice on 15/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "DetalleFacturaController.h"

@interface DetalleFacturaController ()
@property (weak, nonatomic) IBOutlet UILabel *facturaNumeroView;
@property (weak, nonatomic) IBOutlet UILabel *fechaExpedicionView;
@property (weak, nonatomic) IBOutlet UILabel *fechaOperacionLabel;
@property (weak, nonatomic) IBOutlet UILabel *cIFView;
@property (weak, nonatomic) IBOutlet UILabel *razonSocialView;
@property (weak, nonatomic) IBOutlet UILabel *conceptoView;
@property (weak, nonatomic) IBOutlet UILabel *baseView;
@property (weak, nonatomic) IBOutlet UILabel *IVAView;
@property (weak, nonatomic) IBOutlet UILabel *totalView;
@property (weak, nonatomic) IBOutlet UILabel *rectificacionView;

@end

@implementation DetalleFacturaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
