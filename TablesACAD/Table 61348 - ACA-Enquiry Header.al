table 61348 "ACA-Enquiry Header"
{
    DrillDownPageID = 68293;
    LookupPageID = 68293;

    fields
    {
        field(1; "Enquiry No."; Code[20])
        {
            Description = 'Stores the unique identifier of the enquiry in the database';
        }
        field(2; "Enquiry Date"; Date)
        {
            Description = 'Stores the date of the enquiry in the database';
        }
        field(3; "Name(Surname First)"; Text[60])
        {
            Description = 'Stores the name of the person making the enquiry in the database. Starting with the surname first';
            NotBlank = true;
        }
        field(4; "Date of Birth"; Date)
        {
            Description = 'Stores the date of birth of the person making the enquiry in the database';

            trigger OnValidate()
            begin
                IF "Date of Birth" > CALCDATE('-15Y', TODAY) THEN
                    ERROR('Invalid Date Of Birth.');
            end;
        }
        field(5; Gender; Option)
        {
            Description = 'Stores the gender of the person making the enquiry in the database. Can only be Male or Female no in betweens';
            OptionMembers = "Select Gender Here",Male,Female;

            trigger OnValidate()
            begin
                IF Gender = Gender::"Select Gender Here" THEN BEGIN
                    ERROR('Please ensure that the Gender is selected');
                END;
            end;
        }
        field(6; "Passport/National ID Number"; Text[30])
        {
            Description = 'Stores the passport or the national identity number of the person making the enquiry in the database';

            trigger OnValidate()
            begin
                VALIDATE(Gender);
            end;
        }
        field(7; "Permanent Home Address"; Text[250])
        {
            Description = 'Stores the permanent home address of the person making the enquiry in the database';

            trigger OnValidate()
            begin
                VALIDATE(Gender);
            end;
        }
        field(8; "Correspondence Address"; Text[250])
        {
            Description = 'Stores the correspondence home address of the person making the enquiry in the database';

            trigger OnValidate()
            begin
                VALIDATE(Gender);
            end;
        }
        field(9; "Home Telephone No."; Text[30])
        {
            Description = 'Stores the home telephone number of the person in the database';

            trigger OnValidate()
            begin
                VALIDATE(Gender);
            end;
        }
        field(10; "Office Telephone No."; Text[30])
        {
            Description = 'Stores the office telephone number of the persion making the enquiry';
        }
        field(11; "Mobile Number"; Text[30])
        {
            Description = 'Stores the mobile number of the person making the enquiry in the database';
        }
        field(12; "Fax Number"; Text[30])
        {
            Description = 'Stores the fax number of the person making the enquiry in the database';
        }
        field(13; "Email Address"; Text[100])
        {
            Description = 'Stores the email address of the person making the enquiry in the database';
        }
        field(14; Programmes; Code[20])
        {
            Description = 'Stores the reference code of the programme that the person is enquiring about';
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;

            trigger OnValidate()
            begin
                //Default Stage and semeter
                ProgStages.RESET;
                ProgStages.SETRANGE(ProgStages."Programme Code", Programmes);
                if ProgStages.FIND('-') THEN BEGIN
                    "Programme Stage" := ProgStages.Code;
                    VALIDATE("Programme Stage")
                END;


                PSemester.RESET;
                PSemester.SETRANGE(PSemester."Programme Code", Programmes);
                PSemester.SETRANGE(PSemester.Current, TRUE);
                if PSemester.FIND('-') THEN BEGIN
                    Semester := PSemester.Semester;
                    VALIDATE(Semester);
                END;
            end;
        }
        field(15; "Programme Stage"; Code[20])
        {
            Description = 'Stores the reference code of the programme stage that the person is enquiring about';
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(16; Semester; Code[20])
        {
            Description = 'Stores the reference of the semester that the person is enquirying about';
            NotBlank = true;
            TableRelation = "ACA-Semesters".Code;
        }
        field(17; Status; Option)
        {
            Description = 'Stores the status of the enquiry in the database';
            OptionMembers = New,Pending,Eligible,"Not Eligible",Admit,Admitted;
        }
        field(18; "No. Series"; Code[20])
        {
        }
        field(19; "Application Fee Receipt No."; Text[30])
        {
            NotBlank = true;
        }
        field(20; "Application Form Filled"; Boolean)
        {
        }
        field(21; "Student Type"; Option)
        {
            OptionMembers = "Full Time","Part Time","Distance Learning";
        }
        field(22; Surname; Text[20])
        {

            trigger OnValidate()
            begin
                //ensure that the surname is the first name in the full name field in relation to the student
                "Name(Surname First)" := Surname + ' ' + "Other Names";
            end;
        }
        field(23; "Other Names"; Text[40])
        {

            trigger OnValidate()
            begin
                //ensure that the surname is the first name in the full name field in relation to the student
                "Name(Surname First)" := Surname + ' ' + "Other Names";
            end;
        }
        field(24; "Ref No"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."OLD No." WHERE("Student No." = FIELD("Registration No")));
            FieldClass = FlowField;
        }
        field(25; "Registration No"; Code[20])
        {
        }
        field(26; "Registrar Approved"; Option)
        {
            OptionCaption = ' ,Admissible,Not Admissible';
            OptionMembers = " ",Admissible,"Not Admissible";
        }
        field(27; Intake; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(28; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(29; "Mode of Study"; Code[20])
        {
            TableRelation = "ACA-Student Types".Code;
        }
        field(30; "Application  No."; Code[30])
        {
        }
        field(31; "Converted To Application"; Boolean)
        {
        }
        field(32; Closed; Boolean)
        {
        }
        field(50000; "How You knew about us"; Code[50])
        {
            TableRelation = "ACA-Marketing Strategies".Code;
        }
        field(50001; "Inquiry Mode"; Option)
        {
            OptionCaption = ' ,Phone,Email,Online,Physical,Fax';
            OptionMembers = " ",Phone,Email,Online,Physical,Fax;
        }
        field(50002; Nationality; Code[50])
        {
            Description = 'Stores the nationality of the applicant in the database';
            TableRelation = "Country/Region".Code;
        }
        field(50004; "Query"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Enquiry No.")
        {
        }
        key(Key2; Programmes, "Registrar Approved")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Enquiry No." = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD("Enquiry Nos");
            NoSeriesMgt.InitSeries(GLSetup."Enquiry Nos", xRec."No. Series", 0D, "Enquiry No.", "No. Series");
        END;
    end;

    var
        GLSetup: Record "ACA-General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ProgStages: Record "ACA-Programme Stages";
        PSemester: Record "ACA-Programme Semesters";
}

