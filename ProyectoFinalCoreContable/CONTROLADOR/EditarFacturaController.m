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

// Implementación del método de cancelar botón de la vista EDITAR
- (IBAction)cancelButtonPressed:(id)sender {
    //[self dismissViewControllerAnimated:true completion:nil];
    
    [self.delegado cancelar];
}

// Implementación del método para guardar los datos de usuario
- (IBAction)saveButtonPressed:(id)sender {
    
    self.contacto.nombre = self.campoTextoNombre.text;
    self.contacto.telefono = self.campoTextoTelefono.text;
    self.contacto.email = self.campoTextoEmail.text;
    self.contacto.foto = self.fotoSeleccionada;
    
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
    formatoFecha.dateFormat = @"dd / MM / YYYY";
    self.contacto.fechadeNacimiento = [formatoFecha dateFromString:self.campoTextoFechaNacimiento.text];
    
    //
    [self.delegado guardarContacto:self.contacto];
    
}

- (IBAction)imagenPulsada:(id)sender {
    // Ya luego si eso.
    UIImagePickerController * galeria = [[UIImagePickerController alloc] init];
    galeria.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    galeria.delegate = self;
    [self presentViewController:galeria animated:true completion:nil];
}

- (IBAction)botonDonePulsado:(id)sender {
    if(self.campoTextoActual == self.campoTextoTelefono)
    {
        [self.campoTextoEmail becomeFirstResponder];
    }
    else if(self.campoTextoActual == self.campoTextoFechaNacimiento)
    {
        [self.campoTextoFechaNacimiento resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.campoTextoNombre)
    {
        [self.campoTextoTelefono becomeFirstResponder];
    }
    else if(textField == self.campoTextoEmail)
    {
        [self.campoTextoFechaNacimiento becomeFirstResponder];
    }
    
    return true;
}

- (IBAction)pickerFechaCambiada:(id)sender {
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
    formatoFecha.dateFormat = @"dd / MM / YYYY";
    self.campoTextoFechaNacimiento.text = [formatoFecha stringFromDate:self.pickerFecha.date];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Para quitar el espacio que se queda entre el picker y la barra de accesory view.
    // En realidad son movidas de constraints y su puta madre.
    
    if(self.contacto == nil)
    {
        self.contacto = [[Contacto alloc] init];
    }
    
    if (self.contacto.foto != nil)
    {
        self.vistaImagenContacto.image = self.contacto.foto;
    }
    
    self.vistaImagenContacto.layer.borderWidth = 1;
    self.vistaImagenContacto.layer.cornerRadius = 8;
    
    self.pickerFecha.translatesAutoresizingMaskIntoConstraints = false;
    
    self.campoTextoFechaNacimiento.inputView = self.pickerFecha;
    self.campoTextoFechaNacimiento.inputAccessoryView = self.barraEditor;
    
    // Añadida la barra de botón DONE al teclado.
    self.campoTextoTelefono.inputAccessoryView = self.barraEditor;
    
    self.campoTextoNombre.text = self.contacto.nombre;
    self.campoTextoTelefono.text = self.contacto.telefono;
    self.campoTextoEmail.text = self.contacto.email;
    
    if(self.contacto.fechadeNacimiento != nil)
    {
        self.pickerFecha.date = self.contacto.fechadeNacimiento;
        NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
        formatoFecha.dateFormat = @"dd / MM / YYYY";
        self.campoTextoFechaNacimiento.text = [formatoFecha stringFromDate:self.contacto.fechadeNacimiento];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TEXT FIELD DELEGATE
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.campoTextoTelefono){
        for(int i=0; i<string.length; i++)
        {
            unichar caracter = [string characterAtIndex:i];
            if (caracter < '0' || caracter > '9')
                return false;
        }
        
        if (((int)(textField.text.length) + string.length - range.length) > 9)
            return false;
    }
    return true;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.campoTextoActual = textField;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField == self.campoTextoEmail)
    {
        /* Método 1
         NSRange posicionArroba = [textField.text rangeOfString:@"@"];
         
         NSUInteger posicionInicialPunto = posicionArroba.location == NSNotFound ? 0 : posicionArroba.location;
         
         NSUInteger longitudPunto = posicionArroba.location == NSNotFound ? 0 : textField.text.length - posicionArroba.location;
         NSRange posicionPunto = [textField.text rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(posicionInicialPunto,longitudPunto)];
         */
        
        NSRange posicionArroba = [textField.text rangeOfString:@"@"];
        NSRange posicionPunto = [textField.text rangeOfString:@"."
                                                      options:NSBackwardsSearch
                                                        range:NSMakeRange(0, textField.text.length)];
        if(posicionArroba.location == NSNotFound || posicionPunto.location == NSNotFound || posicionPunto.location < posicionArroba.location)
        {
            UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"Error" message:@"El mensaje no es valido" preferredStyle:UIAlertControllerStyleAlert];
            
            [alerta addAction:[UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                               {
                                   // [self dismissViewControllerAnimated:true completion:nil];
                               }]];
            
            [self presentViewController:alerta animated:true completion:nil];
            
            return false;
        }
        
    }
    return true /*BLOOD*/;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Image picker delegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSURL *imageURL = info[UIImagePickerControllerImageURL];
    
    UIImage *foto = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL] scale: 1];
    
    self.vistaImagenContacto.image = foto;
    
    self.fotoSeleccionada = foto;
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
