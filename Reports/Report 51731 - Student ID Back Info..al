report 51731 "Student ID Back Info."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student ID Back Info..rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
            RequestFilterFields = "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type";
            column(No; "Student No.")
            {
            }
            column(Course_Registration__Registration_Date_; "Registration Date")
            {
            }
            column(Course_Registration__Student_Type_; "Student Type")
            {
            }
            column(Stages_Description; "Stage Filter")
            {
            }
            column(Prog_Description; Programmes)
            {
            }
            column(Student_Name; "Student Name")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Cust_Picture; cust.Image)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration__Registration_Date_Caption; FIELDCAPTION("Registration Date"))
            {
            }
            column(Course_Registration__Student_Type_Caption; FIELDCAPTION("Student Type"))
            {
            }
            column(LevelCaption; LevelCaptionLbl)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(STUDENT_ID_CARDCaption; STUDENT_ID_CARDCaptionLbl)
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
            column(CardExpiry; CardExpiry)
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            column(Signature; "HREmp."."Full Name")
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                               "Student No." = FIELD("Student No.");
                DataItemTableView = WHERE(Taken = CONST(true));

                trigger OnAfterGetRecord()
                begin
                    UDesc := '';
                    UnitR.RESET;
                    UnitR.SETRANGE(UnitR."Programme Code", Programme);
                    UnitR.SETRANGE(UnitR.Code, Unit);
                    IF UnitR.FIND('-') THEN
                        UDesc := UnitR.Desription;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("Student No.") THEN
                    RFound := TRUE;
                IF Prog.GET(Programmes) THEN
                    RFound := TRUE;
                IF Stages.GET(Programmes, Stage) THEN
                    RFound := TRUE;

                CompInfo.GET;
                CompInfo.CALCFIELDS(CompInfo.Picture);
                Cust.CALCFIELDS(Cust.Image);

                CardExpiry := Cust."ID Card Expiry Year";

                "HREmp.".RESET;
                //"HREmp.".SETRANGE("HREmp."."Employee Type",TRUE);
                IF "HREmp.".FIND('-') THEN BEGIN
                    "HREmp.".CALCFIELDS("HREmp."."Full Name");
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

    var
        Cust: Record 18;
        Prog: Record 61511;
        Stages: Record 61516;
        RFound: Boolean;
        UDesc: Text[200];
        UnitR: Record 61517;
        CompInfo: Record 79;
        LevelCaptionLbl: Label 'Level';
        ProgrammeCaptionLbl: Label 'Programme';
        NamesCaptionLbl: Label 'Names';
        Signature_CaptionLbl: Label 'Signature:';
        STUDENT_ID_CARDCaptionLbl: Label 'STUDENT ID CARD';
        CardExpiry: Integer;
        No: Code[20];
        "HREmp.": Record 61188;
}

