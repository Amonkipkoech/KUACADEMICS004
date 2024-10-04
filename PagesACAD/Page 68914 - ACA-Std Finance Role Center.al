/// <summary>
/// Page ACA-Std Finance Role Center (ID 68914).
/// </summary>
page 68914 "ACA-Std Finance Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(general)
            {
#pragma warning disable AL0269
                part("Student Bills"; "ACA-Std Billing List")
#pragma warning restore AL0269
                {
                    Caption = 'Student Bills';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Proforma Invoice")
            {
                Caption = 'Proforma Invoice';
                Image = "Report";
                ApplicationArea = All;
                // RunObject = Report 52017711;
            }
            action("Fee Structure")
            {
                Caption = 'Fee Structure';
                ApplicationArea = All;
                // RunObject = Report 39005907;
            }
            group("Finance reports")
            {
                Caption = 'Finance reports';
                action("Student Balances")
                {
                    Caption = 'Student Balances';
                    RunObject = Report 70092;
                    ApplicationArea = All;
                }
                action("Statement 1")
                {
                    Caption = 'Statement 1';
                    RunObject = Report 116;
                    ApplicationArea = All;
                }
                action("Statement 2")
                {
                    Caption = 'Statement 2';
                    ApplicationArea = All;
                    // RunObject = Report 51751;
                }
                action("Stud. List With Balances")
                {
                    Caption = 'Stud. List With Balances';
                    RunObject = Report 51258;
                    ApplicationArea = All;
                }
                action("Fee Collection")
                {
                    Caption = 'Fee Collection';
                    RunObject = Report 51370;
                    ApplicationArea = All;
                }
                action("Fee Receipt")
                {
                    Caption = 'Fee Receipt';
                    RunObject = Report 51672;
                    ApplicationArea = All;
                }
                action("Student List")
                {
                    Caption = 'Student List';
                    ApplicationArea = All;
                    // RunObject = Report 51392;
                }
            }
            group("Receipts Reports")
            {
                Caption = 'Receipts Reports';
                action("Cashier Transactions")
                {
                    Caption = 'Cashier Transactions';
                    ApplicationArea = All;
                    // RunObject = Report 51633;
                }
                action("Receipt Entries By User")
                {
                    Caption = 'Receipt Entries By User';
                    RunObject = Report 51478;
                    ApplicationArea = All;
                }
            }
        }
        area(embedding)
        {
            action("Student Billing")
            {
                Caption = 'Student Billing';
                Image = UserSetup;
                RunObject = Page 68835;
                ApplicationArea = All;
            }
            action("Missing Balance Imports")
            {
                Caption = 'Missing Balance Imports';
                Image = Migration;
               
                ApplicationArea = All;
                // RunObject = Page 68014;
            }
            action("No. Series")
            {
                Caption = 'No. Series';
                RunObject = Page 456;
                ApplicationArea = All;
            }
            action("Approval Entries")
            {
                Caption = 'Approval Entries';
                RunObject = Page 658;
                ApplicationArea = All;
            }
            action("Approval Request Entries")
            {
                Caption = 'Approval Request Entries';
                RunObject = Page 662;
                ApplicationArea = All;
            }
            action("Reason Codes")
            {
                Caption = 'Reason Codes';
                RunObject = Page 68757;
                ApplicationArea = All;
            }
            action("Students Card")
            {
                Caption = 'Students Card';
                RunObject = Page 68124;
                ApplicationArea = All;
            }
            action("Official Receipts")
            {
                Caption = 'Official Receipts';
                ApplicationArea = All;
                //RunObject = Page 68207;
            }
            action("Official Receipt")
            {
                Caption = 'Official Receipt';
                ApplicationArea = All;
                //  RunObject = Page 68207;
            }
            action("Settlement Types")
            {
                Caption = 'Settlement Types';
                RunObject = Page 68747;
                ApplicationArea = All;
            }


        }
        area(processing)
        {
            group(Setups)
            {
                Caption = 'Setups';
                action("Master Fee Structure")
                {
                    Caption = 'Master Fee Structure';
                    Image = Setup;
                   
                    
                    RunObject = Page 68796;
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Charge Items")
                {
                    Caption = 'Charge Items';
                    Image = Invoice;
                   
                    RunObject = Page 68741;
                    ApplicationArea = All;
                }
                action("GeneralSet-Up")
                {
                    Caption = 'General Set-Up';
                    Image = GeneralPostingSetup;
                   
                    RunObject = Page 68760;
                    ApplicationArea = All;
                }
                action("AcademicYear")
                {
                    Caption = 'Academic Year';
                    Image = Calendar;
                   
                    RunObject = Page 68509;
                    ApplicationArea = All;
                }
                action("General Set-Up")
                {
                    Caption = 'General Set-Up';
                    RunObject = Page 68760;
                    ApplicationArea = All;
                }
                action("Programmes List")
                {
                    Caption = 'Programmes List';
                    RunObject = Page 68757;
                    ApplicationArea = All;
                }
                action("general journal")
                {
                    Caption = 'general journal';
                    Image = Journal;
                    RunObject = Page 39;
                    ApplicationArea = All;
                }
                action("Academic Year")
                {
                    Caption = 'Academic Year';
                    RunObject = Page 68509;
                    ApplicationArea = All;
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                action("Import Receipts")
                {
                    Caption = 'Import Receipts';
                    Image = ImportExport;
                    ApplicationArea = All;
                    //  RunObject = XMLport 50019;
                }
                action("Close CurrentSemester")
                {
                    Caption = 'Close Current Semester';
                    Image = "Report";
                    RunObject = Report 51572;
                    ApplicationArea = All;
                }
                action("Post Batch Billing")
                {
                    Caption = 'Post Batch Billing';
                    Image = Report2;
                   
                    RunObject = Report 51539;
                    ApplicationArea = All;
                }
                action("Import Bank Receipts")
                {
                    Caption = 'Import Bank Receipts';
                    Image = ImportExcel;
                   
                    
                    ApplicationArea = All;
                    // RunObject = XMLport 50019;
                }
                action("Imported Bank Receipts")
                {
                    Caption = 'Imported Bank Receipts';
                    Image = ReceiptLines;
                   
                    
                    RunObject = Page 68789;
                    ApplicationArea = All;
                }
                action("Posted Receipts Buffer")
                {
                    Caption = 'Posted Receipts Buffer';
                    Image = PostedReceipts;
                   
                    
                    RunObject = Page 68790;
                    ApplicationArea = All;
                }
                action("Post Billings (Batch)")
                {
                    Caption = 'Post Billings (Batch)';
                    Image = Post;
                   
                    
                    RunObject = Report 51539;
                    ApplicationArea = All;
                }
                action("Close Current Semester")
                {
                    Caption = 'Close Current Semester';
                    RunObject = Report 51572;
                    ApplicationArea = All;
                }
                action("Incomplete Student Charges")
                {
                    Caption = 'Incomplete Student Charges';
                    RunObject = Report 51677;
                    ApplicationArea = All;
                }
                action("Registered Students")
                {
                    Caption = 'Registered Students';
                    Image = PostingEntries;
                   
                    RunObject = Report 51765;
                    ApplicationArea = All;
                }
            }
        }
        area(sections)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page 658;
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page 662;
                    ApplicationArea = All;
                }
                action("Clearance Requests")
                {
                    Caption = 'Clearance Requests';
                    RunObject = Page 68970;
                    ApplicationArea = All;
                }
            }

        }
    }

    var
        cust: Record Customer;
        process: Dialog;
}

