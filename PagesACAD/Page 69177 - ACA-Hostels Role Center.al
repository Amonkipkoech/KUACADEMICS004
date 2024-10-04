/// <summary>
/// Page ACA-Hostels Role Center (ID 69177).
/// </summary>
page 69177 "ACA-Hostels Role Center"
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
                part(Hostels; "ACA-Hostel List")
#pragma warning restore AL0269
                {
                    Caption = 'Hostels';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Hostel Status Summary Report")
            {
                Caption = 'Hostel Status Summary Report';
                Image = Status;
               
                
                
                RunObject = Report 51135;
                ApplicationArea = All;
            }
            action("AlloCation Analysis")
            {
                Caption = 'AlloCation Analysis';
                Image = Interaction;
               
                
                RunObject = Report 61833;
                ApplicationArea = All;
            }
            action("Incidents Report")
            {
                Caption = 'Incidents Report';
                Image = Register;
               
                
                
                RunObject = Report 61832;
                ApplicationArea = All;
            }
            action("Hostel Allocations")
            {
                Caption = 'Hostel Allocations';
                Image = Allocations;
               
                
                
                RunObject = Report 51136;
                ApplicationArea = All;
            }
            action("Detailled Allocations")
            {
                Caption = 'Detailled Allocations';
                Image = AllocatedCapacity;
               
                
                
                RunObject = Report 51137;
                ApplicationArea = All;
            }
            action("Room Status")
            {
                Caption = 'Room Status';
                Image = Status;
               
                
                
                RunObject = Report 51321;
                ApplicationArea = All;
            }
            action("Allocations List")
            {
                Caption = 'Allocations List';
                Image = Allocate;
               
                
                
                RunObject = Report 51791;
                ApplicationArea = All;
            }
            action("Hostels Collection Report")
            {
                Image = "Report";
                RunObject = Report 60017;
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            group(Cafeteria_Reports)
            {
                Caption = 'Cafe` Reports';
                /*action("Receipts Register")
                {
                    Caption = 'Receipts Register';
                    Image = Report2;
                   
                    
                    RunObject = Report 61900;
                }
                action("Daily Summary Saless")
                {
                    Caption = 'Daily Summary Saless';
                    Image = Report2;
                   
                    
                    RunObject = Report 51815;
                }
                 action("Daily Sales Summary")
                {
                    Caption = 'Daily Sales Summary';
                    Image = Report2;
                   
                    
                    RunObject = Report 51814; 
            }*/
                action("Cafe Revenue Report")
                {
                    Caption = 'Cafe Revenue Report';
                    Image = Report2;
                   
                    
                    RunObject = Report 51813;
                    ApplicationArea = All;
                }
                /* action("Sales Summary")
                {
                    Caption = 'Sales Summary';
                    Image = Report2;
                   
                    
                    RunObject = Report 51811;
                } */
                action("Cafe` Menu")
                {
                    Caption = 'Cafe` Menu';
                    Image = Report2;
                   
                    
                    RunObject = Report 51809;
                    ApplicationArea = All;
                }
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
                    action("Norminal Roll")
                    {
                        Caption = 'Norminal Roll';
                        Image = Report2;
                        RunObject = Report 51765;
                        ApplicationArea = All;
                    }
                    action("Class List (By Stage)")
                    {
                        Caption = 'Class List (By Stage)';
                        Image = List;
                       
                        
                        RunObject = Report 51767;
                        ApplicationArea = All;
                    }
                    action("Signed Norminal Roll")
                    {
                        Caption = 'Signed Norminal Roll';
                        Image = Report2;
                       
                        RunObject = Report 51134;
                        ApplicationArea = All;
                    }
                }
            }
        }
        area(sections)
        {
            group("Hostel Management")
            {
                Caption = 'Hostel Management';
                Image = FixedAssets;
                action(HostelsList)
                {
                    Caption = 'Hostels';
                    Image = Register;
                   
                   
                    
                    RunObject = Page 68242;
                    ApplicationArea = All;
                }
                action(Allocations)
                {
                    Caption = 'Hostel Allocations';
                    Image = Registered;
                   
                   
                    
                    RunObject = Page 69169;
                    ApplicationArea = All;
                }
                action("Hostel Bookings (Unallocated)")
                {
                    Caption = 'Hostel Bookings (Unallocated)';
                    RunObject = Page 68934;
                    ApplicationArea = All;
                }
                action("Posted Allocations")
                {
                    Caption = 'Posted Allocations';
                    Image = Aging;
                   
                    RunObject = Page 69170;
                    ApplicationArea = All;
                }
                action("Student Information")
                {
                    Caption = 'Student Information';
                    RunObject = Page 69171;
                    ApplicationArea = All;
                }
                action("Hostel Billing")
                {
                    Caption = 'Hostel Billing';
                    Image = Invoice;
                   
                    RunObject = Page 68835;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Setups)
            {
                Caption = 'Hostel Setups';
                Image = Setup;
                action("Hostels List")
                {
                    Caption = 'Hostels List';
                    RunObject = Page 68242;
                    ApplicationArea = All;
                }
                action("Inventory Items")
                {
                    Caption = 'Inventory Items';
                    Image = InventorySetup;
                   
                    
                    RunObject = Page 68935;
                    ApplicationArea = All;
                }
            }
            group(hist)
            {
                Caption = 'Hostel History';
                Image = History;
                action("Allocation (Uncleared)")
                {
                    Caption = 'Allocation (Uncleared)';
                    RunObject = Page 69095;
                    ApplicationArea = All;
                }
                action("Allocation History (Cleared)")
                {
                    Caption = 'Allocation History (Cleared)';
                    Image = Invoice;
                   
                    RunObject = Page 69096;
                    ApplicationArea = All;
                }
                action("Historical Allocations")
                {
                    Caption = 'Historical Allocations';
                    Image = History;
                   
                    RunObject = Page 69307;
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
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Students Card")
                {
                    Image = Registered;
                   
                   
                    
                    RunObject = Page 68837;
                    ApplicationArea = All;
                }
                action(Programmes)
                {
                    Caption = 'Programmes';
                    RunObject = Page 68757;
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Signing of Norminal Role")
                {
                    Caption = 'Signing of Norminal Role';
                    RunObject = Page 68238;
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Class Allocations")
                {
                    Image = Allocate;
                    RunObject = Page 68417;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            /* group(CafeMan)
            {
                Caption = 'Cafe` Management';
                Visible = false;
                action("Sales Receipts (New)")
                {
                    Caption = 'Sales Receipts (New)';
                    RunObject = Page 69087;
                }
                action("Receipts (Unprinted)")
                {
                    Caption = 'Receipts (Unprinted)';
                    RunObject = Page 69090;
                }
                action("Receipts (UnPosted)")
                {
                    Caption = 'Receipts (UnPosted)';
                    RunObject = Page 69091;
                }
                action("Receipts (Cancelled)")
                {
                    Caption = 'Receipts (Cancelled)';
                    RunObject = Page 69092;
                }
                action("Receipts (Posted)")
                {
                    Caption = 'Receipts (Posted)';
                    RunObject = Page 69093;
                }
                action("Meals List")
                {
                    Caption = 'Meals List';
                    RunObject = Page 69074;
                }
                action("Meals Inventory")
                {
                    Caption = 'Meals Inventory';
                    RunObject = Page 69078;
                }
            } */
            /* group(CafeSetups)
            {
                Caption = 'Cafe` Setups';
                Visible = false;
                action("Sales Sections")
                {
                    Caption = 'Sales Sections';
                    Image = SelectEntries;
                   
                    
                    RunObject = Page 68299;
                }
                action("Cafe` Staff")
                {
                    Caption = 'Cafe` Staff';
                    RunObject = Page 68307;
                }
                action("Meals Setup")
                {
                    Caption = 'Meals Setup';
                    RunObject = Page 69074;
                }
                action("General Setup")
                {
                    Caption = 'General Setup';
                    RunObject = Page 69076;
                }
                action("Meals Inventory")
                {
                    Caption = 'Meals Inventory';
                    RunObject = Page 69078;
                }
                action("Staff Setup")
                {
                    Caption = 'Staff Setup';
                    RunObject = Page 69082;
                }
            } */
            /* group("Catering Management")
            {
                Caption = 'Catering Management';
                Visible = false;
                action("Procurement Plan")
                {
                    Caption = 'Procurement Plan';
                    RunObject = Page 68120;
                }
                action("Store Requisitions")
                {
                    Caption = 'Store Requisitions';
                    RunObject = Page 68218;
                }
                action("Purchase Requisitions")
                {
                    Caption = 'Purchase Requisitions';
                    RunObject = Page 69400;
                }
                separator(History)
                {
                    Caption = 'History';
                }
                action("Approved Store Reqiositions")
                {
                    Caption = 'Approved Store Reqiositions';
                    RunObject = Page 68608;
                }
                action("Posted Store Requisitions")
                {
                    Caption = 'Posted Store Requisitions';
                    RunObject = Page 68421;
                }
            }
 */
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

