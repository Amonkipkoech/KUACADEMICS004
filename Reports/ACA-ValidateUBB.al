report 51868 updateUBB
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/update.rdl';

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; "ACA-Course Registration")
        {
            RequestFilterFields = Semester;
            column(Student_No_; "Student No.")
            {

            }
            column(Semester; Semester)
            {

            }
            trigger OnAfterGetRecord()
            var
                unitBased: Record unitBasedstud;
                CourseReg: Record "ACA-Course Registration";
            begin
                CourseReg.Reset();
                //CourseReg.SetRange(CourseReg."Student No.", CourseReg."Student No.");

                if CourseReg.FIND('-') Then begin
                    repeat
                        unitBased.Reset;
                        unitBased.SetRange(StudNo, CourseReg."Student No.");
                        if unitBased.Find('-') then begin
                            CourseReg."Settlement Type" := unitBased.settlementType;
                            CourseReg."Register for" := CourseReg."Register for"::"Unit/Subject";
                            CourseReg.Modify();
                        end;



                    until CourseReg.Next() = 0;

                end;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

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