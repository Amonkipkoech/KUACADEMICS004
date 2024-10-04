report 63900 "Resit Exam  Card Final"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Resit Exam  Card Final.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(ExamCardSerial; Customer."No.")
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
            column(StudNo; Customer."No.")
            {
            }
            column(StudName; Customer.Name)
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
            column(Course_Registration_Reg__Transacton_ID; Customer."No.")
            {
            }
            column(Course_Registration_Student_No_; Customer."No.")
            {
            }
            column(Course_Registration_Programme; Programme)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; Coregz."Register for")
            {
            }
            column(Course_Registration_Stage; Coregz.Stage)
            {
            }
            column(Course_Registration_Unit; Coregz.Unit)
            {
            }
            column(Course_Registration_Student_Type; Coregz."Student Type")
            {
            }
            column(Course_Registration_Entry_No_; Coregz."Entry No.")
            {
            }
            column(Supervisor_Signature; SUPsIGNATURE)
            {
            }
            column(Stages; Coregz.Stage)
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
            column(Sems; Coregz.Semester)
            {
            }
            dataitem(ResitExams; "Aca-Special Exams Details")
            {
                DataItemLink = "Student No." = FIELD("No.");
                column(SubjCode; ResitExams."Unit Code")
                {
                }
                column(SubjName; ResitExams."Unit Description")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    subjz.RESET;
                    subjz.SETRANGE("Programme Code", ResitExams.Programme);
                    subjz.SETRANGE(Code, ResitExams."Unit Code");
                    IF subjz.FIND('-') THEN BEGIN
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ACAAcademicYear.RESET;
                ACAAcademicYear.SETRANGE(Current, TRUE);
                IF NOT (ACAAcademicYear.FIND('-')) THEN ERROR('No academic year in the filter');
                ResitExams.RESET;
                ResitExams.SETRANGE("Student No.", Customer."No.");
                ResitExams.SETRANGE("Current Academic Year", ACAAcademicYear.Code);
                IF NOT (ResitExams.FIND('-')) THEN ERROR('You are not registered in the current Semester');

                Coregz.RESET;
                Coregz.SETRANGE("Student No.", Customer."No.");
                Coregz.SETRANGE(Reversed, FALSE);
                IF Coregz.FIND('+') THEN BEGIN

                END ELSE
                    ERROR('Academic Year not defined!');
                IF recCustomer.GET(Coregz."Student No.") THEN BEGIN
                    recCustomer.CALCFIELDS(recCustomer.Balance);
                    bal := recCustomer.Balance;
                END;

                // CALCFIELDS("Units Taken");

                // IF "Units Taken"<=0 THEN CurrReport.SKIP;

                //
                IF (bal > 0) THEN BEGIN
                    CurrReport.SKIP;
                END;
                //
                // IF (bal>0) THEN
                // BEGIN
                //  CurrReport.SKIP;
                // END ELSE BEGIN
                CLEAR(studStageSem);
                CLEAR(txtProgramme);
                CLEAR(FacultyCode);
                CLEAR(txtFaculty);

                recProgramme.RESET;
                recProgramme.SETRANGE(recProgramme.Code, Coregz.Programmes);
                IF recProgramme.FIND('-') THEN BEGIN
                    txtProgramme := recProgramme.Description;
                    FacultyCode := recProgramme."Department Code";
                END;
                recFaculty.RESET;
                recFaculty.SETRANGE(recFaculty.Code, FacultyCode);
                IF recFaculty.FIND('-') THEN
                    txtFaculty := recFaculty.Name;

                studStageSem := 'Stage: ' + Coregz.Stage + '  Semester: ' + Coregz.Semester;
                // END;
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
        compName: Label ' UNIVERSITY';
        coursecode: Label 'COURSE CODE';
        CourseDesc: Label 'COURSE TITLE';
        creditHrs: Label 'UNITS';
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
        ACAAcademicYear: Record 61382;
        Coregz: Record 61532;
}

