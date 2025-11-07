public with sharing class UserExportLastLoginDate {
    @InvocableMethod(label='Exportar usuarios -> Ultimo inicio de sesión menor a 30 dias' description='Exportar usuarios -> Ultimo inicio de sesión menor a 30 dias')
    public static void exportUsersWithRecentLogin() {
        // Obtener la fecha actual menos 90 días
        //Date cutoffDate = Date.today().addDays(-190);
        
        // Consultar los usuarios cuyo último inicio de sesión es menor a 30 días
        //List<User> users = [SELECT Id, Name, LastLoginDate, Email FROM User WHERE LastLoginDate >= :cutoffDate];
        List<User> users = [SELECT Id, Name, LastLoginDate, IsActive FROM User WHERE LastLoginDate < LAST_N_DAYS:30 AND IsActive = True ORDER BY LastLoginDate ASC];
        
        // Crear una lista de cadenas para almacenar los datos del usuario
        List<String> csvData = new List<String>();
        
        
        // Agregar encabezados de columna al archivo CSV
        String[] headers = new String[] {'Last Login Date','Name','Activo'};
        csvData.add(String.join(headers, ';'));

    
        
        // Recorrer los usuarios y agregar sus datos al archivo CSV
        for (User user : users) {
            String userData = user.LastLoginDate + ';' + user.Name + ';' + user.IsActive;
            csvData.add(userData);           
        }
        
        // Crear un archivo CSV e ingresar los datos obtenidos
        String csvContent = String.join(csvData, '\n');
        Blob csvBlob = Blob.valueOf(csvContent);
        String fileName = 'Usuarios inactivos.csv';
        ContentVersion contentVersion = new ContentVersion(
            Title = fileName,
            PathOnClient = fileName,
            VersionData = csvBlob
            );
            insert contentVersion;
            
            // Obtener la URL de descarga del archivo CSV
            String downloadUrl = URL.getSalesforceBaseUrl().toExternalForm() + '/sfc/servlet.shepherd/version/download/' + contentVersion.Id;
            
            System.debug('Usuarios exportados con éxito. Descarga el archivo CSV en: ' + downloadUrl);
    }
}