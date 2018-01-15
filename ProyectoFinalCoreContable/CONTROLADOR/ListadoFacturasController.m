

//
//  ListadoFacturasController.m
//  ProyectoFinalCoreContable
//
//  Created by cice on 12/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "ListadoFacturasController.h"
#import "DetalleFacturaController.h"
#import "EditarFacturaController.h"

@interface ListadoFacturasController ()

@end

@implementation ListadoFacturasController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bbdd = [[bbdd alloc] init];
    
    [self.bbdd loadDatabase];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSLog(@"%ld",self.bbdd.facturas.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // #warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // #warning Incomplete implementation, return the number of rows
    return self.bbdd.facturas.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row < self.bbdd.facturas.count)
    {
        Factura *factura = self.bbdd.facturas[indexPath.row];
        cell.textLabel.text = factura.numero;
        float total = factura.baseImponible + factura.tipoIVA*factura.baseImponible/100;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", total];
       
        /*if(contacto.foto != nil)
        {
            cell.imageView.image = contacto.foto ;
        }*/
    }
    else
    {
        cell.textLabel.text = @"Nuevo contacto";
        cell.detailTextLabel.text = @"";
        
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.bbdd.facturas.count)
    {
        [self performSegueWithIdentifier:@"verFactura" sender:nil];
    }
}

/*
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.bbdd.contactos.count)
    {
        return UITableViewCellEditingStyleDelete;
    }
    else
    {
        return UITableViewCellEditingStyleInsert;
    }
}*/

#pragma mark - Table view transition

// Este método es el Adolfo Suárez de los métodos.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /// CREAR LA TRANSICIÓN PARA VER CONTACTO
    if([segue.identifier isEqualToString:@"verFactura"])
    {
        // Generamos una variable auxiliar recuperando el contacto desde la fila seleccionada ppor el usuario.
        int filaSeleccionada = (int)self.tableView.indexPathForSelectedRow.row;
        
        Factura * facturaSeleccionada = self.bbdd.facturas[filaSeleccionada];
        
        DetalleFacturaController *escenaDestino = segue.destinationViewController;
        
        // Vamos a pasar la información
        escenaDestino.factura = facturaSeleccionada;
    }
    /*
    else if ([segue.identifier isEqualToString:@"crearContacto"])
    {
        EditarContactoController *escenaDestino = segue.destinationViewController;
        escenaDestino.delegado = self;
    }
    else if ([segue.identifier isEqualToString:@"anadirContacto"])
    {
        UINavigationController *navController = segue.destinationViewController;
        EditarContactoController *escenaDestino = (id)navController.topViewController;
        escenaDestino.delegado = self;
    }
*/
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.bbdd.contactos removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
        /// Insercción a nivel de datos
        Contacto *nuevoContacto = [[Contacto alloc] init];
        nuevoContacto.nombre = @"Nombre contacto";
        [self.bbdd.contactos addObject: nuevoContacto];
        
        /// Insercción a nivel de vista
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}
*/
 
/*
 /// Método para insertar en lugar de borrar.
 -(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return UITableViewCellEditingStyleInsert;
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Editar Contacto Delegate

/*
-(void)cancelar
{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)guardarContacto:(Contacto *)contacto
{
    [self.bbdd.contactos addObject:self.contacto];
    [self dismissViewControllerAnimated:true completion:nil];
}
*/

@end
