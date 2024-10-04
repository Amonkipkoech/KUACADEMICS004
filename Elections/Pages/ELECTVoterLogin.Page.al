page 60022 "ELECT-Voter Login"
{
    PageType = Card;
    SourceTable = 60000;
    SourceTableView = WHERE("Is Active" = FILTER(true));

    layout
    {
        area(content)
        {
            grid(General)
            {
                field(StudNo; UserNames)
                {
                    Caption = 'Student No.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Election Code" = '' THEN BEGIN
                            ERROR('There is no active election in the Filter');
                            CurrPage.CLOSE;
                        END;
                    end;
                }
                field(Password; Passwords)
                {
                    Caption = 'Ballot ID';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        UserNames: Code[20];
        Passwords: Text[20];
}

