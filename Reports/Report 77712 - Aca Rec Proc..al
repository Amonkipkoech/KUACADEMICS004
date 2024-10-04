report 77712 "Aca Rec Proc."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {

            trigger OnAfterGetRecord()
            begin
                CLEAR(YearOfAdmin);
                IF STRLEN("ACA-Course Registration"."Student No.") > 1 THEN BEGIN
                    IF EVALUATE(YearOfAdmin, COPYSTR("ACA-Course Registration"."Student No.", STRLEN("ACA-Course Registration"."Student No.") - 1, 2)) THEN
                        "ACA-Course Registration"."Year of Admission" := YearOfAdmin;
                    "ACA-Course Registration".MODIFY;
                END;
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
        }
    }

    labels
    {
    }

    var
        YearOfAdmin: Integer;
}

