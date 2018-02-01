//
//  Factura+CoreDataProperties.m
//  ProyectoFinalCoreContable
//
//  Created by cice on 1/2/18.
//  Copyright © 2018 TATINC. All rights reserved.
//
//

#import "Factura+CoreDataProperties.h"

@implementation Factura (CoreDataProperties)

+ (NSFetchRequest<Factura *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Factura"];
}

@dynamic numero;
@dynamic fechaDeExpedicion;
@dynamic fechaDeOperacion;
@dynamic cIF;
@dynamic razonSocial;
@dynamic tipoIVA;
@dynamic rectificacion;
@dynamic baseImponible;
@dynamic porLosSiguientes;

@end
