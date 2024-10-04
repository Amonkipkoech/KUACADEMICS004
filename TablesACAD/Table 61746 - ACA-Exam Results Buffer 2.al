table 61746 "ACA-Exam Results Buffer 2"
{

    fields
    {
        field(1; "Student No."; Code[30])
        {
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));

            trigger OnValidate()
            begin
                course.RESET;
                course.SETRANGE("Student No.", "Student No.");
                course.SETRANGE(Reversed, FALSE);
                IF course.FIND('-') THEN BEGIN
                    Programme := course.Programmes;
                END;
            end;
        }
        field(2; "Student Name"; Text[250])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(3; "Academic Year"; Code[30])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(4; Semester; Code[30])
        {
            TableRelation = "ACA-Semesters".Code;

            trigger OnValidate()
            begin
                ACASemesters.RESET;
                ACASemesters.SETRANGE(Code, Rec.Semester);
                IF NOT (ACASemesters.FIND('-')) THEN ERROR('Invalid Semester!');
                IF ((ACASemesters."Lock CAT Editting") OR (ACASemesters."Lock Exam Editting")) THEN ERROR('Editing of Marks in this semester is not allowed!');
            end;
        }
        field(5; Programme; Code[30])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(6; "Unit Code"; Code[30])
        {
           //TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(7; "Unit Name"; Text[250])
        {
        }
        field(8; Exam; Code[30])
        {
        }
        field(9; "Exam Score"; Decimal)
        {
        }
        field(10; "CAT Score"; Decimal)
        {
        }
        field(11; Stage; Code[30])
        {
            TableRelation = "ACA-Programme Stages".Code;
        }
        field(12; "Course Reg. Created"; Boolean)
        {
        }
        field(13; "Units Reg. Created"; Boolean)
        {
        }
        field(14; "Failure Reason"; Text[250])
        {
        }
        field(15; "No. Series"; Code[100])
        {
        }
        field(16; "Student Type"; Code[20])
        {
        }
        field(17; Intake; Code[20])
        {
        }
        field(18; "Exam Session"; Code[20])
        {
        }
        field(19; "User Name"; Code[20])
        {
        }
        field(20; "Year of Study"; Integer)
        {
        }
        field(22; Grade; code[20])
        {

        }
        field(21; exist; Boolean)
        {
            CalcFormula = Exist("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD(Semester),
                                                           Programme = FIELD(Programme),
                                                           Unit = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Academic Year", Semester, Programme, "Unit Code", Stage, Intake, "Exam Session")
        {
        }
        key(Key2; Grade)
        {
            
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // webportals.PermissionsManagement('UPLOADMARKS', USERID);
    end;

    trigger OnInsert()
    begin
        "User Name" := USERID;
        ACAExamResultsBuffer22.RESET;
        ACAExamResultsBuffer22.SETRANGE("User Name", USERID);
        ACAExamResultsBuffer22.SETRANGE("Course Reg. Created", TRUE);
        ACAExamResultsBuffer22.SETRANGE("Units Reg. Created", TRUE);
        IF ACAExamResultsBuffer22.FIND('-') THEN ACAExamResultsBuffer22.DELETEALL;
        //webportals.PermissionsManagement('UPLOADMARKS', USERID);
    end;

    trigger OnModify()
    begin
        //webportals.PermissionsManagement('UPLOADMARKS', USERID);
    end;

    trigger OnRename()
    begin
        //webportals.PermissionsManagement('UPLOADMARKS', USERID);
    end;

    var
        course: Record 61532;
        ACAExamResultsBuffer22: Record 61746;
        ACASemesters: Record 61692;
}

