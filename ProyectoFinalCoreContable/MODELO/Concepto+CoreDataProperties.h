//
//  Concepto+CoreDataProperties.h
//  ProyectoFinalCoreContable
//
//  Created by cice on 1/2/18.
//  Copyright © 2018 TATINC. All rights reserved.
//
//

#import "Concepto+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Concepto (CoreDataProperties)

+ (NSFetchRequest<Concepto *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *descripcion;
@property (nullable, nonatomic, retain) Factura *realizadoParaLa;

@end

NS_ASSUME_NONNULL_END
