report 40001 "Assesment Form"
{
    DefaultLayout = RDLC;
    Caption = 'Assessment Card ';
    RDLCLayout = './Reports/SSR/AssessmentCard.rdl';

    dataset
    {
        dataitem(suppReg; "ACA-XY-FORM")
        {
            RequestFilterFields = StudentNo, "Form Id", AcademicYr;
            column(StudentNo; StudentNo)
            {
            }
            column(Form_Id; "Form Id")
            {
            }
            column(AcademicYr; AcademicYr)
            {
            }
            column(UnitCode; UnitCode)
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
            dataitem("XY form Lines"; "XY form Lines")
            {
                DataItemLink = "Form Id" = field("Form Id");
                column(Form_Id_2; "Form Id")
                {

                }
                column(Rotation_Area; "Rotation Area")
                {

                }
                column(Unit___Coverage; "Unit   Coverage")
                {

                }
                column(Duration_Hours; "Duration Hours")
                {

                }
                column(seq; seq)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    seq := seq + 1;
                end;
            }


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