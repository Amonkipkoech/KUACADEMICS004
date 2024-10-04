report 78005 "ACA-Validate Supp/Special"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000001; 78002)
        {
            RequestFilterFields = Semester, "Academic Year";

            trigger OnAfterGetRecord()
            var
                AcaSpecialExamsResults: Record 78003;
            begin
                // // ACACourseRegistration.RESET;
                // // ACACourseRegistration.SETRANGE("Student No.","Aca-Special Exams Details"."Student No.");
                // // ACACourseRegistration.SETRANGE(Semester,"Aca-Special Exams Details".Semester);
                // // ACACourseRegistration.SETFILTER(ACACourseRegistration."Yearly Remarks",'%1|%2|%3','SUPP','SPECIAL','SUPP/SPECIAL');
                // // IF NOT (ACACourseRegistration.FIND('-')) THEN BEGIN
                // // "Aca-Special Exams Details".DELETE;
                // //  AcaSpecialExamsResults.RESET;
                // //  AcaSpecialExamsResults.SETRANGE("Current Academic Year","Aca-Special Exams Details"."Current Academic Year");
                // //  AcaSpecialExamsResults.SETRANGE("Academic Year","Aca-Special Exams Details"."Academic Year");
                // //  AcaSpecialExamsResults.SETRANGE("Student No.","Aca-Special Exams Details"."Student No.");
                // //  AcaSpecialExamsResults.SETRANGE(Semester,"Aca-Special Exams Details".Semester);
                // //  AcaSpecialExamsResults.SETRANGE(Unit,"Aca-Special Exams Details"."Unit Code");
                // //  IF AcaSpecialExamsResults.FIND('-') THEN BEGIN
                // //    AcaSpecialExamsResults.DELETEALL;
                // //   END;
                // // END;
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
        VarcharPart: Code[5];
        OldUnitCode: Code[10];
        NewUnitCode: Code[10];
        IntegerPart: Code[10];

}

