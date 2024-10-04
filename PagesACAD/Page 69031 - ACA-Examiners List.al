page 69031 "ACA-Examiners List"
{
    CardPageID = "ACA-Examiners";
    PageType = List;
    SourceTable = "ACA-Lecturers/Examiners";

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Residential Address"; Rec."Residential Address")
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
                field("Home Phone Number"; Rec."Home Phone Number")
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
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
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
                field("Country Code"; Rec."Country Code")
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
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Known As"; Rec."Known As")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                }
                field("Date of Join"; Rec."Date of Join")
                {
                    ApplicationArea = All;
                }
                field("Length of Service"; Rec."Length of Service")
                {
                    ApplicationArea = All;
                }
                field("Date of Leaving"; Rec."Date of Leaving")
                {
                    ApplicationArea = All;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = All;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = All;
                }
                field("PayRoll No."; Rec."PayRoll No.")
                {
                    ApplicationArea = All;
                }
                field("HELB No."; Rec."HELB No.")
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field("FullTime/Part Time"; Rec."FullTime/Part Time")
                {
                    ApplicationArea = All;
                }
                field(PayPeriod; Rec.PayPeriod)
                {
                    ApplicationArea = All;
                }
                field(AmountDue; Rec.AmountDue)
                {
                    ApplicationArea = All;
                }
                field(StatusofPayment; Rec.StatusofPayment)
                {
                    ApplicationArea = All;
                }
                field(DateofPayment; Rec.DateofPayment)
                {
                    ApplicationArea = All;
                }
                field("PayRoll No"; Rec."PayRoll No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Examiner Units")
            {
                Caption = 'Examiner Units';
                Image = List;
                Promoted = true;
                RunObject = Page 69032;
                RunPageLink = No = FIELD("No.");
                ApplicationArea = All;
            }
            action("Examiner Qualifications")
            {
                Caption = 'Examiner Qualifications';
                Image = ListPage;
                Promoted = true;
                RunObject = Page "ACA-Examiners Qualification";
                RunPageLink = Code = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }
}

