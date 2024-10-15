public with sharing class SignatureController {
    private final Order order;

    public SignatureController(ApexPages.StandardController controller) {
        this.order = (Order)controller.getRecord();
    }

    @RemoteAction
    public static void saveSignatureToOrder(Id orderId, String signature) {
        
        List<Attachment> attachmentsToDelete = new List<Attachment>();

        Order order = [SELECT Id, Status FROM Order WHERE Id = :orderId LIMIT 1];
            List<Attachment> existingAttachments = [SELECT Id FROM Attachment 
                                                        WHERE ParentId = :order.Id 
                                                        AND Name LIKE :'Signature_' + orderId + '.png'];
                
            if (!existingAttachments.isEmpty()) {
            	attachmentsToDelete.addAll(existingAttachments);
            }
            Attachment newAttachment = new Attachment();
            newAttachment.ParentId = orderId; 
            newAttachment.ContentType = 'image/png'; 
            newAttachment.Body = EncodingUtil.base64Decode(signature.split(',')[1]); 
            newAttachment.Name = 'Signature_' + orderId + '.png';
            insert newAttachment; 
            
            String base64ImageData = signature.split(',')[1]; 
            String signatureImageHTML = '<img src="data:image/png;base64,' + base64ImageData + '" alt="Signature"/>';
            order.Signature__c = signatureImageHTML;
        	
        
        if (!attachmentsToDelete.isEmpty()) {
            delete attachmentsToDelete;
        }
        update order;
        
    }
}