report 51774 "Exam Card Final"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Card Final.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Reversed = FILTER(false),
                                      "Units Taken" = FILTER(> 0));
            RequestFilterFields = "Student No.", Programmes, Semester, Stage, "Date Filter";
            column(ExamCardSerial; "ACA-Course Registration"."Reg. Transacton ID")
            {
            }
            column(Signat; usersetup."User Signature")
            {
            }
            column(ApprovalTitle; usersetup."Approval Title")
            {
            }
            column(pic; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CompAddress; CompInf.Address + ' ' + CompInf."Address 2")
            {
            }
            column(CompPhone; CompInf."Phone No." + ';' + CompInf."Phone No. 2")
            {
            }
            column(ComMails; CompInf."E-Mail" + '/' + CompInf."Home Page")
            {
            }
            column(StudNo; recCustomer."No.")
            {
            }
            column(StudName; recCustomer.Name)
            {
            }
            column(studpic; recCustomer.Image)
            {
            }
            column(ProgName; txtProgramme)
            {
            }
            column(FacultyName; txtFaculty)
            {
            }
            column(studStageSem; studStageSem)
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
            column(Stages; "ACA-Course Registration".Stage)
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
            column(Sems; "ACA-Course Registration".Semester)
            {
            }
            dataitem(suppUnits; "Aca-Special Exams Details")
            {
                DataItemLink = "Student No." = field("Student No."),
                "Current Semester" = FIELD(Semester);
                column(Unit_Code; "Unit Code")
                {

                }
                column(Unit_Description; "Unit Description")
                {

                }
                column(Student_No_; "Student No.")
                {

                }
                column(Catogory; Catogory)
                {

                }
                column(studentName; studentName)
                {

                }

            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Semester = FIELD(Semester),
                               Programme = FIELD(Programmes);
                column(SubjCode; "ACA-Student Units".Unit)
                {
                }
                column(SubjName; "ACA-Student Units".Description)
                {
                }
                column(Reg__Transacton_ID; "Reg. Transacton ID")
                {

                }
                column(regtransID; regtransID)
                {

                }
                column(unitDesc; unitDesc)
                {

                }

                trigger OnAfterGetRecord()
                begin
                    unitsMater.Reset();
                    unitsMater.SetRange("Unit Code", "ACA-Student Units".Unit);
                    if unitsMater.Find('-') then begin
                        unitDesc := unitsMater."Unit Base Title";
                    end;

                END;

                //recCustomer.CALCFIELDS(recCustomer.Image);

            }


            trigger OnAfterGetRecord()
            begin
                StudUnits.Reset();
                StudUnits.SetRange("Student No.", "ACA-Course Registration"."Student No.");
                StudUnits.SETRANGE(Semester, "ACA-Course Registration".Semester);
                if StudUnits.Find('-') then begin

                    regtransID := StudUnits."Reg. Transacton ID";

                end;

                IF recCustomer.GET("ACA-Course Registration"."Student No.") THEN BEGIN
                    recCustomer.CALCFIELDS(recCustomer.Balance);
                    bal := recCustomer.Balance;
                    if recCustomer."Fee Cleared" = true then
                        vcCleared := true;


                END;

                CALCFIELDS("Units Taken");

                IF "Units Taken" <= 0 THEN CurrReport.SKIP;


                IF (bal > 5000) THEN BEGIN
                    CurrReport.SKIP;
                END;

                IF (bal > 5000) THEN BEGIN
                    //CurrReport.SKIP;
                END ELSE BEGIN
                    CLEAR(studStageSem);
                    CLEAR(txtProgramme);
                    CLEAR(FacultyCode);
                    CLEAR(txtFaculty);

                    recProgramme.RESET;
                    recProgramme.SETRANGE(recProgramme.Code, "ACA-Course Registration".Programmes);
                    IF recProgramme.FIND('-') THEN BEGIN
                        txtProgramme := recProgramme.Description;
                        FacultyCode := recProgramme."Department Code";
                    END;
                    recFaculty.RESET;
                    recFaculty.SETRANGE(recFaculty.Code, FacultyCode);
                    IF recFaculty.FIND('-') THEN
                        txtFaculty := recFaculty.Name;

                    studStageSem := 'Stage: ' + "ACA-Course Registration".Stage + '  Semester: ' + "ACA-Course Registration".Semester;
                END;
            end;

            trigger OnPreDataItem()
            begin
                //studCount:="ACA-Course Registration".COUNT;
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
        IF CompInf.GET THEN
            CompInf.CALCFIELDS(CompInf.Picture);

        usersetup.RESET;
        usersetup.SETRANGE("Can Post Customer Refund", TRUE);
        IF usersetup.FIND('-') THEN BEGIN
            usersetup.CALCFIELDS("User Signature");
        END;
    end;

    var

        usersetup: Record 91;
        recProgramme: Record 61511;
        txtProgramme: Text[100];
        vcCleared: Boolean;
        recFaculty: Record 349;
        txtFaculty: Text[100];
        FacultyCode: Code[20];
        txtNames: Text[50];
        recCustomer: Record 18;
        bal: Decimal;
        studStageSem: Code[50];
        StudUnits: Record 61549;
        Units_RegisteredCaptionLbl: Label 'Units Registered';
        Units_RegisteredCaption_Control1102755023Lbl: Label 'Units Registered';
        SUPsIGNATURE: Label 'Signature of the Invigilator on Collection of the Scripts';
        coursecode: Label 'COURSE CODE';
        CourseDesc: Label 'COURSE TITLE';
        creditHrs: Label 'UNITS';
        instrtitle: Label 'IMPORTANT';
        rule1: Label 'This card is NOT Transferable nor is it Replaceable';
        rule2: Label 'It MUST be presented together with the student identity card to the invigilator when required';
        rule3: Label 'The invigilator MUST sign on the card as he/she collects the scripts';
        rule4: Label 'The names which appear on the card are the same names which will appear on the certificate';
        rule5: Label 'The candidate must ensure that the order of the names are consistently written at all times i.e. surname, first Name and middle Name';
        rule6: Label 'Any error on the names must be corrected at the office of the Dean of the School in which the Candidate is registered.';
        desclaimer: Label 'This is to confirm that the information above is correct';
        desclaimersigns: Label 'Dean of the School ..................................... Stamp... ................';
        subjz: Record 61517;
        CompInf: Record 79;
        "date created": DateTime;
        regtransID: text[200];
        unitDesc: Text[200];
        unitsMater: Record "ACA-Units Master Table";
}

