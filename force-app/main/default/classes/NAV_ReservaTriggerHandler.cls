public class NAV_ReservaTriggerHandler {
    
    // VALIDACIONES antes de guardar
    public static void validarCodigos(List<Reserva__c> nuevas, Map<Id, Reserva__c> antiguasMap){
        
        Set<Id> codigosIds = new Set<Id>();
        for(Reserva__c r : nuevas){
            if(r.Codigo_Promocional__c != null){
                codigosIds.add(r.Codigo_Promocional__c);
            }
        }

        if(codigosIds.isEmpty()) return;

        Map<Id, Codigo_Promocional__c> codigosMap = new Map<Id, Codigo_Promocional__c>(
            [SELECT Id, Cantidad_Disponible__c, Cantidad_Utilizada__c, Fecha_de_Inicio__c, Fecha_de_Termino__c 
             FROM Codigo_Promocional__c WHERE Id IN :codigosIds]
        );

        Date hoy = Date.today();

        for(Reserva__c r : nuevas){

            Id oldCodigo = (antiguasMap != null && antiguasMap.containsKey(r.Id)) ? antiguasMap.get(r.Id).Codigo_Promocional__c : null;

            // Solo validar si tiene código
            if(r.Codigo_Promocional__c == null){
                continue;
            }

            Codigo_Promocional__c cod = codigosMap.get(r.Codigo_Promocional__c);
            if(cod == null){
                r.addError('El código promocional ingresado no existe.');
                continue;
            }

            // Validar vigencia
            if(cod.Fecha_de_Inicio__c != null && hoy < cod.Fecha_de_Inicio__c){
                r.addError('El código promocional aún no está vigente.');
                continue;
            }

            if(cod.Fecha_de_Termino__c != null && hoy > cod.Fecha_de_Termino__c){
                r.addError('El código promocional ha caducado.');
                continue;
            }

            // Validar disponibilidad
            if(cod.Cantidad_Disponible__c != null && cod.Cantidad_Utilizada__c != null){
                if(cod.Cantidad_Utilizada__c >= cod.Cantidad_Disponible__c){
                    r.addError('El código promocional ha alcanzado el máximo de usos permitidos.');
                    continue;
                }
            }
        }
    }

    // ACTUALIZACIÓN de uso después de guardar
    public static void actualizarUsoCodigos(List<Reserva__c> nuevas, Map<Id, Reserva__c> antiguasMap){

        Map<Id, Integer> contadorUsos = new Map<Id, Integer>();

        for(Reserva__c r : nuevas){
            Id oldCodigo = (antiguasMap != null && antiguasMap.containsKey(r.Id)) ? antiguasMap.get(r.Id).Codigo_Promocional__c : null;
            Id newCodigo = r.Codigo_Promocional__c;
        
            // Caso 1: Se agregó un nuevo código
            if(oldCodigo == null && newCodigo != null){
                contadorUsos.put(newCodigo, contadorUsos.get(newCodigo) == null ? 1 : contadorUsos.get(newCodigo) + 1);
            }
        
            // Caso 2: Se eliminó el código
            else if(oldCodigo != null && newCodigo == null){
                contadorUsos.put(oldCodigo, contadorUsos.get(oldCodigo) == null ? -1 : contadorUsos.get(oldCodigo) - 1);
            }
        
            // Caso 3: Se cambió el código
            else if(oldCodigo != null && newCodigo != null && oldCodigo != newCodigo){
                contadorUsos.put(oldCodigo, contadorUsos.get(oldCodigo) == null ? -1 : contadorUsos.get(oldCodigo) - 1);
                contadorUsos.put(newCodigo, contadorUsos.get(newCodigo) == null ? 1 : contadorUsos.get(newCodigo) + 1);
            }
        }

        if(contadorUsos.isEmpty()) return;

        List<Codigo_Promocional__c> codigosActualizar = new List<Codigo_Promocional__c>();
        for(Id codId : contadorUsos.keySet()){
            Codigo_Promocional__c c = new Codigo_Promocional__c(Id = codId);
            c.Cantidad_Utilizada__c = (c.Cantidad_Utilizada__c == null ? 0 : c.Cantidad_Utilizada__c) + contadorUsos.get(codId);
            codigosActualizar.add(c);
        }

        if(!codigosActualizar.isEmpty()){
            update codigosActualizar;
        }
    }

 public static void actualizarCantidadCodigos(List<Reserva__c> newList, List<Reserva__c> oldList){
        Set<Id> codigosIds = new Set<Id>();
        Map<Id, Decimal> contadorCambios = new Map<Id, Decimal>();

        // Registrar los códigos nuevos (sumar)
        if(newList != null){
            for(Reserva__c r : newList){
                if(r.Codigo_Promocional__c != null){
                    codigosIds.add(r.Codigo_Promocional__c);
                    contadorCambios.put(
                        r.Codigo_Promocional__c,
                        (contadorCambios.containsKey(r.Codigo_Promocional__c) ? contadorCambios.get(r.Codigo_Promocional__c) : 0) + 1
                    );
                }
            }
        }

        // Registrar los códigos antiguos (restar)
        if(oldList != null){
            for(Reserva__c r : oldList){
                if(r.Codigo_Promocional__c != null){
                    codigosIds.add(r.Codigo_Promocional__c);
                    contadorCambios.put(
                        r.Codigo_Promocional__c,
                        (contadorCambios.containsKey(r.Codigo_Promocional__c) ? contadorCambios.get(r.Codigo_Promocional__c) : 0) - 1
                    );
                }
            }
        }

        if(codigosIds.isEmpty()) return;

        // Consultar los códigos involucrados
        List<Codigo_Promocional__c> codigos = [
            SELECT Id, Cantidad_Utilizada__c 
            FROM Codigo_Promocional__c 
            WHERE Id IN :codigosIds
        ];

        // Actualizar las cantidades utilizadas
        for(Codigo_Promocional__c c : codigos){
            Decimal cambio = contadorCambios.containsKey(c.Id) ? contadorCambios.get(c.Id) : 0;
            Decimal cantidadActual = (c.Cantidad_Utilizada__c == null ? 0 : c.Cantidad_Utilizada__c);
            Decimal nuevaCantidad = cantidadActual + cambio;

            if(nuevaCantidad < 0){
                nuevaCantidad = 0;
            }

            c.Cantidad_Utilizada__c = nuevaCantidad;
        }

        if(!codigos.isEmpty()){
            update codigos;
        }
    }
}