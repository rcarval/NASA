/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EF)
Proyecto: Naviera Austral
Descripción: Clase para cancelar reservas pasados los 20 minutos de la ultima actualizacion
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     16-06-2022    EF       Creación de la Clase.
***********************************************************************************/
global class NAV_ReservasScheduled20 implements Schedulable {
    global void execute(SchedulableContext SC) {
        NAV_ReservasCanceladasMinutos.cancelaReservas20Mins();
    }
}