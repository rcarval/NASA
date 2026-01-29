public class NAV_ReservaEstandar{
    public NAV_ReservaEstandar(ApexPages.StandardController controller){
        urlRedirection();
    }
    public PageReference urlRedirection() {
          PageReference page = Page.NAV_Reservas;
          page.setRedirect(true);
          return page;
    }
}