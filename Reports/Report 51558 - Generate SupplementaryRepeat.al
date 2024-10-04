report 51558 "Generate Supplementary/Repeat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Generate SupplementaryRepeat.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
            RequestFilterFields = Programmes, Stage, Unit, "Student No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration__Units_Taken_; "Units Taken")
            {
            }
            column(PassedUnits; PassedUnits)
            {
            }
            column(Units_Taken__PassedUnits; "Units Taken" - PassedUnits)
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(Remark; Remark)
            {
            }
            column(RCount; RCount)
            {
            }
            column(Pass_ListCaption; Pass_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration__Units_Taken_Caption; FIELDCAPTION("Units Taken"))
            {
            }
            column(Units_PassedCaption; Units_PassedCaptionLbl)
            {
            }
            column(Units_FailedCaption; Units_FailedCaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(RemarkCaption; RemarkCaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := RCount + 1;

                PassedUnits := 0;
                Grading.RESET;
                Grading.SETRANGE(Grading.Category, 'DEFAULT');
                Grading.SETRANGE(Grading.Failed, TRUE);
                IF Grading.FIND('+') THEN
                    FailScore := Grading."Up to";

                StudUnits.RESET;
                StudUnits.SETRANGE(StudUnits."Student No.", "ACA-Course Registration"."Student No.");
                StudUnits.SETRANGE(StudUnits."Reg. Transacton ID", "ACA-Course Registration"."Reg. Transacton ID");
                IF StudUnits.FIND('-') THEN BEGIN
                    REPEAT
                        StudUnits.CALCFIELDS(StudUnits."Total Score");
                        IF StudUnits."Total Score" > FailScore THEN
                            PassedUnits := PassedUnits + 1;

                    UNTIL StudUnits.NEXT = 0;
                END;

                IF ("ACA-Course Registration"."Units Taken" - PassedUnits) > 4 THEN BEGIN
                    Remark := 'REPEAT';
                    StudUnitsR.RESET;
                    StudUnitsR.SETRANGE(StudUnitsR."Student No.", "ACA-Course Registration"."Student No.");
                    StudUnitsR.SETRANGE(StudUnitsR."Reg. Transacton ID", "ACA-Course Registration"."Reg. Transacton ID");
                    IF StudUnitsR.FIND('-') THEN BEGIN
                        REPEAT
                            StudUnitsR.CALCFIELDS(StudUnitsR."Total Score");
                            //StudUnitsR."Repeat Unit":=TRUE;
                            StudUnitsR.MODIFY;

                        UNTIL StudUnitsR.NEXT = 0;
                    END;


                END ELSE
                    IF ("ACA-Course Registration"."Units Taken" - PassedUnits) <= 4 THEN BEGIN
                        //Remark:='SUPPLEMENTARY';
                        Remark := 'REPEAT';
                        StudUnitsR.RESET;
                        StudUnitsR.SETRANGE(StudUnitsR."Student No.", "ACA-Course Registration"."Student No.");
                        StudUnitsR.SETRANGE(StudUnitsR."Reg. Transacton ID", "ACA-Course Registration"."Reg. Transacton ID");
                        IF StudUnitsR.FIND('-') THEN BEGIN
                            REPEAT
                                StudUnitsR.CALCFIELDS(StudUnitsR."Total Score");
                                IF StudUnitsR."Total Score" <= FailScore THEN BEGIN
                                    //StudUnitsR."Allow Supplementary":=TRUE;
                                    StudUnitsR.MODIFY;
                                END;

                            UNTIL StudUnitsR.NEXT = 0;
                        END;


                    END ELSE
                        IF "ACA-Course Registration"."Units Taken" = PassedUnits THEN
                            Remark := 'PASSED';

            end;

            trigger OnPreDataItem()
            begin
                RCount := 0;
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
        Cust: Record 18;
        Grading: Record 61569;
        StudUnits: Record 61549;
        StudUnitsR: Record 61549;
        FailScore: Decimal;
        PassedUnits: Integer;
        Remark: Text[150];
        RCount: Integer;
        Pass_ListCaptionLbl: Label 'Pass List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Units_PassedCaptionLbl: Label 'Units Passed';
        Units_FailedCaptionLbl: Label 'Units Failed';
        NamesCaptionLbl: Label 'Names';
        RemarkCaptionLbl: Label 'Remark';
}

