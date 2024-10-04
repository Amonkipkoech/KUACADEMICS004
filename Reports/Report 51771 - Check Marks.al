report 51771 "Check Marks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Check Marks.rdl';

    dataset
    {
        dataitem(StudUntsz; 61549)
        {
            CalcFields = "Total Score";
            RequestFilterFields = Programme, Stage, Semester, Unit, "Student No.";
            column(No; StudUntsz."Student No.")
            {
            }
            column(Prog; StudUntsz.Programme)
            {
            }
            column(Stage; StudUntsz.Stage)
            {
            }
            column(InfoPic; Info.Picture)
            {
            }
            column(Infoname; Info.Name)
            {
            }
            column(infoAddress; Info.Address)
            {
            }
            column(infoPhone; info."Phone No.")
            {
            }

            column(Unit; StudUntsz.Unit)
            {
            }
            column(Sem; StudUntsz.Semester)
            {
            }
            column(Year; StudUntsz."Academic Year")
            {
            }
            column(Grade; Grade)
            {

            }
            column(Fin_Score; StudUntsz."Final Score")
            {
            }
            column(Total_Score; StudUntsz."Total Score")
            {
            }
            column(TotScore; StudUntsz."Total Score")
            {
            }
            column(Cat; StudUntsz."CATs Marks")
            {
            }
            column(exam; StudUntsz."EXAMs Marks")
            {
            }
            column(ProgCode; ACAProgramme.Code)
            {
            }
            column(ProgDesc; ACAProgramme.Description)
            {
            }
            column(UnitName; StudUntsz."Unit Name")
            {
            }
            column(UnitDesc; StudUntsz.Description)
            {
            }
            column(StudName; Customer."First Name")
            {
            }
            column(studNam2; Customer."Last Name")
            {

            }
            column(studNam3; Customer."Last Name")
            {

            }
            column(names; Customer.Name)
            {

            }
            column(seq; seq)
            {
            }
          
            column(Exam_Category; StudUntsz."Exam Category")
            {

            }
            column(CompanyInfo; CompanyInfo.Picture)
            {

            }
            column(gradeA; gradeA)
            {

            }
            column(gradeB; gradeB)
            {

            }
            column(gradeC; gradeC)
            {

            }
            column(gradeD; gradeD)
            {

            }
            column(gradeE; gradeE)
            {

            }
            column(gradeF; gradeF)
            {

            }
            column(gradeI; gradeI)
            {

            }
            column(gradeZ; gradeZ)
            {

            }



            trigger OnAfterGetRecord()
            begin
                //Count(StudUntsz where(grade) );
                gradeA := 0;
                studUnits.Reset();
                studUnits.SetRange(Unit, StudUntsz.Unit);
                studUnits.SetRange(Semester, StudUntsz.Semester);
                studUnits.SetRange(Grade, 'A');
                if studUnits.Find('-') then begin
                    repeat
                        gradeA := gradeA + 1;
                    until studUnits.Next() = 0;
                    // //gradeA:=studUnits.Count(studUnits.Grade where (studUnits.Grade = 'A'));
                    // gradeB := StudUntsz.Count(StudUntsz.Grade, where())
                end;
                gradeB := 0;
                studUnits.Reset();
                studUnits.SetRange(Unit, StudUntsz.Unit);
                studUnits.SetRange(Semester, StudUntsz.Semester);
                studUnits.SetRange(Grade, 'B');
                if studUnits.Find('-') then begin
                    repeat
                        gradeB := gradeB + 1;
                    until studUnits.Next() = 0;
                    // //gradeA:=studUnits.Count(studUnits.Grade where (studUnits.Grade = 'A'));
                    // gradeB := StudUntsz.Count(StudUntsz.Grade, where())
                end;
                gradeC := 0;
                studUnits.Reset();
                studUnits.SetRange(Unit, StudUntsz.Unit);
                studUnits.SetRange(Semester, StudUntsz.Semester);
                studUnits.SetRange(Grade, 'C');
                if studUnits.Find('-') then begin
                    repeat
                        gradeC := gradeC + 1;
                    until studUnits.Next() = 0;
                    // //gradeA:=studUnits.Count(studUnits.Grade where (studUnits.Grade = 'A'));
                    // gradeB := StudUntsz.Count(StudUntsz.Grade, where())
                end;
                gradeD := 0;
                studUnits.Reset();
                studUnits.SetRange(Unit, StudUntsz.Unit);
                studUnits.SetRange(Semester, StudUntsz.Semester);
                studUnits.SetRange(Grade, 'D');
                if studUnits.Find('-') then begin
                    repeat
                        gradeD := gradeD + 1;
                    until studUnits.Next() = 0;
                    // //gradeA:=studUnits.Count(studUnits.Grade where (studUnits.Grade = 'A'));
                    // gradeB := StudUntsz.Count(StudUntsz.Grade, where())
                end;
                gradeE := 0;
                studUnits.Reset();
                studUnits.SetRange(Unit, StudUntsz.Unit);
                studUnits.SetRange(Semester, StudUntsz.Semester);
                studUnits.SetRange(Grade, 'E');
                if studUnits.Find('-') then begin
                    repeat
                        gradeE := gradeE + 1;
                    until studUnits.Next() = 0;
                    // //gradeA:=studUnits.Count(studUnits.Grade where (studUnits.Grade = 'A'));
                    // gradeB := StudUntsz.Count(StudUntsz.Grade, where())
                end;
                gradeF := 0;
                studUnits.Reset();
                studUnits.SetRange(Unit, StudUntsz.Unit);
                studUnits.SetRange(Semester, StudUntsz.Semester);
                studUnits.SetRange(Grade, 'F');
                if studUnits.Find('-') then begin
                    repeat
                        gradeF := gradeF + 1;
                    until studUnits.Next() = 0;
                    // //gradeA:=studUnits.Count(studUnits.Grade where (studUnits.Grade = 'A'));
                    // gradeB := StudUntsz.Count(StudUntsz.Grade, where())
                end;
                gradeI := 0;
                studUnits.Reset();
                studUnits.SetRange(Unit, StudUntsz.Unit);
                studUnits.SetRange(Semester, StudUntsz.Semester);
                studUnits.SetRange(Grade, 'I');
                if studUnits.Find('-') then begin
                    repeat
                        gradeI := gradeI + 1;
                    until studUnits.Next() = 0;
                    // //gradeA:=studUnits.Count(studUnits.Grade where (studUnits.Grade = 'A'));
                    // gradeB := StudUntsz.Count(StudUntsz.Grade, where())
                end;
                gradeZ := 0;
                studUnits.Reset();
                studUnits.SetRange(Unit, StudUntsz.Unit);
                studUnits.SetRange(Semester, StudUntsz.Semester);
                studUnits.SetRange(Programme, StudUntsz.Programme);
                studUnits.SetRange(Grade, 'Z');
                if studUnits.Find('-') then begin
                    repeat
                        gradeZ := gradeZ + 1;
                    until studUnits.Next() = 0;
                    // //gradeA:=studUnits.Count(studUnits.Grade where (studUnits.Grade = 'A'));
                    // gradeB := StudUntsz.Count(StudUntsz.Grade, where())
                end;


                CALCFIELDS(StudUntsz."Total Score", StudUntsz."Unit Description",
                  StudUntsz."EXAMs Marks Exists", StudUntsz."CATs Marks Exists");
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(code, StudUntsz.Programme);
                ACAUnitsSubjects.SETRANGE(code, StudUntsz.Unit);
                IF ACAUnitsSubjects.FIND('-') THEN;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(code, StudUntsz.Programme);
                IF ACAProgramme.FIND('-') THEN BEGIN

                END;

                IF ACAUnitsSubjects."Exam Category" = '' THEN BEGIN
                    IF ACAUnitsSubjects."Default Exam Category" <> '' THEN
                        ACAUnitsSubjects."Exam Category" := ACAUnitsSubjects."Default Exam Category"
                    ELSE
                        ACAUnitsSubjects."Exam Category" := ACAProgramme."Exam Category";
                END;

                Customer.RESET;
                Customer.SETRANGE("No.", "Student No.");
                IF Customer.FIND('-') THEN BEGIN
                END;
                CLEAR(MarkStatuses);


                IF (StudUntsz."EXAMs Marks Exists" = FALSE) THEN BEGIN
                    MarkStatuses := MarkStatuses::"CAT Only";
                END ELSE
                    IF (StudUntsz."CATs Marks Exists" = FALSE) THEN BEGIN
                        MarkStatuses := MarkStatuses::"Exam Only";
                    END;
                IF ((StudUntsz."EXAMs Marks Exists" = FALSE) AND (StudUntsz."CATs Marks Exists" = FALSE)) THEN BEGIN
                    MarkStatuses := MarkStatuses::"None Exists";
                END;
                IF ((StudUntsz."EXAMs Marks Exists" = TRUE) AND (StudUntsz."CATs Marks Exists" = TRUE)) THEN BEGIN
                    MarkStatuses := MarkStatuses::"Both Exists";
                END;

                // StudUntsz.CALCFIELDS("Total Score");
                // ACAExamGradingSource.RESET;
                // // //   ACAExamGradingSource.SETRANGE("Academic Year",StudUntsz."Academic Year");
                // //ACAExamGradingSource.SETRANGE("Exam Type",StudUntsz."Exam Category");
                // ACAExamGradingSource.SETRANGE("Total Score", StudUntsz."Total Score");
                // ACAExamGradingSource.SETRANGE("Results Exists Status", MarkStatuses);
                // IF ACAExamGradingSource.FIND('-') THEN;

                // StudUntsz.Grade := ACAExamGradingSource.Grade;
                // IF ACAExamGradingSource.Pass THEN
                //     StudUntsz.Failed := FALSE ELSE
                //     StudUntsz.Failed := TRUE;


                seq += 1;
            end;

            trigger OnPreDataItem()
            begin
                seq := 0;
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
    trigger OnInitReport()
    begin
        info.get();
        info.CalcFields(Picture);
    end;

    var
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        Customer: Record 18;
        seq: Integer;
        MarkStatuses: Option " ","Both Exists","CAT Only","Exam Only","None Exists";
        ACAExamGradingSource: Record 66659;

        info: Record "Company Information";
        CompanyInfo: Record 79;
        studUnits: Record "ACA-Student Units";
        gradeA: Decimal;
        gradeB: Decimal;
        gradeC: Decimal;
        gradeD: Decimal;
        gradeE: Decimal;
        gradeF: Decimal;
        gradeZ: Decimal;
        gradeI: Decimal;
}

