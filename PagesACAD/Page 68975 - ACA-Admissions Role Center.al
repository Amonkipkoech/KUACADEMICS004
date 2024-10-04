/// <summary>
/// Page ACA-Admissions Role Center (ID 68975).
/// </summary>
page 68975 "ACA-Admissions Role Center"
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
                part("Admission Enquiries"; "ACA-Enquiry List")
#pragma warning restore AL0269
                {
                    Caption = 'Admission Enquiries';
                    Visible = true;
                    ApplicationArea = All;
                }
#pragma warning disable AL0269
                part("Application List"; "ACA-Application Form H. list")
#pragma warning restore AL0269
                {
                    Caption = 'Application List';
                    ApplicationArea = All;
                }
#pragma warning disable AL0269
                part(PA; "ACA-Pending Admissions List")
#pragma warning restore AL0269
                {
                    ApplicationArea = All;
                }
            }
            group(notes)
            {
                systempart(mnotes; MyNotes)
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
            group("General Setups")
            {
                Caption = 'Setups';
                action(Programs)
                {
                    Caption = 'Programs';
                    Image = FixedAssets;
                    
                   
                    
                    RunObject = Page 68757;
                    ApplicationArea = All;
                }
                action(Semesters)
                {
                    Image = FixedAssetLedger;
                    
                   
                    RunObject = Page 68744;
                    ApplicationArea = All;
                }
                action("Academic Year")
                {
                    Image = Calendar;
                    
                   
                    RunObject = Page 68510;
                    ApplicationArea = All;
                }
                action("General Setup")
                {
                    Image = SetupLines;
                    
                   
                    RunObject = Page 68760;
                    ApplicationArea = All;
                }
                action("Modes of Study")
                {
                    Image = Category;
                    
                    RunObject = Page 68739;
                    ApplicationArea = All;
                }
                action("Insurance Companies")
                {
                    Image = Insurance;
                    
                    ApplicationArea = All;
                    // RunObject = Page 50051;
                }
                action("Application Setups")
                {
                    Image = SetupList;
                    
                    RunObject = Page 68480;
                    ApplicationArea = All;
                }
                action("Admission Number Setup")
                {
                    Image = SetupColumns;
                    
                   
                    RunObject = Page 68495;
                    ApplicationArea = All;
                }
                action("Admission Subjects")
                {
                    Image = GeneralPostingSetup;
                    
                    RunObject = Page 68472;
                    ApplicationArea = All;
                }
                action("Marketing Strategies")
                {
                    Image = MarketingSetup;
                    
                   // RunObject = Page 50097;
                    ApplicationArea = All;
                }
            }
            group("Application and Admission")
            {
                action("Online Enquiries")
                {
                    Image = NewOrder;
                    
                    
                    RunObject = Page 68292;
                    ApplicationArea = All;
                }
                action("Online Applications")
                {
                    Image = NewCustomer;
                    
                    
                    RunObject = Page 50096;
                    ApplicationArea = All;
                }
                action("Admission Applications")
                {
                    Image = NewCustomer;
                    
                    
                    RunObject = Page 50059;
                    ApplicationArea = All;
                }
                action("Approved Applications")
                {
                    Image = Archive;
                    
                    RunObject = Page 68011;
                    ApplicationArea = All;
                }
                action("Admission Letters")
                {
                    Image = CustomerList;
                    
                    
                    RunObject = Page 68515;
                    ApplicationArea = All;
                }
                action(" multiplestudents")
                {
                    Caption = ' multiplestudents';
                    RunObject = Page 68978;
                    ApplicationArea = All;
                }
                action("New Admissions")
                {
                    Image = NewItem;
                    
                    
                    ApplicationArea = All;
                    //RunObject = Page 68013;
                }
                action("Admitted Applicants")
                {
                    Image = Archive;
                    
                    
                    RunObject = Page 68010;
                    ApplicationArea = All;
                }
            }
            group("Admission Reports")
            {
                action("New Applications")
                {
                    Image = "Report";
                    
                   
                    RunObject = Report 51352;
                    ApplicationArea = All;
                }
                action("Online Applications Report")
                {
                    Image = "Report";
                    
                   
                    ApplicationArea = All;
                    // RunObject = Report 50051;
                }
                action(Enquiries)
                {
                    Image = "Report";
                    
                   
                    ApplicationArea = All;
                    // RunObject = Report 50052;
                }
                action("Marketing Strategies Report")
                {
                    Image = "Report";
                    
                   
                    RunObject = Report 50049;
                    ApplicationArea = All;
                }
                action("Direct Applications")
                {
                    Image = "Report";
                    
                   
                    RunObject = Report 51379;
                    ApplicationArea = All;
                }
                action("Pending Applications")
                {
                    Image = "Report";
                    
                   
                    RunObject = Report 51352;
                    ApplicationArea = All;
                }
                action("Application Summary")
                {
                    Image = "Report";
                    
                   
                    RunObject = Report 51350;
                    ApplicationArea = All;
                }
                action("Applicant Shortlisting (Summary)")
                {
                    Image = "Report";
                    
                   
                    RunObject = Report 51365;
                    ApplicationArea = All;
                }
                action("Applicant Shortlisting (Detailed)")
                {
                    Image = "Report";
                    
                   
                    RunObject = Report 51364;
                    ApplicationArea = All;
                }
            }
        }
        area(embedding)
        {

            action("Academic Year Manager")
            {
                Caption = 'Academic Year Manager';
                Image = Calendar;
                
               
                RunObject = Page 68510;
                ApplicationArea = All;
            }


            action("Applications (Online)")
            {
                Image = NewCustomer;
                
                
                RunObject = Page 68864;
                ApplicationArea = All;
            }
            action("Applications - Direct ")
            {
                Image = NewCustomer;
                
                
                RunObject = Page 68848;
                ApplicationArea = All;
            }
            action("Applicant Admission Letters")
            {
                Image = CustomerList;
                
                
                RunObject = Page 68515;
                ApplicationArea = All;
            }
            action("Admissions (New)")
            {
                Image = NewItem;
                
                
                RunObject = Page 68850;
                ApplicationArea = All;
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
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page 69302;
                }
            } */
        }
    }
}

