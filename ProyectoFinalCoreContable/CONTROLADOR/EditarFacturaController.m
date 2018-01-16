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
@property (weak, nonatomic) IBOutlet UITextField *ficheroTextView;

@property (strong, nonatomic) IBOutlet UIDatePicker *pickerFecha;
@property (strong, nonatomic) IBOutlet UIToolbar *barraEditor;

@property (weak, nonatomic) UITextField *campoTextoActual;

@end

@implementation EditarFacturaController

////////////////////////////////////
// MÉTODO DE CARGA DE LAS VISTAS. //
////////////////////////////////////
// Creamos la variable de trabajo local y actualizamos los campos si no son vacíos.
// Asociamos las referencias a vista con los campos de la variable de trabajo local.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Para quitar el espacio que se queda entre el picker y la barra de accesory view.
    // En realidad son movidas de constraints y su puta madre.
    
    if(self.factura == nil)
    {
         self.factura = [[Factura alloc] init];
    }
    
    /* No hay imagen en esta vista
    if (self.factura.imagenFactura foto != nil)
    {
        self.factura = self.contacto.foto;
    }*/
     
    //self.vistaImagenContacto.layer.borderWidth = 1;
    //self.vistaImagenContacto.layer.cornerRadius = 8;
     
    self.pickerFecha.translatesAutoresizingMaskIntoConstraints = false;
    self.fechaExpedicionTextView.inputView = self.pickerFecha;
    self.fechaExpedicionTextView.inputAccessoryView = self.barraEditor;
    self.fechaOperacionTextView.inputView = self.pickerFecha;
    self.fechaOperacionTextView.inputAccessoryView = self.barraEditor;
     
    // Añadida la barra de botón DONE al teclado.
    
    self.facturaNumeroTextView.text = self.factura.numero;
    self.cIFTextView.text = self.factura.CIF;
    self.razonSocialTextView.text = self.factura.razonSocial;
    self.conceptoTextView.text = self.factura.concepto;
    self.baseImponibleTextView.text = [NSString stringWithFormat:@"%f", self.factura.baseImponible];
    self.tipoIvaTextView.text = [NSString stringWithFormat:@"%ld", self.factura.tipoIVA];
    self.rectificacionTextView.text = [NSString stringWithFormat:@"%f", self.factura.rectificacion];
    NSInteger total = self.factura.baseImponible + (self.factura.tipoIVA*self.factura.baseImponible/100) - self.factura.rectificacion;
    self.totalTextView.text = [NSString stringWithFormat:@"%ld", total];
    
    
    if(self.factura.fechaDeExpedicion != nil)
    {
        self.pickerFecha.date = self.factura.fechaDeExpedicion;
        NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
        formatoFecha.dateFormat = @"dd / MM / YYYY";
        self.fechaExpedicionTextView.text = [formatoFecha stringFromDate:self.factura.fechaDeExpedicion];
    }
    
    if(self.factura.fechaDeOperacion != nil)
    {
        self.pickerFecha.date = self.factura.fechaDeOperacion;
        NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
        formatoFecha.dateFormat = @"dd / MM / YYYY";
        self.fechaOperacionTextView.text = [formatoFecha stringFromDate:self.factura.fechaDeOperacion];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////////////////////////////
// MÉTODOS DE LOS BOTONES //
////////////////////////////
// Implementación del método de cancelar botón de la vista EDITAR
- (IBAction)cancelButtonPressed:(id)sender {
    //[self dismissViewControllerAnimated:true completion:nil];
    
    [self.delegado cancelar];
}

// Implementación del método para guardar los datos de usuario
- (IBAction)saveButtonPressed:(id)sender {
    
    // Durante el botón guardado, actualizamos los valores desde las vistas al objeto de trabajo
    self.factura.numero = self.facturaNumeroTextView.text;
    self.factura.CIF = self.cIFTextView.text;
    self.factura.razonSocial = self.razonSocialTextView.text;
    self.factura.concepto = self.conceptoTextView.text;
    self.factura.baseImponible = [self.baseImponibleTextView.text floatValue];
    self.factura.tipoIVA = [self.tipoIvaTextView.text integerValue];
    self.factura.rectificacion = [self.rectificacionTextView.text floatValue];
  
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
    formatoFecha.dateFormat = @"dd / MM / YYYY";
    self.factura.fechaDeExpedicion = [formatoFecha dateFromString:self.fechaExpedicionTextView.text];
    self.factura.fechaDeOperacion = [formatoFecha dateFromString:self.fechaOperacionTextView.text];
   
    // llamamos al delegado que guarda la factura.
    // AMBAS VISTAS TIENEN QUE IMPLEMENTAR EL DELEGADO
    [self.delegado guardarfactura:self.factura];
}

/*
- (IBAction)imagenPulsada:(id)sender {
    // Ya luego si eso.
    UIImagePickerController * galeria = [[UIImagePickerController alloc] init];
    galeria.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    galeria.delegate = self;
    [self presentViewController:galeria animated:true completion:nil];
}*/

/////////////////////////////////////////
// MÉTODOS DE GESTIÓN DEL PICKER FECHA //
/////////////////////////////////////////

// Gestión de la cesión del foco cuando se pulsa el botón del input auxiliar del picker.
- (IBAction)botonDonePulsado:(id)sender {
    
    if(self.campoTextoActual == self.fechaExpedicionTextView)
    {
        [self.fechaOperacionTextView becomeFirstResponder];
    }
    else if(self.campoTextoActual == self.fechaOperacionTextView)
    {
        [self.cIFTextView becomeFirstResponder];
    }
}

// Gestión del cambio efectivo del valor mostrado (todavía no guardado. sólo se guardará cuando se le de al save) en el picker fecha
- (IBAction)pickerFechaCambiada:(id)sender {
    
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
    formatoFecha.dateFormat = @"dd / MM / YYYY";
    if(self.campoTextoActual == self.fechaExpedicionTextView)
    {
        self.fechaExpedicionTextView.text = [formatoFecha stringFromDate:self.pickerFecha.date];
    }
    else if(self.campoTextoActual == self.fechaOperacionTextView)
    {
        self.fechaOperacionTextView.text = [formatoFecha stringFromDate:self.pickerFecha.date];
    }
}

#pragma mark - TEXT FIELD DELEGATE

// Gestión del 'return' en las vistas textfield. Se cede el fóco al siguiente campo excepto el último que simplemente renuncia a él.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  if(textField == self.facturaNumeroTextView)
  {
      [self.fechaExpedicionTextView becomeFirstResponder];
  }
  else if(textField == self.cIFTextView)
  {
      [self.razonSocialTextView becomeFirstResponder];
  }
  else if (textField == self.razonSocialTextView)
  {
      [self.conceptoTextView becomeFirstResponder];
  }
  else if (textField == self.conceptoTextView)
  {
      [self.baseImponibleTextView becomeFirstResponder];
  }
  else if (textField == self.baseImponibleTextView)
  {
      [self.tipoIvaTextView becomeFirstResponder];
  }
  else if (textField == self.tipoIvaTextView)
  {
      [self.rectificacionTextView becomeFirstResponder];
  }
  else if (textField == self.rectificacionTextView)
  {
      [self.ficheroTextView becomeFirstResponder];
  }
  else if(textField == self.ficheroTextView)
  {
      [self.ficheroTextView resignFirstResponder];
  }
  return true;
}

