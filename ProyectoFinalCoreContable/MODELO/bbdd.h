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
