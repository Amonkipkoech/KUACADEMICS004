page 40018 "Refund Request Card"

{
    PageType = Card;
    SourceTable = "Refund Request";


    layout
    {
        area(Content)
        {
            group("Refund Request Information")
            {
                field("Full Name"; "Full Name") { }
                field("ID No."; "ID No.") { }
                field("Request Amount"; "Request Amount") { }
                field("Reason for Refund"; "Reason for Refund") { }
                field("Student No."; "Student No.") { }
                field("Relationship"; Relationship) { }
                field("Refund Mode"; "Refund Mode") { }
                field("Bank Account No."; "Bank Account No.")
                { //Visible = RefundMode = "Bank"; 
                }
                field("Bank Name"; "Bank Name")
                { //Visible = RefundMode = "Bank";
                }
                field("Bank Branch"; "Bank Branch")
                {// Visible = RefundMode = "Bank"; 
                }
                field("Mobile Money No."; "Mobile Money No.")
                { //Visible = RefundMode = "MPESA"; 
                }
                field("Signature Date"; "Signature Date") { }
            }

            group("Receipt Details")
            {
                field("Receipt Number"; "Receipt Number") { }
                field("Total Amount"; "Total Amount") { }
                field("Net Due for Refund"; "Net Due for Refund") { }
            }

            group("Approval Process")
            {
                field("Staff Name"; "Staff Name") { }
                field("Staff Signature"; "Staff Signature") { }
                field("HOD Comment"; "HOD Comment") { }
                field("HOD Name"; "HOD Name") { }
                field("HOD Signature"; "HOD Signature") { }
                field("Checked By"; "Checked By") { }
                field("Checked Signature"; "Checked Signature") { }
                field("Reviewed By"; "Reviewed By") { }
                field("Reviewed Signature"; "Reviewed Signature") { }
                field("Authorized By"; "Authorized By") { }
                field("Authorized Signature"; "Authorized Signature") { }
            }
        }
    }
}

