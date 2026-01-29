/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para la creación de itinerarios masivos
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     31-08-2021   EFR      Creación de la Clase.
***********************************************************************************/
public class NAV_ProgramadorItinerarios {
    public List<Mantenedor_Nave__c> naves { get; set; }
    public List<Mantenedor_Ruta__c> rutas { get; set; }
    public List<String> tipos { get; set; }
    public String json { get; set; }
    public NAV_ProgramadorItinerarios(){
        naves = [SELECT Id, Name FROM Mantenedor_Nave__c];
        rutas = [SELECT Id, Name FROM Mantenedor_Ruta__c];
        tipos = new List<String>();
        Schema.DescribeFieldResult tipoField = Programacion_de_Itinerario__c.Tipo__c.getDescribe();
        List<Schema.PicklistEntry> listaTipo = tipoField.getPicklistValues();
        for( Schema.PicklistEntry lT : listaTipo){
            tipos.add(lT.getLabel());
        }
    }
    public PageReference agregarItinerario(){
        List<Programacion_de_Itinerario__c> itinerarios = new List<Programacion_de_Itinerario__c>();
        String diasOriginal = ApexPages.currentPage().getParameters().get('dias');
        diasOriginal = diasOriginal.replaceAll('\\[','');
        diasOriginal = diasOriginal.replaceAll('\\]','');
        String[] diasParam = diasOriginal.split(',');
        String[] desdeParam = ApexPages.currentPage().getParameters().get('desde').split('/');
        String[] hastaParam = ApexPages.currentPage().getParameters().get('hasta').split('/');
        List<Integer> horas = new List<Integer>();
        List<Integer> minutos = new List<Integer>();
        String horaParamLu = ApexPages.currentPage().getParameters().get('horaLu');
        horas.add(Integer.valueOf(horaParamLu));
        String minutosParamLu = ApexPages.currentPage().getParameters().get('minutosLu');
        minutos.add(Integer.valueOf(minutosParamLu));
        String horaParamMa = ApexPages.currentPage().getParameters().get('horaMa');
        horas.add(Integer.valueOf(horaParamMa));
        String minutosParamMa = ApexPages.currentPage().getParameters().get('minutosMa');
        minutos.add(Integer.valueOf(minutosParamMa));
        String horaParamMi = ApexPages.currentPage().getParameters().get('horaMi');
        horas.add(Integer.valueOf(horaParamMi));
        String minutosParamMi = ApexPages.currentPage().getParameters().get('minutosMi');
        minutos.add(Integer.valueOf(minutosParamMi));
        String horaParamJu = ApexPages.currentPage().getParameters().get('horaJu');
        horas.add(Integer.valueOf(horaParamJu));
        String minutosParamJu = ApexPages.currentPage().getParameters().get('minutosJu');
        minutos.add(Integer.valueOf(minutosParamJu));
        String horaParamVi = ApexPages.currentPage().getParameters().get('horaVi');
        horas.add(Integer.valueOf(horaParamVi));
        String minutosParamVi = ApexPages.currentPage().getParameters().get('minutosVi');
        minutos.add(Integer.valueOf(minutosParamVi));
        String horaParamSa = ApexPages.currentPage().getParameters().get('horaSa');
        horas.add(Integer.valueOf(horaParamSa));
        String minutosParamSa = ApexPages.currentPage().getParameters().get('minutosSa');
        minutos.add(Integer.valueOf(minutosParamSa));
        String horaParamDo = ApexPages.currentPage().getParameters().get('horaDo');
        horas.add(Integer.valueOf(horaParamDo));
        String minutosParamDo = ApexPages.currentPage().getParameters().get('minutosDo');
        minutos.add(Integer.valueOf(minutosParamDo));
        horas.sort();
        minutos.sort();
        Integer horaMin = horas.get(0);
        Integer horaMax = horas.get(horas.size()-1);
        Integer minutosMin = minutos.get(0);
        Integer minutosMax = minutos.get(minutos.size()-1);
        String rutaParam = ApexPages.currentPage().getParameters().get('ruta');
        String naveParam = ApexPages.currentPage().getParameters().get('nave');
        String tipoLu = ApexPages.currentPage().getParameters().get('tipoLu');
        String tipoMa = ApexPages.currentPage().getParameters().get('tipoMa');
        String tipoMi = ApexPages.currentPage().getParameters().get('tipoMi');
        String tipoJu = ApexPages.currentPage().getParameters().get('tipoJu');
        String tipoVi = ApexPages.currentPage().getParameters().get('tipoVi');
        String tipoSa = ApexPages.currentPage().getParameters().get('tipoSa');
        String tipoDo = ApexPages.currentPage().getParameters().get('tipoDo');
        System.debug('Parametros: ');
        System.debug(diasParam);
        System.debug(desdeParam);
        System.debug(hastaParam);
        System.debug(rutaParam);
        System.debug(naveParam);
        System.debug('End Parametros');
        Boolean canalWeb = ApexPages.currentPage().getParameters().get('web')=='1'?true:false;
        Integer diasEntreFechas = 0;

        Datetime desde = Datetime.newInstance(Integer.valueOf(desdeParam[2]), Integer.valueOf(desdeParam[1]), Integer.valueOf(desdeParam[0]), horaMin, minutosMin, Integer.valueOf(0));
        Date desdeFecha = desde.date();
        Datetime hasta = Datetime.newInstance(Integer.valueOf(hastaParam[2]), Integer.valueOf(hastaParam[1]), Integer.valueOf(hastaParam[0])+1, Integer.valueOf(23), Integer.valueOf(59), Integer.valueOf(59));
        Date hastaFecha = hasta.date();
        diasEntreFechas = desdeFecha.daysBetween(hastaFecha);
        Date monday = Date.newInstance(1900, 1, 1);
        Datetime desdeDia;
        Datetime hastaDia;
        Datetime desdeRealMovimiento;
        Date desdeRealMovimientoFecha;
        String tipoReal;
        for(Integer i=0;i<diasEntreFechas;i++){
            Datetime desdeMovimiento = desde.addDays(i);
            Date desdeMovimientoFecha = desdeMovimiento.date();
            Integer diaFecha = Math.mod(monday.daysBetween(desdeMovimientoFecha), 7);
            for(String dP : diasParam){
                if(Integer.valueOf(dP) == diaFecha){
                    switch on diaFecha{
                        when 0{
                            desdeDia = Datetime.newInstance(Integer.valueOf(desdeParam[2]), Integer.valueOf(desdeParam[1]), Integer.valueOf(desdeParam[0]), Integer.valueOf(horaParamLu), Integer.valueOf(minutosParamLu), Integer.valueOf(0));
                            hastaDia = Datetime.newInstance(Integer.valueOf(hastaParam[2]), Integer.valueOf(hastaParam[1]), Integer.valueOf(hastaParam[0])+1, Integer.valueOf(23), Integer.valueOf(59), Integer.valueOf(59));
                            desdeRealMovimiento = desdeDia.addDays(i);
                            tipoReal = tipoLu;
                        }
                        when 1{
                            desdeDia = Datetime.newInstance(Integer.valueOf(desdeParam[2]), Integer.valueOf(desdeParam[1]), Integer.valueOf(desdeParam[0]), Integer.valueOf(horaParamMa), Integer.valueOf(minutosParamMa), Integer.valueOf(0));
                            hastaDia = Datetime.newInstance(Integer.valueOf(hastaParam[2]), Integer.valueOf(hastaParam[1]), Integer.valueOf(hastaParam[0])+1, Integer.valueOf(23), Integer.valueOf(59), Integer.valueOf(59));
                            desdeRealMovimiento = desdeDia.addDays(i);
                            tipoReal = tipoMa;
                        }
                        when 2{
                            desdeDia = Datetime.newInstance(Integer.valueOf(desdeParam[2]), Integer.valueOf(desdeParam[1]), Integer.valueOf(desdeParam[0]), Integer.valueOf(horaParamMi), Integer.valueOf(minutosParamMi), Integer.valueOf(0));
                            hastaDia = Datetime.newInstance(Integer.valueOf(hastaParam[2]), Integer.valueOf(hastaParam[1]), Integer.valueOf(hastaParam[0])+1, Integer.valueOf(23), Integer.valueOf(59), Integer.valueOf(59));
                            desdeRealMovimiento = desdeDia.addDays(i);
                            tipoReal = tipoMi;
                        }
                        when 3{
                            desdeDia = Datetime.newInstance(Integer.valueOf(desdeParam[2]), Integer.valueOf(desdeParam[1]), Integer.valueOf(desdeParam[0]), Integer.valueOf(horaParamJu), Integer.valueOf(minutosParamJu), Integer.valueOf(0));
                            hastaDia = Datetime.newInstance(Integer.valueOf(hastaParam[2]), Integer.valueOf(hastaParam[1]), Integer.valueOf(hastaParam[0])+1, Integer.valueOf(23), Integer.valueOf(59), Integer.valueOf(59));
                            desdeRealMovimiento = desdeDia.addDays(i);
                            tipoReal = tipoJu;
                        }
                        when 4{
                            desdeDia = Datetime.newInstance(Integer.valueOf(desdeParam[2]), Integer.valueOf(desdeParam[1]), Integer.valueOf(desdeParam[0]), Integer.valueOf(horaParamVi), Integer.valueOf(minutosParamVi), Integer.valueOf(0));
                            hastaDia = Datetime.newInstance(Integer.valueOf(hastaParam[2]), Integer.valueOf(hastaParam[1]), Integer.valueOf(hastaParam[0])+1, Integer.valueOf(23), Integer.valueOf(59), Integer.valueOf(59));
                            desdeRealMovimiento = desdeDia.addDays(i);
                            tipoReal = tipoVi;
                        }
                        when 5{
                            desdeDia = Datetime.newInstance(Integer.valueOf(desdeParam[2]), Integer.valueOf(desdeParam[1]), Integer.valueOf(desdeParam[0]), Integer.valueOf(horaParamSa), Integer.valueOf(minutosParamSa), Integer.valueOf(0));
                            hastaDia = Datetime.newInstance(Integer.valueOf(hastaParam[2]), Integer.valueOf(hastaParam[1]), Integer.valueOf(hastaParam[0])+1, Integer.valueOf(23), Integer.valueOf(59), Integer.valueOf(59));
                            desdeRealMovimiento = desdeDia.addDays(i);
                            tipoReal = tipoSa;
                        }
                        when 6{
                            desdeDia = Datetime.newInstance(Integer.valueOf(desdeParam[2]), Integer.valueOf(desdeParam[1]), Integer.valueOf(desdeParam[0]), Integer.valueOf(horaParamDo), Integer.valueOf(minutosParamDo), Integer.valueOf(0));
                            hastaDia = Datetime.newInstance(Integer.valueOf(hastaParam[2]), Integer.valueOf(hastaParam[1]), Integer.valueOf(hastaParam[0])+1, Integer.valueOf(23), Integer.valueOf(59), Integer.valueOf(59));
                            desdeRealMovimiento = desdeDia.addDays(i);
                            tipoReal = tipoDo;
                        }
                    }
                    Programacion_de_Itinerario__c pI = new Programacion_de_Itinerario__c();
                    pI.Fecha_de_Viaje__c = desdeRealMovimiento;
                    pI.Nombre_Ruta__c = rutaParam;
                    pI.Nombre_de_la_Nave__c = naveParam;
                    pI.Tipo__c = tipoReal;
                    pI.Estado__c = 'En programación';
                    pI.Canal_Web__c = canalWeb;
                    pI.Descuento_Temporalidad_Ocupacion__c = 'No';
                    itinerarios.add(pI);
                }
            }
        }
        if(itinerarios != null){
            insert itinerarios;
            json = '{"success":"true", "creados":'+itinerarios.size()+'}';
        }else{
            json = '{"success":"false"}';
        }
        return null;
    }
}