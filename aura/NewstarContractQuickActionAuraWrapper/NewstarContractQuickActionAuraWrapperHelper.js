({
    handleActionCompleted: function (component, event, helper) {

        var message = event.getParam('message');
        var messageTitle=event.getParam('messageTitle');

        var auraActions = event.getParam("auraActions");

        var thisHelper = this;

        auraActions.forEach(function (auraAction, index) {
            switch (auraAction) {

                case "ShowSuccessToast":
                    thisHelper.ShowSuccessToast(message, messageTitle);

                case "CloseQuickAction":
                    thisHelper.closeQuickAction();
                    break;

                case "RefreshView":
                    thisHelper.refreshView();
                    break;

                default:
                    break;
            }
        });


    },


    ShowSuccessToast: function (message, messageTitle) {

        var toast = $A.get("e.force:showToast");

        messageTitle = messageTitle == undefined ? "NEWSTAR Operation" : messageTitle;

        toast.setParams({
            "title": messageTitle,
            "message": message,
            "type": "success"
        });

        toast.fire();
    },


    closeQuickAction: function () {
        //close the action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    },


    refreshView: function () {
        //refresh the view
        $A.get("e.force:refreshView").fire();
    }
})