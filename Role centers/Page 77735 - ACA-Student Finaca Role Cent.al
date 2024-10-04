/// <summary>
/// Page ACA-Student Fin/aca Role Cent (ID 77735).
/// </summary>
page 77735 "ACA-Student Fin/aca Role Cent"
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
                part("StudentBilling"; "ACA-Std Billing List")
#pragma warning restore AL0269
                {
                    Caption = 'Student Billing';
                    Visible = true;
                    ApplicationArea = All;
                }
#pragma warning disable AL0269
                part("Bank Account"; "Bank Account List")
#pragma warning restore AL0269
                {
                    Caption = 'Bank Account';
                    ApplicationArea = All;
                }
                /* part("OfficialReceipt"; 68207)
                {
                    Caption = 'Official Receipt';
                } */
                part(acaCharge; "ACA-Charge")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Receipts")
            {
                Caption = 'Import Receipts';
                Image = ImportExport;
                ApplicationArea = All;
                // RunObject = XMLport 50019;
            }
            action("Import Receipts Buffer")
            {
                Caption = 'Import Receipts Buffer';
                Image = Bins;
                RunObject = Page 68789;
                ApplicationArea = All;
            }
            action("Posted Receipts Buffer")
            {
                Caption = 'Posted Receipts Buffer';
                Image = PostedReceipt;

                RunObject = Page 68790;
                ApplicationArea = All;
            }
            action("Close Current Semester")
            {
                Caption = 'Close Current Semester';
                Image = Report;
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
            action("Genereal Setup")
            {
                Caption = 'Genereal Setup';
                Image = GeneralPostingSetup;

                RunObject = Page 68760;
                ApplicationArea = All;
            }
            action("General journal")
            {
                Caption = 'General journal';
                Image = Journal;
                RunObject = Page 39;
                ApplicationArea = All;
            }
            action("OfficialReceipt")
            {
                Caption = 'Official Receipt';
                ApplicationArea = All;
                // RunObject = Page 68207;
            }
            action(Programme)
            {
                Caption = 'Programmes';
                Image = List;

                RunObject = Page 68757;
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action(Customer)
            {
                Caption = 'Customers';
                Image = Customer;

                RunObject = Page 22;
                ApplicationArea = All;
            }
            action("Student Billing")
            {
                Caption = 'Student Billing';
                Image = "Order";

                RunObject = Page 68835;
                ApplicationArea = All;
            }
            action("Official Receipt")
            {
                Caption = 'Official Receipt';
                ApplicationArea = All;
                //RunObject = Page 68207;
            }
            action("Settlement Types")
            {
                Caption = 'Settlement Types';
                RunObject = Page 68747;
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            group("Reports And Analysis")
            {
                Caption = 'Reports And Analysis';
                Image = Journals;
                action("Fee Structure")
                {
                    Caption = 'Fee Structure';
                    Image = Balance;
                    RunObject = Report 51202;
                    ApplicationArea = All;
                }
                action("Proforma Invoices")
                {
                    Caption = 'Proforma Invoices';
                    Image = PrintVoucher;
                    RunObject = Report 51015;
                    ApplicationArea = All;
                }
                action("Student Statements")
                {
                    Caption = 'Student Statements';
                    Image = Journals;
                    RunObject = Report 51072;
                    ApplicationArea = All;
                }
                action("Payment Journals")
                {
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page 251;
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ApplicationArea = All;
                }
                action("General Journals")
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page 251;
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ApplicationArea = All;
                }
                action("Student Billings Analysis")
                {
                    Caption = 'Student Billings Analysis';
                    Image = Report;
                    RunObject = Report 51542;
                    ApplicationArea = All;
                }
                action("   Student Balances2")
                {
                    Caption = '   Student Balances2';
                    RunObject = Report 70092;
                    ApplicationArea = All;
                }
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page 344;
                ApplicationArea = All;
            }
            action("generaljournal")
            {
                Caption = 'general journal';
                Image = Journal;

                RunObject = Page 39;
                ApplicationArea = All;
            }
            group(Periodic)
            {
                Caption = 'Periodic Reports';
                group(AcadReports2)
                {
                    Caption = 'Academic Reports';
                    Image = AnalysisView;
                    action("All Students")
                    {
                        Image = Report2;
                        RunObject = Report 51466;
                        ApplicationArea = All;
                    }
                    action("Student Applications Report")
                    {
                        Caption = 'Student Applications Report';
                        Image = Report;
                        RunObject = Report 51862;
                        ApplicationArea = All;
                    }
                    action("Norminal Roll")
                    {
                        Caption = 'Norminal Roll';
                        Image = Report2;
                        RunObject = Report 51765;
                        ApplicationArea = All;
                    }
                    action(" List (By Stage)")
                    {
                        Caption = ' List (By Stage)';
                        Image = List;


                        RunObject = Report 77790;
                        ApplicationArea = All;
                    }
                    action("Signed Norminal Roll")
                    {
                        Caption = 'Signed Norminal Roll';
                        Image = Report2;

                        RunObject = Report 51134;
                        ApplicationArea = All;
                    }
                    action("Program List By Gender && Type")
                    {
                        Caption = 'Program List By Gender && Type';
                        Image = PrintReport;


                        RunObject = Report 51780;
                        ApplicationArea = All;
                    }
                    action("population By Faculty")
                    {
                        Caption = 'population By Faculty';
                        Image = PrintExcise;


                        RunObject = Report 51781;
                        ApplicationArea = All;
                    }
                    action("Multiple Record")
                    {
                        Caption = 'Multiple Record';
                        Image = Report2;
                        RunObject = Report 51770;
                        ApplicationArea = All;
                    }
                    action("Classification By Campus")
                    {
                        Caption = 'Classification By Campus';
                        Image = Report2;
                        RunObject = Report 51776;
                        ApplicationArea = All;
                    }
                    action("Population By Campus")
                    {
                        Caption = 'Population By Campus';
                        Image = Report2;
                        RunObject = Report 51777;
                        ApplicationArea = All;
                    }
                    action("Population by Programme")
                    {
                        Caption = 'Population by Programme';
                        Image = Report2;
                        RunObject = Report 51778;
                        ApplicationArea = All;
                    }
                    action("Prog. Category")
                    {
                        Caption = 'Prog. Category';
                        Image = Report2;
                        RunObject = Report 51779;
                        ApplicationArea = All;
                    }
                    action("List By Programme")
                    {
                        Caption = 'List By Programme';
                        Image = Report;
                        RunObject = Report 51766;
                        ApplicationArea = All;
                    }
                    action("List By Programme (With Balances)")
                    {
                        Caption = 'List By Programme (With Balances)';
                        Image = PrintReport;


                        RunObject = Report 51768;
                        ApplicationArea = All;
                    }
                    action("Type. Study Mode, & Gender")
                    {
                        Caption = 'Type. Study Mode, & Gender';
                        Image = Report;
                        RunObject = Report 51785;
                        ApplicationArea = All;
                    }
                    action("Study Mode & Gender")
                    {
                        Caption = 'Study Mode & Gender';
                        Image = Report;
                        RunObject = Report 51786;
                        ApplicationArea = All;
                    }
                    action("County & Gender")
                    {
                        Caption = 'County & Gender';
                        Image = Report;
                        RunObject = Report 51788;
                        ApplicationArea = All;
                    }
                    action("List By County")
                    {
                        Caption = 'List By County';
                        Image = Report;
                        RunObject = Report 51789;
                        ApplicationArea = All;
                    }
                    action("Prog. Units")
                    {
                        Caption = 'Prog. Units';
                        Image = Report;
                        RunObject = Report 51203;
                        ApplicationArea = All;
                    }
                    action("Enrollment By Stage")
                    {
                        Caption = 'Enrollment By Stage';
                        Image = Report2;
                        RunObject = Report 51545;
                        ApplicationArea = All;
                    }
                    action("Import Units")
                    {
                        Caption = 'Import Units';
                        Image = ImportExcel;


                        RunObject = Page 68938;
                        ApplicationArea = All;
                    }
                    action("Hostel Allocations")
                    {
                        Caption = 'Hostel Allocations';
                        Image = PrintCover;


                        RunObject = Report 51719;
                        ApplicationArea = All;
                    }
                    action("Students List (By Program)")
                    {
                        Caption = 'Students List (By Program)';
                        Image = Report;


                        RunObject = Report 51820;
                        ApplicationArea = All;
                    }
                    action("Programme Units")
                    {
                        Caption = 'Programme Units';
                        Image = Report;

                        RunObject = Report 51203;
                        ApplicationArea = All;
                    }
                    action("CUE report")
                    {
                        Caption = 'CUE report';
                        Image = AddAction;
                        RunObject = Report 63905;
                        ApplicationArea = All;
                    }
                }
                group("Before Exams")
                {
                    Caption = 'Before Exams';
                    action("Examination Cards")
                    {
                        Caption = 'Examination Cards';
                        Image = Card;


                        RunObject = Report 51774;
                        ApplicationArea = All;
                    }
                    action("Exam Card Stickers")
                    {
                        Caption = 'Exam Card Stickers';
                        Image = Split;

                        RunObject = Report 51775;
                        ApplicationArea = All;
                    }
                }
                group("Students Finance Reports")
                {
                    Image = Statistics;
                    action("Students Balances")
                    {
                        Image = PrintInstallment;

                        RunObject = Report 51481;
                        ApplicationArea = All;
                    }
                    action("Per Programme Balances")
                    {
                        Image = PrintInstallment;

                        RunObject = Report 51485;
                        ApplicationArea = All;
                    }
                    action("Per Stage Balances")
                    {
                        Image = PrintInstallment;
                        RunObject = Report 51493;
                        ApplicationArea = All;
                    }
                    action("Students Faculty Income Summary")
                    {
                        Image = PrintInstallment;
                        RunObject = Report 51482;
                        ApplicationArea = All;
                    }
                    action("Student Invoices Per Charge")
                    {
                        Caption = 'Student Invoices Per Charge';
                        Image = PrintInstallment;


                        ApplicationArea = All;
                        //  RunObject = Report 51747;
                    }
                    action("Fee Structure Report")
                    {
                        Caption = 'Fee Structure Report';
                        Image = Report;
                        RunObject = Report 51794;
                        ApplicationArea = All;
                    }
                    action("Student Receipts per Charge")
                    {
                        Caption = 'Student Receipts per Charge';
                        Image = PrintReport;


                        RunObject = Report 51748;
                        ApplicationArea = All;
                    }
                }
            }
        }
        area(sections)
        {
            group(Basics)
            {
                Caption = 'Basics';
                action(Programmes)
                {
                    Caption = 'Programmes';
                    Image = List;

                    RunObject = Page 68757;
                    ApplicationArea = All;
                }
                action(Customers)
                {
                    Caption = 'Customers';
                    Image = Customer;

                    RunObject = Page 22;
                    ApplicationArea = All;
                }
                action("StuBilling")
                {
                    Caption = 'Student Billing';
                    Image = "Order";

                    RunObject = Page "ACA-Std Billing List";
                    ApplicationArea = All;
                }
            }
            group("Students Management")
            {
                Caption = 'Students Management';
                Image = ResourcePlanning;
                action(Registration)
                {
                    Image = Register;



                    RunObject = Page 68836;
                    ApplicationArea = All;
                }
                action("Students Card")
                {
                    Image = Registered;



                    RunObject = Page 68837;
                    ApplicationArea = All;
                }
                action(Progr)
                {
                    Caption = 'Programmes';
                    RunObject = Page 68757;
                    ApplicationArea = All;
                }
                action("Signing of Norminal Role")
                {
                    Caption = 'Signing of Norminal Role';
                    RunObject = Page 68238;
                    ApplicationArea = All;
                }
                action("Class Allocations")
                {
                    Image = Allocate;
                    RunObject = Page 68417;
                    ApplicationArea = All;
                }
                action("ACA-Students Transfer")
                {
                    RunObject = Page "ACA-Students Transfer";
                    ApplicationArea = All;
                }
            }
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
            /* group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    RunObject = Page 68218;
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    RunObject = Page 68125;
                }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page 68107;
                }
                action("My Approved Leaves")
                {
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page 68232;
                }
                action("File Requisitions")
                {
                    Image = Register;
                    
                    RunObject = Page 69183;
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page 69302;
                }
            } */
        }
    }
}

