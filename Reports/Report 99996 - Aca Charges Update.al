report 99996 "Aca Charges Update"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Aca Charges Update.rdl';

    dataset
    {
        dataitem("ACA-Std Charges"; "ACA-Std Charges")
        {

            trigger OnAfterGetRecord()
            begin
                //"ACA-Std Charges".SETRANGE("ACA-Std Charges"."Count trasfer", >0);
                "ACA-Std Charges".SETRANGE("ACA-Std Charges"."New Reg No", '<>%1', '');
                IF "ACA-Std Charges".FIND('-') THEN BEGIN
                    REPEAT
                        //"ACA-Std Charges"."New Admin 2" := "ACA-Std Charges"."New Reg No";
                        "ACA-Std Charges"."Programme 2" := "ACA-Std Charges"."Programme 2";
                        "ACA-Std Charges".MODIFY();
                    UNTIL "ACA-Std Charges".NEXT = 0;
                END
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Done');
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

}

