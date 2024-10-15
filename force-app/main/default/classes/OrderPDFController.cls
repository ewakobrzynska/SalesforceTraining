public class OrderPDFController {
    
    @InvocableMethod
    public static void generateAndAttachPDF(List<Id> orderIds) {
        List<Attachment> attachmentsToInsert = new List<Attachment>();
        List<Attachment> attachmentsToDelete = new List<Attachment>();
        for (Id orderId : orderIds) {
            Order order = [SELECT Id, OrderNumber, Status, Signature__c,
                                  (SELECT Id, Product2.Name, Quantity, UnitPrice, TotalPrice 
                                   FROM OrderItems)
                           FROM Order 
                           WHERE Id = :orderId LIMIT 1];
                        
            if (order.Status == 'Activated' || order.Status == 'Signed') {
                List<Attachment> existingAttachments = [SELECT Id FROM Attachment 
                                                        WHERE ParentId = :order.Id 
                                                        AND Name LIKE :order.OrderNumber + '_OrderDetails.pdf'];
                
                if (!existingAttachments.isEmpty()) {
                    attachmentsToDelete.addAll(existingAttachments);
                }
                
                PageReference pdfPage = Page.OrderPDF;
                pdfPage.getParameters().put('id', order.Id);
                Blob pdfBlob = pdfPage.getContentAsPDF();
                
                Attachment attachment = new Attachment();
                attachment.ParentId = order.Id;
                attachment.Name = order.OrderNumber + '_OrderDetails.pdf';
                attachment.Body = pdfBlob;
                attachment.ContentType = 'application/pdf';
                
                attachmentsToInsert.add(attachment);
            }
            update order;
        }
        
        if (!attachmentsToDelete.isEmpty()) {
            delete attachmentsToDelete;
        }
        
        if (!attachmentsToInsert.isEmpty()) {
            insert attachmentsToInsert;
        }
    }
}