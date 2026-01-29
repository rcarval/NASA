public with sharing class Demo_HelloInvocable {

    /**
     * Entrada usada por Flujos
     */
    public class HelloRequest {
        @InvocableVariable(required=true)
        public String name;
    }

    /**
     * Salida usada por Flujos
     */
    public class HelloResponse {
        @InvocableVariable
        public String message;

        public HelloResponse(String msg) {
            this.message = msg;
        }
    }

    /**
     * Método invocable para usar en Flow.
     * Retorna un saludo tipo: "Hola Carlos"
     */
    @InvocableMethod(
        label='Generar saludo'
        description='Retorna un mensaje de saludo usando el nombre recibido.'
    )
    public static List<HelloResponse> sayHello(List<HelloRequest> requests) {
        List<HelloResponse> responses = new List<HelloResponse>();

        for (HelloRequest req : requests) {
            String safeName = String.isBlank(req.name) ? 'Invitado' : req.name;
            responses.add(new HelloResponse('Hola ' + safeName));
        }

        return responses;
    }
}