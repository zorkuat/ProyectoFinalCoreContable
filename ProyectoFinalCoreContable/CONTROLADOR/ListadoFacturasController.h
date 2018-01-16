//
//  ListadoFacturasController.h
//  ProyectoFinalCoreContable
//
//  Created by cice on 12/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditarFacturaDelegate.h"
#import "Factura.h"
#import "bbdd.h"

@interface ListadoFacturasController : UITableViewController <EditarFacturaDelegate>

@property (nonatomic) Factura * factura;

@property (nonatomic) bbdd *bbdd;

@end
