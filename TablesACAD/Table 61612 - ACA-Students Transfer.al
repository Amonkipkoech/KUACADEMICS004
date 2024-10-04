table 61612 "ACA-Students Transfer"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Student No"; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Student));

            trigger OnValidate()
            begin
                IF Cust.GET("Student No") THEN
                    Name := Cust.Name;
            end;
        }
        field(3; Name; Text[30])
        {
        }
        field(4; "Current Programme"; Code[30])
        {
            CalcFormula = Lookup("ACA-Course Registration".Programmes WHERE("Student No." = FIELD("Student No")));
            FieldClass = FlowField;
        }
        field(5; "New Student No"; Code[20])
        {
        }
        field(6; "New Programme"; Code[30])
        {
            TableRelation = "ACA-Programme".Code;

            trigger OnValidate()
            begin
                AdminSetup.RESET;
                AdminSetup.SETRANGE(AdminSetup.Degree, "New Programme");
                IF AdminSetup.FIND('-') THEN BEGIN
                    /*"New Student No":=NoSeriesMgt.GetNextNo(AdminSetup."No. Series",0D,TRUE);
                    "New Student No":=AdminSetup."Programme Prefix" +  '-' + "New Student No" +'/' +AdminSetup.Year;*/
                    "New Student No" := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", 0D, TRUE);
                    "New Student No" := AdminSetup."JAB Prefix" + '/' + "New Student No" + '/' + AdminSetup.Year;
                END
                ELSE BEGIN
                    ERROR('The Admission Number Setup For Programme ' + FORMAT("New Programme") + ' Does Not Exist');
                END;

            end;
        }
        field(7; Date; Date)
        {
        }
        field(8; UserId; Code[20])
        {
        }
        field(9; Posted; Boolean)
        {
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending approval",Rejected,Approved,Posted,Released;
        }
        field(11; "Agregate Points"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "HOD Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "DOS Present School"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "DOS Receiving School"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Responsibility Centre"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Responsibility Center BR".Code;
        }
        field(16; "Reason for Transfer"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Result Slip"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Semester; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Sem Reg ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Student No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Posted = TRUE THEN ERROR('Please note that you can not modify posted entry!');
    end;

    trigger OnModify()
    begin
        IF Posted = TRUE THEN ERROR('Please note that you can not modify posted entry!');
        currCourse.INIT;
        currCourse.SETRANGE("Student No.", currCourse."Admission No.");
        //currCourse.SETRANGE('',currCourse.Stage);
        IF currCourse.FIND('-') THEN
            "Current Programme" := currCourse.Programmes;
    end;

    var
        Cust: Record 18;
        AdminSetup: Record 61371;
        NoSeriesMgt: Codeunit 396;
        currCourse: Record 61532;
}

