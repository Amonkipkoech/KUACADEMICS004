table 61357 "ACA-Clearance Header"
{
    //LookupPageID = 68814;

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Stores the reference code of the clearnace in the database';
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the application for clearance is inserted into the database';
        }
        field(3; "Date Completed"; Date)
        {
            Description = 'Stores the completion date of the student in relation to the course in the database';
        }
        field(4; "Student No."; Code[20])
        {
            Description = 'Stores the reference of the student number in the database';
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Student));
        }
        field(5; Programme; Code[20])
        {
            Description = 'Stores the reference of the programme in the database';
            TableRelation = "ACA-Programme".Code;
        }
        field(7; Remarks; Text[250])
        {
            Description = 'Stores any remarks that the user might make in relation to the clearance';
        }
        field(8; "Library Clearance Remarks"; Text[250])
        {
            Description = 'Stores the remarks that the user makes in relation to the library clearance in the database';
        }
        field(9; "Library Clearance ID"; Code[20])
        {
            Description = 'Stores the identifier of the person who cleared the student in the library';
        }
        field(10; "Library Clearance Date"; Date)
        {
            Description = 'Stores the date when  the library clearance was done';
        }
        field(11; "Library Clearance Time"; Time)
        {
            Description = 'Stores the time when the clearance was updated in the database';
        }
        field(12; "Sports Clearance Remarks"; Text[250])
        {
            Description = 'Stores the remarks that the user makes in relation to the clearance in the sports department';
        }
        field(13; "Sports Clearance ID"; Code[20])
        {
            Description = 'Stores the id of the user who cleared the student in the sports department';
        }
        field(14; "Sports Clearance Date"; Date)
        {
            Description = 'Stores the date when the sports department cleared the student in the database';
        }
        field(15; "Sports Clearance Time"; Time)
        {
            Description = 'Stores the time when the student was cleared in the sports department';
        }
        field(16; "Finance Clearance Remarks"; Text[250])
        {
            Description = 'Stores any remarks that the user makes in relation to the student clearance in the finance department';
        }
        field(17; "Finance Clearance ID"; Code[20])
        {
            Description = 'Stores the identifier of the person doing the clearance in the finance department';
        }
        field(18; "Finance Clearance Date"; Date)
        {
            Description = 'Stores the date when the student was cleared in the database';
        }
        field(19; "Finance Clearance Time"; Time)
        {
            Description = 'Stores the time when the student is cleared within the finance department';
        }
        field(20; "Registrar Clearance Remarks"; Text[250])
        {
            Description = 'Stores any remarks in the database that user might make in relation to the student';
        }
        field(21; "Registrar Clearance ID"; Code[20])
        {
            Description = 'Stores the id of the user who cleared the student in the faculty';
        }
        field(22; "Registrar Clearance Date"; Date)
        {
            Description = 'Stores the date when the faculty clearance was done in the database';
        }
        field(23; "Registrar Clearance Time"; Time)
        {
            Description = 'Stores the time when the clearance was done in the database';
        }
        field(24; Status; Option)
        {
            Description = 'Stores the status of the clearance form i.e New,Pending,Cleared,Completed';
            OptionMembers = New,Pending,Cleared,Completed;
        }
        field(25; "Student Signature"; Boolean)
        {
            Description = 'Stores the state of the of the record whether the student has signed the document or not';
        }
        field(26; "Books Lost"; Decimal)
        {
            Description = 'Stores the number of books lost';
        }
        field(27; "Library Card No."; Code[20])
        {
            CalcFormula = Lookup(Customer."Library Code" WHERE("No." = FIELD("Student No.")));
            Description = 'Stores the library card number in the database';
            FieldClass = FlowField;
        }
        field(28; "Library Amount"; Decimal)
        {
            Description = 'Stores the library amount owing in the database in relation to the library department';
        }
        field(29; "Library Other Charges"; Decimal)
        {
            Description = 'Stores any other charges in relation to the library';
        }
        field(30; "Fees Amount"; Decimal)
        {
            CalcFormula = Lookup(Customer."Balance (LCY)" WHERE("No." = FIELD("Student No.")));
            Description = 'Stores the fees amount owing in the database';
            FieldClass = FlowField;
        }
        field(32; "Library Cleared"; Boolean)
        {
        }
        field(33; "Sports Cleared"; Boolean)
        {
        }
        field(34; "Finance Cleared"; Boolean)
        {
        }
        field(35; "Registrar Cleared"; Boolean)
        {
        }
        field(36; "No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(37; "Catering Clearance Remarks"; Text[250])
        {
            Description = 'Stores the remarks that the user makes in relation to the clearance in the sports department';
        }
        field(38; "Catering Clearance ID"; Code[20])
        {
            Description = 'Stores the id of the user who cleared the student in the sports department';
        }
        field(39; "Catering Clearance Date"; Date)
        {
            Description = 'Stores the date when the sports department cleared the student in the database';
        }
        field(40; "Catering Clearance Time"; Time)
        {
            Description = 'Stores the time when the student was cleared in the sports department';
        }
        field(41; "Hostel Clearance Remarks"; Text[250])
        {
            Description = 'Stores the remarks that the user makes in relation to the clearance in the sports department';
        }
        field(42; "Hostel Clearance ID"; Code[20])
        {
            Description = 'Stores the id of the user who cleared the student in the sports department';
        }
        field(43; "Hostel Clearance Date"; Date)
        {
            Description = 'Stores the date when the sports department cleared the student in the database';
        }
        field(44; "Hostel Clearance Time"; Time)
        {
            Description = 'Stores the time when the student was cleared in the sports department';
        }
        field(45; "Deans Clearance Remarks"; Text[250])
        {
            Description = 'Stores the remarks that the user makes in relation to the clearance in the sports department';
        }
        field(46; "Deans Clearance ID"; Code[20])
        {
            Description = 'Stores the id of the user who cleared the student in the sports department';
        }
        field(47; "Deans Clearance Date"; Date)
        {
            Description = 'Stores the date when the sports department cleared the student in the database';
        }
        field(48; "Deans Clearance Time"; Time)
        {
            Description = 'Stores the time when the student was cleared in the sports department';
        }
        field(49; "Catering Cleared"; Boolean)
        {
        }
        field(50; "Hostel Cleared"; Boolean)
        {
        }
        field(53; "Department Clearance Remarks"; Text[250])
        {
            Description = 'Stores the remarks that the user makes in relation to the clearance in the sports department';
        }
        field(54; "Department Clearance ID"; Code[20])
        {
            Description = 'Stores the id of the user who cleared the student in the sports department';
        }
        field(55; "Department Clearance Date"; Date)
        {
            Description = 'Stores the date when the sports department cleared the student in the database';
        }
        field(56; "Department Clearance Time"; Time)
        {
            Description = 'Stores the time when the student was cleared in the sports department';
        }
        field(57; "School Cleared"; Boolean)
        {
        }
        field(58; "Deans Cleared"; Boolean)
        {
        }
        field(59; "Department Cleared"; Boolean)
        {
        }
        field(60; "School Clearance Remarks"; Text[250])
        {
            Description = 'Stores the remarks that the user makes in relation to the clearance in the sports department';
        }
        field(61; "School Clearance ID"; Code[20])
        {
            Description = 'Stores the id of the user who cleared the student in the sports department';
        }
        field(62; "School Clearance Date"; Date)
        {
            Description = 'Stores the date when the sports department cleared the student in the database';
        }
        field(63; "School Clearance Time"; Time)
        {
            Description = 'Stores the time when the student was cleared in the sports department';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD("Clearance Nos");
            //NoSeriesMgt.InitSeries(GLSetup."Clearance Nos",xRec."No. Series",0D,"No.","No. Series");
        END;
    end;

    var
        GLSetup: Record 61534;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

