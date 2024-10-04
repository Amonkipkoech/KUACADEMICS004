table 77710 "Aca-Result Cancelation Req. Hd"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));
        }
        field(2; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year".Code;
        }
        field(3; "Semester Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Course Registration".Semester WHERE("Academic Year" = FIELD("Academic Year"),
                                                                      "Student No." = FIELD("Student No."));

            trigger OnValidate()
            begin
                ACACourseRegistration.RESET;
                ACACourseRegistration.SETRANGE(Semester, Rec."Semester Code");
                ACACourseRegistration.SETRANGE("Student No.", Rec."Student No.");
                ACACourseRegistration.SETRANGE(Reversed, FALSE);
                IF ACACourseRegistration.FIND('-') THEN BEGIN
                    Rec."Stage Code" := ACACourseRegistration.Stage;
                END;
            end;
        }
        field(4; "Program Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Course Registration".Programmes WHERE("Student No." = FIELD("Student No."),
                                                                       Semester = FIELD("Semester Code"),
                                                                       "Academic Year" = FIELD("Academic Year"));
        }
        field(5; "Stage Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Initiated By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Approved By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Initiated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Initiated Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Approved Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Scope; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Unit,Entire Semester';
            OptionMembers = " ",Unit,"Entire Semester";

            trigger OnValidate()
            begin
                AcaResultCancelationSubject.RESET;
                AcaResultCancelationSubject.SETRANGE("Student No.", Rec."Student No.");
                AcaResultCancelationSubject.SETRANGE("Academic Year", Rec."Academic Year");
                AcaResultCancelationSubject.SETRANGE("Program Code", Rec."Program Code");
                AcaResultCancelationSubject.SETRANGE("Semester Code", Rec."Semester Code");
                AcaResultCancelationSubject.SETRANGE("Academic Year", Rec."Academic Year");
                AcaResultCancelationSubject.SETRANGE("Stage Code", Rec."Stage Code");
                IF AcaResultCancelationSubject.FIND('-') THEN AcaResultCancelationSubject.DELETEALL;
                Rec.TESTFIELD(Rec."Semester Code");
                Rec.TESTFIELD(Rec."Student No.");
                Rec.TESTFIELD(Rec."Academic Year");
                Rec.TESTFIELD(Rec."Program Code");
                IF Scope = Scope::"Entire Semester" THEN BEGIN
                    // Update with Units for the whole Semester Tagged as Both Cancelled
                    ACAStudentUnits.RESET;
                    ACAStudentUnits.SETRANGE(Semester, Rec."Semester Code");
                    ACAStudentUnits.SETRANGE("Student No.", Rec."Student No.");
                    ACAStudentUnits.SETRANGE(Programme, Rec."Program Code");
                    ACAStudentUnits.SETRANGE(Semester, Rec."Semester Code");
                    ACAStudentUnits.SETRANGE(Reversed, FALSE);
                    IF ACAStudentUnits.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            AcaResultCancelationSubject.INIT;
                            AcaResultCancelationSubject."Student No." := Rec."Student No.";
                            AcaResultCancelationSubject."Academic Year" := Rec."Academic Year";
                            AcaResultCancelationSubject."Program Code" := Rec."Program Code";
                            AcaResultCancelationSubject."Semester Code" := Rec."Semester Code";
                            AcaResultCancelationSubject."Stage Code" := Rec."Stage Code";
                            AcaResultCancelationSubject."Unit Code" := ACAStudentUnits.Unit;
                            AcaResultCancelationSubject."Exam Type" := AcaResultCancelationSubject."Exam Type"::"CAT & Exam";
                            IF AcaResultCancelationSubject.INSERT THEN;
                        END;
                        UNTIL ACAStudentUnits.NEXT = 0;
                    END;
                END;
            end;
        }
        field(13; "No. of Units Cancelled"; Integer)
        {
            CalcFormula = Count("Aca-Result Cancelation Subject" WHERE("Student No." = FIELD("Student No."),
                                                                        "Academic Year" = FIELD("Academic Year"),
                                                                        "Semester Code" = FIELD("Semester Code"),
                                                                        "Program Code" = FIELD("Program Code"),
                                                                        "Stage Code" = FIELD("Stage Code")));
            //"Unit Code" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(14; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(15; "Cancelllation Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Department Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."Department Code" WHERE(Code = FIELD("Program Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Academic Year", "Semester Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FIND('-') THEN
            UserSetup.TESTFIELD("Initiate Results Cancellation")
        ELSE
            ERROR('Access denied!');
        "Initiated By" := USERID;
        "Initiated Date" := TODAY;
        "Initiated Time" := TIME;
    end;

    var
        AcaResultCancelationReqHd: Record "Aca-Result Cancelation Req. Hd";
        UserSetup: Record "User Setup";
        ACACourseRegistration: Record "ACA-Course Registration";
        AcaResultCancelationSubject: Record "Aca-Result Cancelation Subject";
        ACAStudentUnits: Record "ACA-Student Units";
}

