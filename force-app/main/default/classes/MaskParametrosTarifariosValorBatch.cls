public with sharing class MaskParametrosTarifariosValorBatch
    implements Database.Batchable<SObject> {

    private Decimal dummyValue;

    public MaskParametrosTarifariosValorBatch(Decimal dummyValue) {
        this.dummyValue = dummyValue;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {

        // Detectar si es sandbox (Staging/UAT/Integra)
        Boolean isSandbox = [
            SELECT IsSandbox 
            FROM Organization
            LIMIT 1
        ].IsSandbox;

        // Si es producción → no hacer nada
        if (!isSandbox) {
            return Database.getQueryLocator(
                'SELECT Id FROM Parametros_Tarifarios_Pasajeros__c WHERE Id = null'
            );
        }

        // En ambientes bajos → traer todos los registros
        return Database.getQueryLocator(
            'SELECT Id FROM Parametros_Tarifarios_Pasajeros__c'
        );
    }

    public void execute(Database.BatchableContext bc,
                        List<Parametros_Tarifarios_Pasajeros__c> scope) {

        for (Parametros_Tarifarios_Pasajeros__c ptp : scope) {
            ptp.Valor__c = dummyValue;   // << Enmascarar por dummy
        }

        if (!scope.isEmpty()) {
            update scope;
        }
    }

    public void finish(Database.BatchableContext bc) {
        // opcional log / mail
    }
}