report 51782 Process
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; 18)
        {

            trigger OnAfterGetRecord()
            begin
                /* IF COPYSTR("Student Data Buffer"."Stud. No.",1,3)='MBA' THEN BEGIN
                 "Student Data Buffer"."Stud. No.":='MUC-'+"Student Data Buffer"."Stud. No.";
                 "Student Data Buffer".MODIFY;
                 END;     */
                IF Gender > 0 THEN BEGIN
                    Gender := Gender - 1;
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
}

