

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
#import "EditarFacturaDelegate.h"

@interface ListadoFacturasController ()

@end

//////////////////////////////////////////////////////////////

@implementation ListadoFacturasController

/// CARGA DE VISTA. Creamos la base de datos interna que se relena con datos dummies.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bbdd = [[bbdd alloc] init];
    
    [self.bbdd loadDatabase];
    
    /// Asignación del botón de la barra de navegación izquierda (no asignada en el storyboard) al botón edit.
    /// Sirve para la edición inmediata (funciones quick de borrado e insercción)
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSLog(@"%ld",self.bbdd.facturas.count);
}


/// Aviso de memoria agotada
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/// No se toca tampoco. Función de animación en carga
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

/////////////////////////////////////////////////////////////////
// OVERRIDING de funciones básicas del controlador Table View. //
/////////////////////////////////////////////////////////////////

// FUNCIONES DE GESTIÓN DE DATOS
#pragma mark - Table view data source

// Definición del número de secciones
// A falta de definir cuantas secciones: 1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // #warning Incomplete implementation, return the number of sections
    return 1;
}

// Deficinión del número de filas
// Una fila por cada elemento de la tabla más el elemento de edición.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // #warning Incomplete implementation, return the number of rows
    return self.bbdd.facturas.count + 1;
}


/// Método de mostrado de datos por fila:
/// PRE: bbdd != NIL
/// POST: indexPath.i.cell.contenidos[...].TextLabel.Text == bbdd.i.contenidos[...].contenido
/// POST: if indexPath.i+1 -> cell.contenidos == nuevoContacto

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row < self.bbdd.facturas.count)
    {
        Factura *factura = self.bbdd.facturas[indexPath.row];
        cell.textLabel.text = factura.numero;
        float total = factura.baseImponible + factura.tipoIVA*factura.baseImponible/100;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", total];
       
        // Si no tenemos foto cargada no metemos preview de foto.
        if(factura.imagenFactura != nil)
        {
            cell.imageView.image = factura.imagenFactura ;
        }
    }
    else
    {
        cell.textLabel.text = @"Nueva Factura";
        cell.detailTextLabel.text = @"";
        
    }
    return cell;
}


/// Si se selecciona una celda se lanza la transición.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.bbdd.facturas.count)
    {
        [self performSegueWithIdentifier:@"verFactura" sender:nil];
    }
}


/// Métodos quicksort para edición rápida.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.bbdd.facturas.count)
    {
        return UITableViewCellEditingStyleDelete;
    }
    else
    {
        return UITableViewCellEditingStyleInsert;
    }
}


// FUNCIONES DE GESTIÓN DE TRASNSICIÓN DE VISTA

#pragma mark - Table view transition

// Este método es el Adolfo Suárez de los métodos: Prepara la Transición.
// PRE: vistaSiguiente == verFactura
// POST: enviar.factura -> vistaSiguiente

// Quicksort adding
// PRE: vistaSiguiente == crearContacto
// POST: vistaSiguiente.selfdelegate

// PRE: vistaSiguiente == añadirContacto
// POST: vista
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /////////////////////////////////////////////
    /// CREAR LA TRANSICIÓN PARA VER CONTACTO ///
    /////////////////////////////////////////////
    
    /// CASO DE TRANSICIÓN A LA VISTA DE EDICIÓN
    if([segue.identifier isEqualToString:@"verFactura"])
    {
        // Generamos una variable auxiliar recuperando el contacto desde la fila seleccionada ppor el usuario.
        int filaSeleccionada = (int)self.tableView.indexPathForSelectedRow.row;
        
        Factura * facturaSeleccionada = self.bbdd.facturas[filaSeleccionada];
        
        DetalleFacturaController *escenaDestino = segue.destinationViewController;
        
        // Vamos a pasar la información. Aquí la factura es la INTERNA de gestión de la escena destino.
        escenaDestino.factura = facturaSeleccionada;
    }
    /// CASO DE TRANSICIÓN A LA PANTALLA QUICKSHORT DE EDICIÓN
    else if ([segue.identifier isEqualToString:@"crearFactura"])
    {
        // En el caso de que creemos la factura desde la lista, nos autoasignamos el delegado para implementar los métodos del
        // protocolo. Asignación directa.
        // Ahora mismo daría lo mismo.
        EditarFacturaController *escenaDestino = segue.destinationViewController;
        escenaDestino.delegado = self;
    }
    
    /// CASO DE TRANSICIÓN A LA VISTA DE ADICIÓN DE FACTURA
    /// No es transición directa, hay que pasar por la vista de navegación primero.
    else if ([segue.identifier isEqualToString:@"anadirFactura"])
    {
        UINavigationController *navController = segue.destinationViewController;
        EditarFacturaController *escenaDestino = (id)navController.topViewController;
        escenaDestino.delegado = self;
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


#pragma mark - Table View Quick Editing

// MÉTODO PARA LA EDICIÓN EN QUICKSHORT
// Override to support editing the table view.
/// Método para insertar en lugar de borrar.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    /// QUICK BORRADO
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.bbdd.facturas removeObjectAtIndex:indexPath.row];
        /// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        /// $$ MOSTRAR UNA ALERTA                        $$
        /// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    /// QUICK INSERCCIÓN
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        Factura *nuevaFactura = [[Factura alloc] init];
        /// Insercción a nivel de datos
        /// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        /// $$ IMPLEMENTAR MÉTODO PARA LLAMAR A UN PICKER PERSONALIZADO Y RELLENAR LOS DATOS DE LA FACTURA $$
        /// $$ O EN SU DEFECTO LLAMAR DIRECTAMENTE A LA VISTA DE EDICIÓN DE FACTURA                        $$
        /// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        nuevaFactura.numero = @"Numero Nuevo";
        [self.bbdd.facturas addObject: nuevaFactura];
        
        /// Insercción a nivel de vista con animación.x
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

#pragma mark - Editar Contacto Delegate

-(void)cancelar
{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)guardarfactura:(Factura *)Factura
{
    [self.bbdd.facturas addObject:self.factura];
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
