//
//  EditarFacturaController.h
//  ProyectoFinalCoreContable
//
//  Created by cice on 12/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Factura.h"
#import "EditarFacturaDelegate.h"

@interface EditarFacturaController : UITableViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) id<EditarFacturaDelegate> delegado;

@end
