global class NAV_DeleteRegistroCapTramoScheduled implements Schedulable {
    global void execute(SchedulableContext SC) {
        NAV_DeleteRegistrosCapacidadTramos batchInstance = new NAV_DeleteRegistrosCapacidadTramos();
        Database.executeBatch(batchInstance,200);
    }
}