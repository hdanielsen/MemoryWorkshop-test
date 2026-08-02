block-level on error undo, throw.

class TestGetShipTo inherits TestGet:

    constructor public TestGetShipTo( ):
        super("shipTos").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
