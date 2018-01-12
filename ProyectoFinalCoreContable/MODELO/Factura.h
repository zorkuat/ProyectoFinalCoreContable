//
//  Factura.h
//  ProyectoFinalCoreContable
//
//  Created by cice on 12/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//
/*



El Departamento de Gestión Tributaria podrá exigir en determinadas circunstancias la inclusión de menciones adicionales que, en ningún caso, podrán exceder de las exigidas para la factura completa.

El Departamento de Gestión Tributaria podrá autorizar, en determinadas circunstancias, la expedición de facturas simplificadas que no incluyan los requisitos de las letras a), c), f), g) o i) citados anteriormente, así como, el NIF y domicilio del destinatario y la cuota repercutida.

Dichas autorizaciones deberán ser objeto de la debida publicidad.
*/
 
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Factura : NSObject

///////////////////////////////////////
//// VARIABLES OBLIGADAS DE FACTURA ///
///////////////////////////////////////

/// a) Número y, en su caso, serie.
@property (nonatomic) NSString *numero;

/// b) Fecha de expedición.
@property (nonatomic) NSDate *fechaDeExpedicion;

/// c) Fecha de operación si es distinta de la de expedición.
@property (nonatomic) NSDate *fechaDeOperacion;

/// d) NIF y nombre y apellidos, razón o denominación social del expedidor.
@property (nonatomic) NSString *CIF;

// $$$$ Ya veré si lo hago con expecializaciones de clase
//@property (nonatomic) NSString *nombre;
//@property (nonatomic) NSString *apellidos;
@property (nonatomic) NSString *razonSocial;

/// e) Identificación de los bienes entregados o servicios prestados.
@property (nonatomic) NSString *concepto;

/// f) Tipo impositivo, y opcionalmente también la expresión “IVA incluido”
@property (nonatomic) NSInteger tipoIVA;

/// g) Contraprestación total.
@property (nonatomic) NSInteger baseImponible;

/// h) En las facturas rectificativas, la referencia a la factura rectificada.
@property (nonatomic) NSInteger rectificacion;

/// i) En su caso, si se producen las siguientes circunstancias:
/// - En operaciones exentas referencia a la normativa
/// - La mención “facturación por el destinatario”
/// - La mención “inversión del sujeto pasivo”
/// - La mención “Régimen especial de Agencias de viajes”
/// - La mención “Régimen especial de bienes usados”.
@property (nonatomic) BOOL estaExenta;
@property (nonatomic) NSString *normaExencion;
@property (nonatomic) BOOL facturacionDestinatario;
@property (nonatomic) BOOL inversionPasivo;
@property (nonatomic) BOOL regimenEspecialAgenciaViajes;
@property (nonatomic) BOOL regimenEspecialBienesUsados;

/////////////////////////////////////////////
//// VARIABLES DE PERSISTENCIA Y RESPALDO ///
/////////////////////////////////////////////
@property (nonatomic) UIImage *imagenFactura;
@property (nonatomic) NSFileManager *ficheroFactura;

@end
