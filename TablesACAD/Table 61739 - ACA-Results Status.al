table 61739 "ACA-Results Status"
{
    DrillDownPageID = 68244;
    LookupPageID = 68244;

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[200])
        {
        }
        field(3; "Students Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Filter"),
                                                                 "Academic Year" = FIELD("Academic Year"),
                                                                 Faculty = FIELD("Faculty Filter"),
                                                                 "Exam Status" = FIELD(Code)));
            //"Year Of Study" = FIELD("Year of Study Filter")));
            FieldClass = FlowField;
        }
        field(4; "Programme Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(5; "Stage Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(6; "Semester Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(7; "Status Msg1"; Text[200])
        {
        }
        field(8; "Status Msg2"; Text[200])
        {
        }
        field(9; "Status Msg3"; Text[200])
        {
        }
        field(10; "Status Msg4"; Text[200])
        {
        }
        field(11; "Status Msg5"; Text[200])
        {
        }
        field(12; "Order No"; Integer)
        {
        }
        field(13; "Student Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Full Time,Part Time,Distance Learning';
            OptionMembers = "Full Time","Part Time","Distance Learning";

            trigger OnValidate()
            begin
                /*
                IF "Registration Date" <> 0D THEN BEGIN
                "Settlement Type":='FULL PAYMENT';
                VALIDATE("Settlement Type");
                END;
                */

            end;
        }
        field(14; "Show Reg. Remarks"; Boolean)
        {
        }
        field(15; "Manual Status Processing"; Boolean)
        {
        }
        field(50000; Semester; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(50001; Prefix; Code[20])
        {
        }
        field(50002; "Session Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Intake".Code;
        }
        field(50003; "Campus Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CAMPUS'));
        }
        field(50004; "Students Count Cumm"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD("Programme Filter"),
                                                                 Semester = FIELD(Semester),
                                                                 Stage = FIELD("Stage Filter"),
                                                                 "Cumm Status" = FIELD(Code),
                                                                 Reversed = CONST(false),
                                                                 Session = FIELD("Session Filter"),
                                                                 "Cust Exist" = FILTER(> 0),
                                                                 Blocked = CONST(0),
                                                                 "Units Taken" = FILTER(> 0),
                                                                 Reversed = CONST(false),
                                                                 "Campus Filter" = FIELD("Campus Filter")));
            FieldClass = FlowField;
        }
        field(50005; "Status Msg6"; Text[200])
        {
        }
        field(50006; "IncludeVariable 1"; Boolean)
        {
        }
        field(50007; "IncludeVariable 2"; Boolean)
        {
        }
        field(50008; "IncludeVariable 3"; Boolean)
        {
        }
        field(50009; "IncludeVariable 4"; Boolean)
        {
        }
        field(50010; "IncludeVariable 5"; Boolean)
        {
        }
        field(50011; "IncludeVariable 6"; Boolean)
        {
        }
        field(50012; "Minimum Units Failed"; Decimal)
        {
            Caption = 'Minimum Fails';
        }
        field(50013; "Maximum Units Failed"; Decimal)
        {
            Caption = 'Maximum Fails';
        }
        field(63020; Status; Option)
        {
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate";
        }
        field(63021; "Summary Page Caption"; Text[150])
        {
        }
        field(63022; "Include Failed Units Headers"; Boolean)
        {
        }
        field(63023; "Fails Based on"; Option)
        {
            OptionCaption = 'Unit Count,Percentage Fail';
            OptionMembers = "Unit Count","Percentage Fail";
        }
        field(63024; "Transcript Remarks"; Code[100])
        {
        }
        field(63025; "Final Year Comment"; Text[200])
        {
        }
        field(63026; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(63027; "Min/Max Based on"; Option)
        {
            OptionCaption = 'Courses,Percentage (%),Credit Hours';
            OptionMembers = Courses,"Percentage (%)","Credit Hours";
        }
        field(63028; "Include Academic Year Caption"; Boolean)
        {
        }
        field(63029; "Academic Year Text"; Text[150])
        {
        }
        field(63030; "Faculty Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(63031; "Year of Study Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(63032; Pass; Boolean)
        {
        }
        field(63033; "Supp. Lubric Caption"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63034; "Supp. Lubric Caption 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63035; "Supp. Lubric Caption 3"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63036; "Supp. Lubric Caption 4"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63037; "Supp. Lubric Caption 5"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63038; "Supp. Lubric Caption 6"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63039; "Special Programme Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Medicine & Nursing,Engineering';
            OptionMembers = General,"Medicine & Nursing",Engineering;

            trigger OnValidate()
            var
                ACAUnitsSubjects: Record 61517;
            begin
            end;
        }
        field(63040; "Special Programme Scope"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Entire Programme,Cores,Cores & Electives,Electives,Required,Common';
            OptionMembers = "Entire Programme",Cores,"Cores & Electives",Electives,Required,Common;
        }
        field(63041; "Include no. of Repeats"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63042; "Min. Unit Repeat Counts"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63043; "Max. Unit Repeat Counts"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63044; "Maximum Academic Repeat"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63045; "Lead Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63046; "Minimum Academic Repeats"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63047; "Minimum Core Fails"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63048; "Maximum Core Fails"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63049; "Minimum None-Core Fails"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63050; "Maximum None-Core Fails"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63051; "1st Year Grad. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63052; "2nd Year Grad. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63053; "3rd Year Grad. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63054; "4th Year Grad. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63055; "5th Year Grad. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63056; "6th Year Grad. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63057; "7th Year Grad. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63058; "Finalists Grad. Comm. Degree"; Text[150])
        {
            Caption = 'Finalist Graduation Comments (Degree)';
            DataClassification = ToBeClassified;
        }
        field(63059; "Grad. Status Msg 1"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63060; "Grad. Status Msg 2"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63061; "Grad. Status Msg 3"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63062; "Grad. Status Msg 4"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63063; "Grad. Status Msg 5"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63064; "Grad. Status Msg 6"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63065; "Finalists Grad. Comm. Dip"; Text[150])
        {
            Caption = 'Finalist Graduation Comments (Diploma)';
            DataClassification = ToBeClassified;
        }
        field(63066; "Finalists Grad. Comm. Cert."; Text[150])
        {
            Caption = 'Finalist Graduation Comments (Certificate)';
            DataClassification = ToBeClassified;
        }
        field(63067; "1st Year Trans. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63068; "2nd Year  Trans. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63069; "3rd Year  Trans. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63070; "4th Year  Trans. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63071; "5th Year  Trans. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63072; "6th Year  Trans. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63073; "7th Year  Trans. Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Academic Year", "Special Programme Class")
        {
        }
        key(Key2; "Order No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF ((USERID <> 'APPKINGS') AND (USERID <> 'APPK1\ADMINISTRATOR')) THEN ERROR('ACCESS DENIED');
    end;

    trigger OnInsert()
    begin
        IF ((USERID <> 'APPKINGS') AND (USERID <> 'APPK1\ADMINISTRATOR')) THEN ERROR('ACCESS DENIED');
    end;

    trigger OnModify()
    begin
        IF ((USERID <> 'APPKINGS') AND (USERID <> 'APPK1\ADMINISTRATOR')) THEN ERROR('ACCESS DENIED');
    end;

    trigger OnRename()
    begin
        IF ((USERID <> 'APPKINGS') AND (USERID <> 'APPK1\ADMINISTRATOR')) THEN ERROR('ACCESS DENIED');
    end;
}

