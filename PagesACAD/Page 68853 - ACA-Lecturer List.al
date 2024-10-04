page 68853 "ACA-Lecturer List"
{
    Caption = 'Lecturer''s list';
    CardPageID = "ACA-Lecturers Units";
    DeleteAllowed = false;
    Editable = true;
    //InsertAllowed = false;
    //ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "HRM-Employee (D)";
    SourceTableView = WHERE(Lecturer = FILTER(true));

    layout
    {
        area(content)
        {
            repeater("Lecturer Details")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Employee Category"; "Employee Category")
                {
                    ApplicationArea = All;
                }
                field("Allowed Workload"; Rec."Allowed Workload")
                {
                    ApplicationArea = ALL;
                }
                field(designation; Rec.designation)
                {
                    ApplicationArea = All;
                }
                field(Initials;
                Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }

                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }

                field(Names; Rec.Names)
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Ext."; Rec."Ext.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = All;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Lecture Loading")
            {
                Caption = 'Lecture Loading';
                action("Lecturer Picture")
                {
                    Caption = 'Lecturer Picture';
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    /* RunObject = Page 68854;
                    RunPageLink = "No." = FIELD("No."); */
                    RunPageOnRec = false;
                    ApplicationArea = All;
                }
                action("Lecturer Units")
                {
                    Caption = 'Lecturer Units';
                    Image = VoidRegister;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "ACA-Lecturer Units Details";
                    RunPageLink = Lecturer = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }
}

