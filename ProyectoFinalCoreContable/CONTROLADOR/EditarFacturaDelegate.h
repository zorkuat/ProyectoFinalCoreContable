//
//  EditarContactoDelegate.h
//  ProyectoFinalCoreContable
//
//  Created by cice on 15/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Para evitar cargas de cabeceras redundantes, antes que montar el "fichero de carga .h" declaramos como class (precarga de objeto)
/// el objeto Factura. Total, al delegado le da lo mismo.
@class Factura;

@protocol EditarFacturaDelegate <NSObject>

-(void)guardarfactura:(Factura*) Factura;
-(void)cancelar;

@end
