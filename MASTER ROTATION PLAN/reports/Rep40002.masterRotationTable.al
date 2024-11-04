
report 40002 "master Rotation Table"
{
    DefaultLayout = RDLC;
    Caption = 'Assessment Card ';
    RDLCLayout = './Reports/SSR/MasterRotation.rdl';

    dataset
    {
        dataitem("Master Rotation Table"; "Master Rotation Table")
        {
            RequestFilterFields = "Plan ID";
            column(Plan_ID; "Plan ID")
            {
            }
            column(Category; Category)
            {
            }
            column(info_pic; info.Picture)
            {
            }
            column(info_name; info.Name)
            {
            }
            column(info_phone; info."Phone No.")
            {
            }
            column(info_mail; info."E-Mail")
            {
            }


            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;



        }
    }

    requestpage
    {
        layout
        {

        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnInitReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN BEGIN
            info.CALCFIELDS(Picture);
        END;
    end;



    var
        myInt: Integer;
        seq: Integer;
        info: Record 79;
}
