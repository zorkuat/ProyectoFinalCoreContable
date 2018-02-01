//
//  bbdd.h
//  ProyectoFinalCoreContable
//
//  Created by cice on 12/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Factura.h"

@interface bbdd : NSObject


@property (nonatomic) NSMutableArray<Factura*> *facturas;

// Driver
-(void)loadDatabase;


@end


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BaseDatos : NSObject

+ (BaseDatos*)instancia;

-(void) cargarBaseDatos;
-(NSManagedObjectContext *) moc;

@end