/////////////////////////////////////////////////////
// MÉTODOS DE GESTIÓN DE CONTENIDO DE LOS TEXTVIEW //
///////////////////////////////////////////////////////////////////////////
// TODOS LOS UIVIEW TIENEN DESIGNADO COMO DELEGADO AL PROPIO CONTROLADOR //
// ESTO SE HACE DESDE EL STORYBOARD                                      //
// POR CADA ESPECIALIZACIÓN QUE SE QUIERA HACER SE DEBE IMPLEMENTAR      //
// PRIMERO LA DETECCIÓN DEL CAMPO EN EL QUE ESTAMOS Y LUEGO EL MËTODO    //
///////////////////////////////////////////////////////////////////////////

// MÉTODO PARA GESTIÓN DE CARACTERES DURANTE LA EDICIÓN.
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
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
     */
    return true;
     
}

// MÉTODO DE SELECCIÓN DE TEXT FIELD
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.campoTextoActual = textField;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    /*
    if(textField == self.campoTextoEmail)
    {
         // Método 1
         NSRange posicionArroba = [textField.text rangeOfString:@"@"];
         
         NSUInteger posicionInicialPunto = posicionArroba.location == NSNotFound ? 0 : posicionArroba.location;
         
         NSUInteger longitudPunto = posicionArroba.location == NSNotFound ? 0 : textField.text.length - posicionArroba.location;
         NSRange posicionPunto = [textField.text rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(posicionInicialPunto,longitudPunto)];
     
        
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
        
    }*/

    return true /*BLOOD*/;
}


#pragma mark - Image picker delegate

// NO HAY IMAGE PICKER.

/// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
/// $$ IMPLEMENTAR MÉTODOS DELEGADOS PARA BÚSQUEDA Y CARGA $$
/// $$ DE FICHERO COMPLEMENTARIO                           $$
/// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

/*
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
}*/

@end
