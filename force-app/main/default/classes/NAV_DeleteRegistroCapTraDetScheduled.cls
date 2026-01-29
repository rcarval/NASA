global class NAV_DeleteRegistroCapTraDetScheduled implements Schedulable {
    global void execute(SchedulableContext SC) {
            NAV_DeleteRegistrosCapTramosDet batchInstance = new NAV_DeleteRegistrosCapTramosDet();
            Database.executeBatch(batchInstance,200);
        }

}