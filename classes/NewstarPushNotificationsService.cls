public class NewstarPushNotificationsService {

    
    public static void publishNewstarNotificationEvent(String primaryObjectId, String message) {

        Newstar_Notification_Event__e notificationEvent=new Newstar_Notification_Event__e();
        notificationEvent.Primary_Object_Id__c=primaryObjectId;
        notificationEvent.Notification_Message__c=message;

        System.Eventbus.publish(notificationEvent);

    }


    public static void postChatterNofication(String text, Id subjectObjectId, Id mentionUserId) {

        if (!Test.isRunningTest()) {    // ConnectApi methods are not supported in data siloed tests.ApexPages
        
            ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();

            ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
            
            ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
            
            ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();

            messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

            mentionSegmentInput.id = mentionUserId;
            messageBodyInput.messageSegments.add(mentionSegmentInput);

            textSegmentInput.text = text;
            messageBodyInput.messageSegments.add(textSegmentInput);

            feedItemInput.body = messageBodyInput;
            feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
            feedItemInput.subjectId = subjectObjectId;

            ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(
                Network.getNetworkId(), 
                feedItemInput);

        }
    }
}