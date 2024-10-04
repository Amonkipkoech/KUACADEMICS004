page 68752 "ACA-Student Kin"
{
    PageType = List;
    SourceTable = "ACA-Student Kin";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Names; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                    ApplicationArea = All;
                }
                field("Home Tel No"; Rec."Home Tel No")
                {
                    ApplicationArea = All;
                    Caption = 'Mobile No';
                }

                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = All;
                }
                field(Email;Rec.Email)
                {
                    ApplicationArea = All;
                    Caption = 'Email Address';
                }


                field("ID No/Passport No"; Rec."ID No/Passport No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                
            }
        }
    }

    actions
    {
    }
}

