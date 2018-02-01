//
//  Concepto+CoreDataProperties.m
//  ProyectoFinalCoreContable
//
//  Created by cice on 1/2/18.
//  Copyright © 2018 TATINC. All rights reserved.
//
//

#import "Concepto+CoreDataProperties.h"

@implementation Concepto (CoreDataProperties)

+ (NSFetchRequest<Concepto *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Concepto"];
}

@dynamic descripcion;
@dynamic realizadoParaLa;

@end
