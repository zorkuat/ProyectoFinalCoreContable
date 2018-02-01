//
//  BaseDatosSQLITE.m
//  ProyectoFinalCoreContable
//
//  Created by cice on 1/2/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "BaseDatosSQLITE.h"
//#import "Artista+CoreDataClass.h"
#import "Factura+CoreDataClass.h"
#import <CoreData/CoreData.h>

/// Extensión de la base de datos
@interface BaseDatos ()

@property (nonatomic) NSPersistentContainer *gestorBaseDatos;
@property (nonatomic) NSManagedObjectContext *moc;

@end

@implementation BaseDatos

#pragma mark Singleton Methods

+ (BaseDatos*)instancia {
    static BaseDatos *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)cargarBaseDatos
{
    /// Le ponemos el nombre del modelo
    self.gestorBaseDatos = [NSPersistentContainer persistentContainerWithName:@"FacturasModel"];
    
    /// Esto es la URL donde va a generar la ruta de la SQLite
    NSURL * rutaSQLite = self.gestorBaseDatos.persistentStoreDescriptions.firstObject.URL;
    
    bool existeBaseDatos = [[NSFileManager defaultManager] fileExistsAtPath:rutaSQLite.path];
    
    [self.gestorBaseDatos loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull description, NSError * _Nullable error)
     {
         if (error == nil)
         {
             /// Accedemos al moc y lo guardamos en la propiedad.
             /// LARGO DE MI PROPIEDAD!!!
             /// FUERA DE MI PROPIEDAD!!!
             self.moc = self.gestorBaseDatos.viewContext;
             NSLog(@"Base de datos Creada");
             
             // Con esto cargamos datos sólo una vez no vaya a ser que los cargemos
             // muchas veces, esto es una vez por cada inicialización como lo teníamos antes.
             // Antes: Sí.
             // Ahora: No.
             if (!existeBaseDatos)
             {
                 //Artista *nuevoArtista = [NSEntityDescription insertNewObjectForEntityForName:@"Artista" inManagedObjectContext:self.moc];
                 Factura *nuevaFactura = [NSEntityDescription insertNewObjectForEntityForName:@"Factura" inManagedObjectContext:self.moc];
                 /*nuevaFactura.
                 nuevoArtista.nombre = @"Fulaner Sneider";
                 nuevoArtista.fechaNacimiento = [NSDate dateWithTimeIntervalSince1970:0];
                 nuevoArtista.nacionalidad = @"Mierdlandés";*/
                 [self.moc save:nil];
             }
         }
         else
         {
             NSLog(@"La jodiste, Maciste: %@", error.description);
         }
     }];
}

-(NSManagedObjectContext *)moc
{
    /// Sirve para operar con la base de datos y hacer lo que te salga de la chofla con él
    return _moc;
}

@end

