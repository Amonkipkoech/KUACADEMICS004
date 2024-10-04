report 40000 "Validate Unit Name"
{
    DefaultLayout = RDLC;
    RDLCLayout = './vakidateReports/SSR/unitNames.rdl';
    ProcessingOnly = true;

    dataset
    {
        dataitem(lecUnits; 65202)
        {
            RequestFilterFields = "Group Type", Semester;
            column(Unit; Unit)
            {

            }
            column(Group_Type; "Group Type")
            {

            }
            trigger OnAfterGetRecord()
            var
            begin
                Validate(Unit);
            end;



        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
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



    var
        myInt: Integer;

}