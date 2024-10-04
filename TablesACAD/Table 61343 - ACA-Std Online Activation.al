table 61343 "ACA-Std Online Activation"
{
    Caption = 'Employee';
    // DrillDownPageID = 68423;
    // LookupPageID = 68423;

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                /*
                IF "No." <> xRec."No." THEN BEGIN
                  salessetup.GET;
                  NoSeriesMgt.TestManual(salessetup."Stud Application");
                  "No. Series" := '';
                END;
                */

            end;
        }
        field(2; "First Name"; Text[80])
        {
        }
        field(3; "Middle Name"; Text[50])
        {
        }
        field(4; "Last Name"; Text[50])
        {

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
            end;
        }
        field(5; Initials; Text[15])
        {
        }
        field(7; "Search Name"; Code[50])
        {
        }
        field(8; "Postal Address"; Text[80])
        {
        }
        field(9; "Residential Address"; Text[80])
        {
        }
        field(10; City; Text[30])
        {
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; County; Text[30])
        {
        }
        field(13; "Home Phone Number"; Text[30])
        {
        }
        field(14; "Cellular Phone Number"; Text[30])
        {
        }
        field(15; "Work Phone Number"; Text[30])
        {
        }
        field(16; "Ext."; Text[7])
        {
        }
        field(17; "E-Mail"; Text[80])
        {
        }
        field(19; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(20; "ID Number"; Text[30])
        {
        }
        field(21; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(22; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(23; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
#pragma warning disable AL0717
        field(24; Comment; Boolean)
#pragma warning restore AL0717
        {
            // CalcFormula = Exist("FIN-Staff Advanc Surr. Details" WHERE (Surrender Doc No.=CONST(0),
            //                                                             Account No:=FIELD(No.)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Fax Number"; Text[30])
        {
        }
        field(26; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(27; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(28; "First Language (R/W/S)"; Code[10])
        {
            // TableRelation = "HRM-Language Preference".Code;
        }
        field(29; "Driving Licence"; Code[10])
        {
            // TableRelation = "HRM-Job Responsiblities (B)".Field1;
        }
        field(30; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
        }
        field(31; "Health Assesment?"; Boolean)
        {
        }
        field(32; "Health Assesment Date"; Date)
        {
        }
        field(33; "Date Of Birth"; Date)
        {
        }
        field(34; Age; Text[80])
        {
        }
        field(35; "Second Language (R/W/S)"; Code[10])
        {
            //TableRelation = "HRM-Language Preference".Code;
        }
        field(36; "Additional Language"; Code[10])
        {
            //TableRelation = "HRM-Language Preference".Code;
        }
        field(37; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(38; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(39; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(40; "Postal Address2"; Text[30])
        {
        }
        field(41; "Postal Address3"; Text[20])
        {
        }
        field(42; "Residential Address2"; Text[30])
        {
        }
        field(43; "Residential Address3"; Text[20])
        {
        }
        field(44; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(45; Citizenship; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(46; "Disabling Details"; Text[50])
        {
        }
        field(47; "Disability Grade"; Text[30])
        {
        }
        field(48; "Passport Number"; Text[30])
        {
        }
        field(49; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(51; Region; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(52; "First Language Read"; Boolean)
        {
        }
        field(53; "First Language Write"; Boolean)
        {
        }
        field(54; "First Language Speak"; Boolean)
        {
        }
        field(55; "Second Language Read"; Boolean)
        {
        }
        field(56; "Second Language Write"; Boolean)
        {
        }
        field(57; "Second Language Speak"; Boolean)
        {
        }
        field(58; "PIN Number"; Code[20])
        {
        }
        field(59; "Job Applied For"; Code[20])
        {
            Editable = false;
        }
        field(60; "Need Code"; Code[20])
        {
            //TableRelation = "HRM-Recruitment Needs (B)"."Need Code" WHERE (Approved=CONST(Yes));

            trigger OnValidate()
            begin
                // Needs.RESET;
                // Needs.SETRANGE(Needs."Need Code","Need Code");
                // IF Needs.FIND('-') THEN
                // "Job Applied For":=Needs."Job ID";
            end;
        }
#pragma warning disable AL0717
        field(61; "Total Score"; Decimal)
#pragma warning restore AL0717
        {
            // CalcFormula = Sum("HRM-Applicants Qualification"."Score ID" WHERE ("Employee No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(62; Shortlist; Boolean)
        {
        }
        field(63; Employ; Boolean)
        {
        }
        field(64; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(65; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(66; "Employee No"; Code[20])
        {
            //TableRelation = "HRM-Employee C".No.;

            trigger OnValidate()
            begin
                Employee.RESET;
                Employee.SETRANGE(Employee."No.", "Employee No");
                IF Employee.FIND('-') THEN BEGIN
                    "First Name" := Employee."First Name";
                    "Middle Name" := Employee."Middle Name";
                    "Last Name" := Employee."Last Name";
                    Initials := Employee.Initials;
                    "Search Name" := Employee."Search Name";
                    "Postal Address" := Employee."Postal Address";
                    "Residential Address" := Employee."Residential Address";
                    City := Employee.City;
                    "Post Code" := Employee."Post Code";
                    County := Employee.County;
                    "Home Phone Number" := Employee."Home Phone Number";
                    "Cellular Phone Number" := Employee."Cellular Phone Number";
                    "Work Phone Number" := Employee."Work Phone Number";
                    "Ext." := Employee."Ext.";
                    "E-Mail" := Employee."E-Mail";
                    "ID Number" := Employee."ID Number";
                    Gender := Employee.Gender;
                    "Country Code" := Employee."Country Code";
                    "Fax Number" := Employee."Fax Number";
                    "Marital Status" := Employee."Marital Status";
                    //"Ethnic Origin" := Employee."Ethnic Origin";
                    "First Language (R/W/S)" := Employee."First Language (R/W/S)";
                    "Driving Licence" := Employee."Driving Licence";
                    Disabled := Employee.Disabled;
                    "Health Assesment?" := Employee."Health Assesment?";
                    "Health Assesment Date" := Employee."Health Assesment Date";
                    "Date Of Birth" := Employee."Date Of Birth";
                    Age := Employee.Age;
                    "Second Language (R/W/S)" := Employee."Second Language (R/W/S)";
                    "Additional Language" := Employee."Additional Language";
                    "Postal Address2" := Employee."Postal Address2";
                    "Postal Address3" := Employee."Postal Address3";
                    "Residential Address2" := Employee."Residential Address2";
                    "Residential Address3" := Employee."Residential Address3";
                    "Post Code2" := Employee."Post Code2";
                    Citizenship := Employee.Citizenship;
                    "Passport Number" := Employee."Passport Number";
                    "First Language Read" := Employee."First Language Read";
                    "First Language Write" := Employee."First Language Write";
                    "First Language Speak" := Employee."First Language Speak";
                    "Second Language Read" := Employee."Second Language Read";
                    "Second Language Write" := Employee."Second Language Write";
                    "Second Language Speak" := Employee."Second Language Speak";
                    "PIN Number" := Employee."PIN Number";
                    "Country Code" := Employee."Country Code";
                    "Applicant Type" := "Applicant Type"::Internal;

                    EmpQualifications.RESET;
                    EmpQualifications.SETRANGE(EmpQualifications."Employee No.", Employee."No.");
                    IF EmpQualifications.FIND('-') THEN BEGIN
                        REPEAT
                        // AppQualifications."Employee No." := "No.";
                        // AppQualifications."Qualification Type" := EmpQualifications.Type;
                        // AppQualifications."Qualification Code" := EmpQualifications."Qualification Code";
                        // AppQualifications."From Date" := EmpQualifications."From Date";
                        // AppQualifications."To Date" := EmpQualifications."To Date";
                        // AppQualifications.Type := EmpQualifications.Type;
                        // AppQualifications.Description := EmpQualifications.Description;
                        // AppQualifications."Institution/Company" := EmpQualifications."Institution/Company";
                        // AppQualifications.Qualification := EmpQualifications."Qualification Code";
                        // //AppQualifications."Score ID":=EmpQualifications."Score ID";
                        // AppQualifications.Comment := EmpQualifications.Comment;
                        // AppQualifications.INSERT(TRUE);

                        UNTIL EmpQualifications.NEXT = 0
                    END
                END
            end;
        }
        field(67; "Applicant Type"; Option)
        {
            Editable = false;
            OptionCaption = 'External,Internal';
            OptionMembers = External,Internal;
        }
        field(68; Activate; Boolean)
        {
        }
        field(69; "Course Requested"; Text[100])
        {
        }
        field(70; Password; Text[50])
        {
        }
        field(71; Qualifications; Text[250])
        {
        }
        field(72; "Email Comments"; Text[250])
        {
        }
        field(73; "Activation Date"; DateTime)
        {
        }
        field(74; "Enquiry Date"; DateTime)
        {
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
        /*
        IF "No." = '' THEN BEGIN
          salessetup.GET;
          salessetup.TESTFIELD(salessetup."Stud Application");
          NoSeriesMgt.InitSeries(salessetup."Stud Application",xRec."No. Series",0D,"No.","No. Series");
        END;
        */

    end;

    var
        //Needs: Record "HRM-Recruitment Needs (B)";
        Employee: Record 61188;
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpQualifications: Record "Employee Qualification";
        //AppQualifications: Record 61314;
        AppSeriesGet: Record 61342;
        salessetup: Record 311;
}

