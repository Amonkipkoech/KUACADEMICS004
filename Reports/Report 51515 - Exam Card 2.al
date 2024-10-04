report 51515 "Exam Card 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Card 2.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Reversed = FILTER(false),
                                     "Units Taken" = FILTER(> 0),
                                      Balance = FILTER(< 2));
            RequestFilterFields = "Student No.", Programmes, Semester, Stage, "Date Filter";
            column(col1StudNo; col1StudNo)
            {
            }
            column(col2StudNo; col2StudNo)
            {
            }
            column(col1Faculty; col1Faculty)
            {
            }
            column(col1Programme; col1Programme)
            {
            }
            column(col2Faculty; col2Faculty)
            {
            }
            column(col2Programme; col2Programme)
            {
            }
            column(col1Names; col1Names)
            {
            }
            column(col2Names; col2Names)
            {
            }
            column(col1Bal; col1Bal)
            {
            }
            column(col2Bal; col2Bal)
            {
            }
            column(i; i)
            {
            }
            column(j; j)
            {
            }
            column(i_Control1102760013; i)
            {
            }
            column(j_Control1102760014; j)
            {
            }
            column(studStageSem; studStageSem)
            {
            }
            column(studStageSem2; studStageSem2)
            {
            }
            column(u1_1_; u1[1])
            {
            }
            column(u1_2_; u1[2])
            {
            }
            column(u1_3_; u1[3])
            {
            }
            column(u1_4_; u1[4])
            {
            }
            column(u1_5_; u1[5])
            {
            }
            column(u1_6_; u1[6])
            {
            }
            column(u1_7_; u1[7])
            {
            }
            column(u1_8_; u1[8])
            {
            }
            column(u1_9_; u1[9])
            {
            }
            column(u1_10_; u1[10])
            {
            }
            column(u2_1_; u2[1])
            {
            }
            column(u2_2_; u2[2])
            {
            }
            column(u2_3_; u2[3])
            {
            }
            column(u2_4_; u2[4])
            {
            }
            column(u2_5_; u2[5])
            {
            }
            column(u2_6_; u2[6])
            {
            }
            column(u2_7_; u2[7])
            {
            }
            column(u2_8_; u2[8])
            {
            }
            column(u2_9_; u2[9])
            {
            }
            column(u2_10_; u2[10])
            {
            }
            column(Units_RegisteredCaption; Units_RegisteredCaptionLbl)
            {
            }
            column(Units_RegisteredCaption_Control1102755023; Units_RegisteredCaption_Control1102755023Lbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
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
            column(Supervisor_Signature; SUPsIGNATURE)
            {
            }
            column(Comp_Name; compName)
            {
            }
            column(coursecode_title; coursecode)
            {
            }
            column(CourseNameCaption; CourseDesc)
            {
            }
            column(U1Code_1; U1Code[1])
            {
            }
            column(creditHrs_1; creditHrs)
            {
            }
            column(U1Desc_1; U1Desc[1])
            {
            }
            column(U2Code_1; U2Code[1])
            {
            }
            column(U2Desc_1; U2Desc[1])
            {
            }
            column(U1Units_1; U1Units[1])
            {
            }
            column(U2Units_1; U2Units[1])
            {
            }
            column(instrtitle; instrtitle)
            {
            }
            column(rule1; rule1)
            {
            }
            column(rule2; rule2)
            {
            }
            column(rule3; rule3)
            {
            }
            column(rule4; rule4)
            {
            }
            column(rule5; rule5)
            {
            }
            column(rule6; rule6)
            {
            }
            column(desclaimer; desclaimer)
            {
            }
            column(desclaimersigns; desclaimersigns)
            {
            }
            column(U1Code_2; U1Code[2])
            {
            }
            column(U1Desc_2; U1Desc[2])
            {
            }
            column(U2Code_2; U2Code[2])
            {
            }
            column(U2Desc_2; U2Desc[2])
            {
            }
            column(U1Units_2; U1Units[2])
            {
            }
            column(U2Units_2; U2Units[2])
            {
            }
            column(U1Code_3; U1Code[3])
            {
            }
            column(U1Desc_3; U1Desc[3])
            {
            }
            column(U2Code_3; U2Code[3])
            {
            }
            column(U2Desc_3; U2Desc[3])
            {
            }
            column(U1Units_3; U1Units[3])
            {
            }
            column(U2Units_3; U2Units[3])
            {
            }
            column(U1Code_4; U1Code[4])
            {
            }
            column(U1Desc_4; U1Desc[4])
            {
            }
            column(U2Code_4; U2Code[4])
            {
            }
            column(U2Desc_4; U2Desc[4])
            {
            }
            column(U1Units_4; U1Units[4])
            {
            }
            column(U2Units_4; U2Units[4])
            {
            }
            column(U1Code_5; U1Code[5])
            {
            }
            column(U1Desc_5; U1Desc[5])
            {
            }
            column(U2Code_5; U2Code[5])
            {
            }
            column(U2Desc_5; U2Desc[5])
            {
            }
            column(U1Units_5; U1Units[5])
            {
            }
            column(U2Units_5; U2Units[5])
            {
            }
            column(U1Code_6; U1Code[6])
            {
            }
            column(U1Desc_6; U1Desc[6])
            {
            }
            column(U2Code_6; U2Code[6])
            {
            }
            column(U2Desc_6; U2Desc[6])
            {
            }
            column(U1Units_6; U1Units[6])
            {
            }
            column(U2Units_6; U2Units[6])
            {
            }
            column(U1Code_7; U1Code[7])
            {
            }
            column(U1Desc_7; U1Desc[7])
            {
            }
            column(U2Code_7; U2Code[7])
            {
            }
            column(U2Desc_7; U2Desc[7])
            {
            }
            column(U1Units_7; U1Units[7])
            {
            }
            column(U2Units_7; U2Units[7])
            {
            }
            column(U1Code_8; U1Code[8])
            {
            }
            column(U1Desc_8; U1Desc[8])
            {
            }
            column(U2Code_8; U2Code[8])
            {
            }
            column(U2Desc_8; U2Desc[8])
            {
            }
            column(U1Units_8; U1Units[8])
            {
            }
            column(U2Units_8; U2Units[8])
            {
            }
            column(U1Code_9; U1Code[9])
            {
            }
            column(U1Desc_9; U1Desc[9])
            {
            }
            column(U2Code_9; U2Code[9])
            {
            }
            column(U2Desc_9; U2Desc[9])
            {
            }
            column(U1Units_9; U1Units[9])
            {
            }
            column(U2Units_9; U2Units[9])
            {
            }
            column(U1Code_10; U1Code[10])
            {
            }
            column(U1Desc_10; U1Desc[10])
            {
            }
            column(U2Code_10; U2Code[10])
            {
            }
            column(U2Desc_10; U2Desc[10])
            {
            }
            column(U1Units_10; U1Units[10])
            {
            }
            column(U2Units_10; U2Units[10])
            {
            }

            trigger OnAfterGetRecord()
            begin
                j := j + 1;

                IF recCustomer.GET("ACA-Course Registration"."Student No.") THEN BEGIN
                    txtNames := UPPERCASE(recCustomer.Name);
                    recCustomer.CALCFIELDS(recCustomer."Balance (LCY)");
                    bal := recCustomer."Balance (LCY)";
                    bal := 0;
                END;

                CALCFIELDS("Units Taken");

                IF "Units Taken" <= 0 THEN CurrReport.SKIP;


                IF (bal > 0) THEN BEGIN
                    CurrReport.SKIP;
                END;

                IF (bal > 0) AND (j < studCount) THEN BEGIN
                    CurrReport.SKIP;
                END
                ELSE BEGIN

                    i := i + 1;

                    col2StudNo := '';
                    col2Programme := '';
                    col2Faculty := '';
                    col2Names := '';
                    col2Bal := 0;
                    studStageSem2 := '';

                    recProgramme.SETRANGE(recProgramme.Code, "ACA-Course Registration".Programmes);
                    IF recProgramme.FIND('-') THEN BEGIN
                        txtProgramme := recProgramme.Description;
                        FacultyCode := recProgramme.Faculty;
                    END;

                    recFaculty.SETRANGE(recFaculty.Code, FacultyCode);
                    IF recFaculty.FIND('-') THEN
                        txtFaculty := recFaculty.Name;

                    IF i MOD 2 = 1 THEN BEGIN
                        IF j = studCount THEN BEGIN
                            col1StudNo := "ACA-Course Registration"."Student No.";
                            col1Programme := txtProgramme;
                            col1Faculty := txtFaculty;
                            col1Names := txtNames;
                            col1Bal := bal;
                            studStageSem := 'Stage: ' + "ACA-Course Registration".Stage + '  Semester: ' + "ACA-Course Registration".Semester;

                            FOR k := 1 TO 10 DO BEGIN
                                u1[k] := '';
                                CLEAR(U1Code);
                                CLEAR(U1Desc);
                                CLEAR(U1Units);

                            END;

                            k := 1;
                            StudUnits.RESET;
                            StudUnits.SETRANGE(StudUnits.Programme, "ACA-Course Registration".Programmes);
                            StudUnits.SETRANGE(StudUnits.Stage, "ACA-Course Registration".Stage);
                            StudUnits.SETRANGE(StudUnits.Semester, "ACA-Course Registration".Semester);
                            StudUnits.SETRANGE(StudUnits."Student No.", col1StudNo);
                            //StudUnits.SETFILTER(StudUnits."Date Created",'%1',"Course Registration"."Date Filter");
                            IF StudUnits.FIND('-') THEN BEGIN
                                REPEAT

                                    subjz.RESET;
                                    subjz.SETRANGE(subjz."Programme Code", StudUnits.Programme);
                                    subjz.SETRANGE(subjz."Stage Code", StudUnits.Stage);
                                    subjz.SETRANGE(subjz.Code, StudUnits.Unit);
                                    subjz.SETRANGE(subjz."Old Unit", FALSE);
                                    IF k < 16 THEN BEGIN
                                        IF subjz.FIND('-') THEN BEGIN
                                            U1Code[k] := subjz.Code;
                                            U1Desc[k] := subjz.Desription;
                                            U1Units[k] := subjz."No. Units";
                                        END;
                                        StudUnits.CALCFIELDS(StudUnits."Unit Description");
                                        u1[k] := FORMAT(k) + ' - ' + StudUnits.Unit + ' - ' + FORMAT(StudUnits."Unit Description");
                                        k := k + 1;
                                    END;
                                UNTIL StudUnits.NEXT = 0;
                            END;

                        END
                        ELSE BEGIN
                            col1StudNo := "ACA-Course Registration"."Student No.";
                            col1Programme := txtProgramme;
                            col1Faculty := txtFaculty;
                            col1Names := txtNames;
                            col1Bal := bal;
                            studStageSem := 'Stage: ' + "ACA-Course Registration".Stage + '  Semester: ' + "ACA-Course Registration".Semester;
                            k := 1;
                            CLEAR(U1Code);
                            CLEAR(U1Desc);
                            CLEAR(U1Units);
                            StudUnits.RESET;
                            StudUnits.SETRANGE(StudUnits.Programme, "ACA-Course Registration".Programmes);
                            StudUnits.SETRANGE(StudUnits.Stage, "ACA-Course Registration".Stage);
                            StudUnits.SETRANGE(StudUnits.Semester, "ACA-Course Registration".Semester);
                            StudUnits.SETRANGE(StudUnits."Student No.", col1StudNo);
                            // StudUnits.SETFILTER(StudUnits."Date Created",'%1',"Course Registration"."Date Filter");
                            IF StudUnits.FIND('-') THEN BEGIN
                                REPEAT
                                    subjz.RESET;
                                    subjz.SETRANGE(subjz."Programme Code", StudUnits.Programme);
                                    subjz.SETRANGE(subjz."Stage Code", StudUnits.Stage);
                                    subjz.SETRANGE(subjz.Code, StudUnits.Unit);
                                    subjz.SETRANGE(subjz."Old Unit", FALSE);
                                    IF k < 16 THEN BEGIN
                                        IF subjz.FIND('-') THEN BEGIN
                                            U1Code[k] := subjz.Code;
                                            U1Desc[k] := subjz.Desription;
                                            U1Units[k] := subjz."No. Units";
                                        END;

                                        StudUnits.CALCFIELDS(StudUnits."Unit Description");
                                        u1[k] := FORMAT(k) + ' - ' + StudUnits.Unit + ' - ' + FORMAT(StudUnits."Unit Description");
                                        k := k + 1;
                                    END;
                                UNTIL StudUnits.NEXT = 0;
                            END;

                            CurrReport.SKIP;
                        END;
                    END
                    ELSE BEGIN
                        IF bal <= 0 THEN BEGIN

                            col2StudNo := "ACA-Course Registration"."Student No.";
                            col2Programme := txtProgramme;
                            col2Faculty := txtFaculty;
                            col2Names := txtNames;
                            col2Bal := bal;
                            studStageSem2 := 'Stage: ' + "ACA-Course Registration".Stage + '  Semester: ' + "ACA-Course Registration".Semester;
                            FOR k := 1 TO 10 DO BEGIN
                                u2[k] := '';
                                CLEAR(U2Code);
                                CLEAR(U2Desc);
                                CLEAR(U2Units);
                            END;

                            k := 1;
                            StudUnits.RESET;
                            StudUnits.SETRANGE(StudUnits.Programme, "ACA-Course Registration".Programmes);
                            StudUnits.SETRANGE(StudUnits.Stage, "ACA-Course Registration".Stage);
                            StudUnits.SETRANGE(StudUnits.Semester, "ACA-Course Registration".Semester);
                            StudUnits.SETRANGE(StudUnits."Student No.", col2StudNo);
                            //  StudUnits.SETFILTER(StudUnits."Date Created",'%1',"Course Registration"."Date Filter");
                            IF StudUnits.FIND('-') THEN BEGIN
                                REPEAT
                                    subjz.RESET;
                                    subjz.SETRANGE(subjz."Programme Code", StudUnits.Programme);
                                    subjz.SETRANGE(subjz."Stage Code", StudUnits.Stage);
                                    subjz.SETRANGE(subjz.Code, StudUnits.Unit);
                                    subjz.SETRANGE(subjz."Old Unit", FALSE);
                                    IF k < 16 THEN BEGIN
                                        IF subjz.FIND('-') THEN BEGIN
                                            U2Code[k] := subjz.Code;
                                            U2Desc[k] := subjz.Desription;
                                            U2Units[k] := subjz."No. Units";
                                        END;

                                        StudUnits.CALCFIELDS(StudUnits."Unit Description");
                                        u2[k] := FORMAT(k) + ' - ' + StudUnits.Unit + ' - ' + FORMAT(StudUnits."Unit Description");
                                        k := k + 1;
                                    END;
                                UNTIL StudUnits.NEXT = 0;
                            END;

                        END;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                studCount := "ACA-Course Registration".COUNT;
                CompInf.GET;
                CompInf.CALCFIELDS(CompInf.Picture);
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
        col1StudNo: Code[20];
        col1Programme: Text[100];
        col1Faculty: Text[100];
        col1Names: Text[50];
        col1Bal: Decimal;
        col2StudNo: Code[20];
        col2Programme: Text[100];
        col2Faculty: Text[100];
        col2Names: Text[50];
        col2Bal: Decimal;
        i: Integer;
        j: Integer;
        studCount: Integer;
        recProgramme: Record 61511;
        txtProgramme: Text[100];
        recFaculty: Record 349;
        txtFaculty: Text[100];
        FacultyCode: Code[20];
        txtNames: Text[50];
        recCustomer: Record 18;
        bal: Decimal;
        studStageSem: Code[50];
        studStageSem2: Code[50];
        u1: array[20] of Text[100];
        StudUnits: Record 61549;
        k: Integer;
        u2: array[20] of Text[100];
        Units_RegisteredCaptionLbl: Label 'Units Registered';
        Units_RegisteredCaption_Control1102755023Lbl: Label 'Units Registered';
        SUPsIGNATURE: Label 'Signature of the Invigilator on Collection of the Scripts';
        compName: Label 'MASENO UNIVERSITY';
        coursecode: Label 'COURSE CODE';
        CourseDesc: Label 'COURSE TITLE';
        creditHrs: Label 'UNITS';
        U1Code: array[20] of Code[20];
        U1Desc: array[20] of Text[100];
        U2Code: array[20] of Code[20];
        U2Desc: array[20] of Text[100];
        U1Units: array[20] of Decimal;
        U2Units: array[20] of Decimal;
        instrtitle: Label 'IMPORTANT';
        rule1: Label 'This card is NOT Transferable nor is it Replaceable';
        rule2: Label 'it MUST be presented together with the student identity card to the invigilator when required';
        rule3: Label 'The invigilator MUST sign on the card as he/she collects the scripts';
        rule4: Label 'The names which appear on the card are the same names which will appear on the certificate';
        rule5: Label 'The candidate must ensure that the order of the names are consistently written at all times i.e. surname, first Name and middle Name';
        rule6: Label 'Any error on the names must be corrected at the office of the Dean of the School in which the Candidate is registered.';
        desclaimer: Label 'This is to confirm that the information above is correct';
        desclaimersigns: Label 'Dean of the School ..................................... Stamp... ................';
        subjz: Record 61517;
        CompInf: Record 79;
        "date created": DateTime;
}

