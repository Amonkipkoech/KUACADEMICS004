report 40003 "master timetable"


{
    DefaultLayout = RDLC;
    Caption = 'Assessment Card ';
    RDLCLayout = './Reports/SSR/TimeTable.rdl';

    dataset
    {
        dataitem("Units Offred Batches"; "Units Offred Batches")
        {
            // RequestFilterFields = "Plan ID";
            column(Academic_Year; "Academic Year")
            {
            }
            column(Semester; Semester)
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
            dataitem("ACA-Units Offered"; "ACA-Units Offered")
            {
                column(Academic_Year_2; "Academic Year")
                {

                }
                // column()
                // {

                // }

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
