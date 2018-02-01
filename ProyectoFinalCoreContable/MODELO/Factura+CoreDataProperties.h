//
//  Factura+CoreDataProperties.h
//  ProyectoFinalCoreContable
//
//  Created by cice on 1/2/18.
//  Copyright © 2018 TATINC. All rights reserved.
//
//

#import "Factura+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Factura (CoreDataProperties)

+ (NSFetchRequest<Factura *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *numero;
@property (nullable, nonatomic, copy) NSDate *fechaDeExpedicion;
@property (nullable, nonatomic, copy) NSDate *fechaDeOperacion;
@property (nullable, nonatomic, copy) NSString *cIF;
@property (nullable, nonatomic, copy) NSString *razonSocial;
@property (nonatomic) int16_t tipoIVA;
@property (nonatomic) int16_t rectificacion;
@property (nonatomic) int16_t baseImponible;
@property (nullable, nonatomic, retain) NSSet<Concepto *> *porLosSiguientes;

@end

@interface Factura (CoreDataGeneratedAccessors)

- (void)addPorLosSiguientesObject:(Concepto *)value;
- (void)removePorLosSiguientesObject:(Concepto *)value;
- (void)addPorLosSiguientes:(NSSet<Concepto *> *)values;
- (void)removePorLosSiguientes:(NSSet<Concepto *> *)values;

@end

NS_ASSUME_NONNULL_END
