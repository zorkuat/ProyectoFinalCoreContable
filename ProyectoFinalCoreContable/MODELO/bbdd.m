//
//  bbdd.m
//  ProyectoFinalCoreContable
//
//  Created by cice on 12/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "bbdd.h"
#import "Factura.h"

@implementation bbdd

-(bbdd*)init
{
    self = [super init];

    if (self)
    {
        self.facturas = [NSMutableArray array];
    }

    return self;
}

-(void)loadDatabase
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 3];
    
    
    // DUMMIES
    for(int i=0; i<10;++i)
    {
        // Creamos la factura dummie
        Factura *nuevaFactura = [[Factura alloc]init];
        
        // Rellenamos campos:
        // NUMERO + CÓDIGO ALEATORIO
        
        for (int i=0; i<3; i++) {
            [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
        }
        nuevaFactura.numero = [NSString stringWithFormat:@"%d/%@",
                               arc4random_uniform(1000),
                               randomString];
        
        // FECHA DE EXPEDICION
        nuevaFactura.fechaDeExpedicion = [NSDate dateWithTimeIntervalSince1970:arc4random_uniform(48)*365*24*60*60];
        
        // FECHA DE OPERACION
        nuevaFactura.fechaDeOperacion = [NSDate dateWithTimeIntervalSince1970:arc4random_uniform(48)*365*24*60*60];
        
        // CIF
        nuevaFactura.baseImponible =arc4random_uniform(2000);
        
        randomString = [NSMutableString stringWithFormat:@""];
        for (int i=0; i<1; i++) {
            [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
        }
        nuevaFactura.CIF = [NSString stringWithFormat:@"%d%@", arc4random_uniform(100000000), randomString];
        
        // Razon Social
        nuevaFactura.razonSocial = [NSString stringWithFormat:@"Razon Social %d", i+1];
        
        // Concepto
        nuevaFactura.concepto = [NSString stringWithFormat:@"Concepto %d", i+1];
        
        // IVA
        nuevaFactura.tipoIVA = 21;
        
        // base imponible
        nuevaFactura.baseImponible =arc4random_uniform(2000);
        
        // rectificacion
        nuevaFactura.rectificacion =0;
        
        // Entregamos y volvemos al loop
        [self.facturas addObject:nuevaFactura];
    }
                               
}

@end
