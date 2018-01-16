//
//  DetalleFacturaController.m
//  ProyectoFinalCoreContable
//
//  Created by cice on 15/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "DetalleFacturaController.h"
#import "EditarFacturaController.h"

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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetalleFacturaController

// PRE: self.factura != nil
// POST: UILabels[].text == self.factura.contenido
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.facturaNumeroView.text = self.factura.numero;
    
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
    formatoFecha.dateFormat = @"dd / MM / yyyy";
    self.fechaExpedicionView.text = [formatoFecha stringFromDate:self.factura.fechaDeExpedicion];
    self.fechaOperacionLabel.text = [formatoFecha stringFromDate:self.factura.fechaDeOperacion];
    
    self.cIFView.text = self.factura.CIF;
    self.razonSocialView.text = self.factura.razonSocial;
    self.conceptoView.text = self.factura.concepto;
    self.baseView.text = [NSString stringWithFormat:@"%ld", (long)self.factura.baseImponible];
    self.IVAView.text = [NSString stringWithFormat:@"%ld%%", self.factura.tipoIVA];
    NSInteger total = (self.factura.baseImponible + self.factura.baseImponible*self.factura.tipoIVA/100) - self.factura.rectificacion;
    self.totalView.text = [NSString stringWithFormat:@"%ld", total];
    self.rectificacionView.text = [NSString stringWithFormat:@"%ld", (long)self.factura.rectificacion];
    if (self.factura.imagenFactura != nil){
        self.imageView.image = self.factura.imagenFactura;
    }
}

// Método de recarga si hemos cancelado la edición de una factura. Muestra los datos anteriores.
-(void)viewWillAppear:(BOOL)animated
{
    self.facturaNumeroView.text = self.factura.numero;
    
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
    formatoFecha.dateFormat = @"dd / MM / yyyy";
    self.fechaExpedicionView.text = [formatoFecha stringFromDate:self.factura.fechaDeExpedicion];
    self.fechaOperacionLabel.text = [formatoFecha stringFromDate:self.factura.fechaDeOperacion];
    
    self.cIFView.text = self.factura.CIF;
    self.razonSocialView.text = self.factura.razonSocial;
    self.conceptoView.text = self.factura.concepto;
    self.baseView.text = [NSString stringWithFormat:@"%f", self.factura.baseImponible];
    self.IVAView.text = [NSString stringWithFormat:@"%ld%%", self.factura.tipoIVA];
    float total = (self.factura.baseImponible + self.factura.baseImponible*self.factura.tipoIVA/100) - self.factura.rectificacion;
    self.totalView.text = [NSString stringWithFormat:@"%f", total];
    self.rectificacionView.text = [NSString stringWithFormat:@"%ld", (long)self.factura.rectificacion];
    
    if (self.factura.imagenFactura != nil){
        self.imageView.image = self.factura.imagenFactura;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // PASO 1: Identificar el controlador de la transición. Sólo hay uno.
    if([segue.identifier isEqualToString:@"editarFactura"])
    {
        // Pasamos por el navegador primero.
        UINavigationController *controladorNavegacion = segue.destinationViewController;
        EditarFacturaController *escenaDestino = (id)controladorNavegacion.topViewController;
        
        // Vamos a pasar la información
        escenaDestino.factura = self.factura;
        escenaDestino.delegado = self;
        
    }
}

#pragma mark - Editar Contacto Delegate

-(void)cancelar
{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)guardarfactura:(Factura *)factura
{
    // [self.bbdd.facturas addObject:self.factura];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
