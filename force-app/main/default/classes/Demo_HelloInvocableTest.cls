@IsTest
private class Demo_HelloInvocableTest {

    @IsTest
    static void testSayHello() {

        // Arrange
        Demo_HelloInvocable.HelloRequest input = new Demo_HelloInvocable.HelloRequest();
        input.name = 'Carlos';

        List<Demo_HelloInvocable.HelloRequest> inputs =
            new List<Demo_HelloInvocable.HelloRequest>{ input };

        // Act
        List<Demo_HelloInvocable.HelloResponse> outputs =
            Demo_HelloInvocable.sayHello(inputs);

        // Assert
        System.assertEquals(1, outputs.size());
        System.assertEquals('Hola Carlos', outputs[0].message);
    }

    @IsTest
    static void testSayHelloBlankName() {

        // Arrange
        Demo_HelloInvocable.HelloRequest input = new Demo_HelloInvocable.HelloRequest();
        input.name = '';

        List<Demo_HelloInvocable.HelloRequest> inputs =
            new List<Demo_HelloInvocable.HelloRequest>{ input };

        // Act
        List<Demo_HelloInvocable.HelloResponse> outputs =
            Demo_HelloInvocable.sayHello(inputs);

        // Assert
        System.assertEquals('Hola Invitado', outputs[0].message);
    }
}