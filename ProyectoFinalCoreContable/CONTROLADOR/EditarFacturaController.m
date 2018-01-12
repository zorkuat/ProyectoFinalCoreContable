//
//  EditarFacturaController.m
//  ProyectoFinalCoreContable
//
//  Created by cice on 12/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "EditarFacturaController.h"
#import "Factura.h"

@interface EditarFacturaController ()

////////////////////////////////////////////////////////
// REFERENCIAS A LAS VISTAS DEL FORMULARIO DE FACTURA //
////////////////////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UITextField *facturaNumeroTextView;
@property (weak, nonatomic) IBOutlet UITextField *fechaExpedicionTextView;
@property (weak, nonatomic) IBOutlet UITextField *fechaOperacionTextView;
@property (weak, nonatomic) IBOutlet UITextField *cIFTextView;
@property (weak, nonatomic) IBOutlet UITextField *razonSocialTextView;
@property (weak, nonatomic) IBOutlet UITextField *conceptoTextView;
@property (weak, nonatomic) IBOutlet UITextField *baseImponibleTextView;
@property (weak, nonatomic) IBOutlet UITextField *tipoIvaTextView;
@property (weak, nonatomic) IBOutlet UITextField *totalTextView;
@property (weak, nonatomic) IBOutlet UITextField *rectificacionTextView;

@end

@implementation EditarFacturaController

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
