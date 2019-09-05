({
    handleActionCompleted: function (component, event, helper) {

        var message = event.getParam('message');
        var messageTitle = event.getParam('messageTitle');

        var auraActions = event.getParam("auraActions");

        var thisHelper = this;

        auraActions.forEach(function (auraAction, index) {
            switch (auraAction) {

                case "ShowSuccessToast":
                    thisHelper.ShowToast(message, messageTitle, "success");
                    break;

                case "ShowWarningToast":
                    thisHelper.ShowToast(message, messageTitle, "warning");
                    break;

                case "ShowErrorToast":
                    thisHelper.ShowToast(message, messageTitle, "error");
                    break;

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


    ShowToast: function (message, messageTitle, type) {

        var toast = $A.get("e.force:showToast");

        messageTitle = messageTitle == undefined ? "NEWSTAR Operation" : messageTitle;

        toast.setParams({
            "title": messageTitle,
            "message": message,
            "type": type === undefined ? "info" : type
        });

        toast.fire();
    },


    refreshView: function () {
        //refresh the view
        $A.get("e.force:refreshView").fire();
    }
})