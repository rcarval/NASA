/**
 * @description       : Clase para calendarizar tareas programadas de reserva.
 * @author            : Esteban Flores
 * @group             : Seidor
 * @last modified on  : 05-27-2022
 * @last modified by  : Esteban Flores
 * @project           : Naviera
**/
global class NAV_ReservasScheduled implements Schedulable {
    global void execute(SchedulableContext SC) {
        NAV_ReservasCanceladas.cancelaReservas();
    }
 }