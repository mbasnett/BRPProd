({
   
    refreshComponent: function(component, event, helper) {
       var lwcComponent=component.find('lwcSubdivisionExplorer');
       lwcComponent.refreshData();
    }
})