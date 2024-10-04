table 61372 "ACA-Adm. Form Header"
{
    DrillDownPageID = 68229;
    LookupPageID = 68229;


    fields
    {
        field(1; "Admission No."; Code[20])
        {
            Description = 'Stores the admission number in the database';
            NotBlank = true;
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the admission was entered into the system';
        }
        field(3; "Admission Type"; Code[20])
        {
            Description = 'Stores the type of admission in the database';
            TableRelation = "ACA-Settlement Type";
        }
        field(4; "JAB S.No"; Code[20])
        {
            Description = 'Stores the JAB Serial No';
        }
        field(5; "Academic Year"; Code[20])
        {
            Description = 'Stores the academicyear';
            TableRelation = "ACA-Academic Year".Code;
        }
        field(6; "Application No."; Code[20])
        {
            Description = 'Stores the application number in the database';
            TableRelation = "ACA-Applic. Form Header"."Application No.";
        }
        field(7; Surname; Text[100])
        {
            Caption = 'Last Name';
            Description = 'Stores the surname of the student in the database';
            NotBlank = true;
        }
        field(8; "Other Names"; Text[100])
        {
            Caption = 'Middle Name';
            Description = 'Stores the other names of the student in the database';
            NotBlank = true;
        }
        field(9; "Faculty Admitted To"; Code[20])
        {
            Description = 'Stores the faculty the student is admitted to';
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FACULTY'));
        }
        field(10; "Degree Admitted To"; Code[20])
        {
            Description = 'Stores the degree the student is admitted to';
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;

            trigger OnValidate()
            begin
                Programme.RESET;
                IF Programme.GET("Degree Admitted To") THEN BEGIN
                    //"Faculty Admitted To":=Programme."Base Date";
                END;
            end;
        }
        field(11; "Date Of Birth"; Date)
        {
            Description = 'Stores the date of birth of the student in the database';
            NotBlank = true;
        }
        field(12; Gender; Option)
        {
            Description = 'Stores the gender of the student in the database';
            NotBlank = true;
            OptionMembers = " ",Male,Female;
        }
        field(13; "Marital Status"; Option)
        {
            Description = 'Stores the marital status of the student in the database';
            NotBlank = true;
            OptionMembers = Single,Married;
        }
        field(14; "Spouse Name"; Text[30])
        {
            Description = 'Stores the name of the spouse in the database';
        }
        field(15; "Spouse Address 1"; Text[30])
        {
            Description = 'Stores the first line of the spouse address in the database';
        }
        field(16; "Spouse Address 2"; Text[30])
        {
            Description = 'Stores the second line of the spouse address in the database';
        }
        field(17; "Spouse Address 3"; Text[30])
        {
            Description = 'Stores the third line of the spouse address in the database';
        }
        field(18; "Place Of Birth Village"; Code[20])
        {
            Description = 'Stores the village place of birth in the database';
            NotBlank = true;
        }
        field(19; "Place Of Birth Location"; Code[20])
        {
            Description = 'Stores the location place of birth in the databasse';
            NotBlank = true;
        }
        field(20; "Place Of Birth District"; Code[20])
        {
            Description = 'Stores thdistrict place of birth in the database';
            NotBlank = true;
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Districts));
        }
        field(21; "Name of Chief"; Text[30])
        {
            Description = 'Stores the name of the chief in the database';
            NotBlank = true;
        }
        field(22; "Nearest Police Station"; Text[30])
        {
            Description = 'Stores the name of the nearest police station in the database';
            NotBlank = true;
        }
        field(23; Nationality; Code[20])
        {
            Description = 'Stores the nationality of the student being admitted in the database';
            NotBlank = true;
            TableRelation = "Country/Region".Code;
        }
        field(24; Religion; Code[20])
        {
            Description = 'Stores the religion of the student in the database';
            NotBlank = true;
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Religions));
        }
        field(25; "Correspondence Address 1"; Text[100])
        {
            Description = 'Stores the first line of the correspondence address in the database';
            NotBlank = true;
        }
        field(26; "Correspondence Address 2"; Text[100])
        {
            Description = 'Stores the second line of the correspondence address in the database';
            NotBlank = true;
        }
        field(27; "Correspondence Address 3"; Text[100])
        {
            Description = 'Stores the third line of the correspondence address in the database';
            NotBlank = true;
        }
        field(28; "Telephone No. 1"; Text[30])
        {
            Description = 'Stores the first telephone number of the student in the database';
        }
        field(29; "Telephone No. 2"; Text[30])
        {
            Description = 'Stores the second telephone number of the student in the database';
        }
        field(30; "Fax No."; Text[30])
        {
            Description = 'Stores the fax number of the student in the database';
        }
        field(31; "E-Mail"; Text[100])
        {
            Description = 'Stores the email address of the student in the database';
        }
        field(32; "Mother Alive Or Dead"; Option)
        {
            Description = 'Stores the status of the mother in the database';
            OptionMembers = Alive,Deceased;
        }
        field(33; "Mother Full Name"; Text[30])
        {
            Description = 'Stores the full name of the mother in the database';
        }
        field(34; "Father Alive Or Dead"; Option)
        {
            Description = 'Stores the status of the father in the database';
            OptionMembers = Alive,Deceased;
        }
        field(35; "Father Full Name"; Text[30])
        {
            Description = 'Stores the full name of the father in the database';
        }
        field(36; "Guardian Full Name"; Text[30])
        {
            Description = 'Stores the full name of the guardian in the database';
        }
        field(37; "Mother Occupation"; Text[30])
        {
            Description = 'Stores the Occupation of the Mother in the databae';
        }
        field(38; "Father Occupation"; Text[30])
        {
            Description = 'Stores the occupation of the father in the database';
        }
        field(39; "Guardian Occupation"; Text[30])
        {
            Description = 'Stores the occupation of the guardian in the database';
        }
        field(40; "Former School Code"; Code[20])
        {
            Description = 'Stores the reference to the former school in the database';
            NotBlank = true;
            TableRelation = "ACA-Applic. Setup Fmr School".Code;
        }
        field(41; "Index Number"; Code[20])
        {
            Description = 'Stores the index number of the student in the database';
            NotBlank = true;
        }
        field(42; "Mean Grade"; Code[20])
        {
            Description = 'Stores the mean grade of the student in the database';
            NotBlank = true;
            TableRelation = "ACA-Applic. Setup Grade".Code;
        }
        field(43; "Physical Impairment Details"; Text[200])
        {
            Description = 'Stores the details of any physical impairment by the student';
        }
        field(44; "Communication to University"; Text[200])
        {
            Description = 'Stores the any information useful to communicate to the university';
        }
        field(45; Photo; BLOB)
        {
            Description = 'Stores the image of the student in the database';
        }
        field(46; Height; Decimal)
        {
            Description = 'Stores the height of the student';
        }
        field(47; Weight; Decimal)
        {
            Description = 'Stores the wieght of the student';
        }
        field(48; "Without Glasses R.6"; Decimal)
        {
        }
        field(49; "Without Glasses L.6"; Decimal)
        {
        }
        field(50; "With Glasses R.6"; Decimal)
        {
        }
        field(51; "With Glasses L.6"; Decimal)
        {
        }
        field(52; "Hearing Right Ear"; Decimal)
        {
        }
        field(53; "Hearing Left Ear"; Decimal)
        {
        }
        field(54; "Condition Of Teeth"; Text[30])
        {
        }
        field(55; "Condition Of Throat"; Text[30])
        {
        }
        field(56; "Condition Of Ears"; Text[30])
        {
        }
        field(57; "Condition Of Lymphatic Glands"; Text[30])
        {
        }
        field(58; "Condition Of Nose"; Text[30])
        {
        }
        field(59; "Circulatory System Pulse"; Text[30])
        {
        }
        field(60; "Examining Officer"; Text[30])
        {
        }
        field(61; "Medical Exam Date"; Date)
        {
        }
        field(62; "Medical Details Not Covered"; Text[200])
        {
        }
        field(63; "Emergency Consent Relationship"; Code[20])
        {
            NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(64; "Emergency Consent Full Name"; Text[30])
        {
            NotBlank = true;
        }
        field(65; "Emergency Consent Address 1"; Text[30])
        {
            NotBlank = true;
        }
        field(66; "Emergency Consent Address 2"; Text[30])
        {
        }
        field(67; "Emergency Consent Address 3"; Text[30])
        {
        }
        field(68; "Emergency Date of Consent"; Date)
        {
            NotBlank = true;
        }
        field(69; "Emergency National ID Card No."; Code[20])
        {
            Description = 'Stores the national identity card number of the person who consented to the emergency operation';
            NotBlank = true;
        }
        field(70; "Declaration Full Name"; Text[30])
        {
            Description = 'Stores the full name of the person who witnessed the declaration';
            NotBlank = true;
        }
        field(71; "Declaration Relationship"; Code[20])
        {
            Description = 'Stores the relation between the applicant and the witness';
            NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(72; "Declaration National ID No"; Code[20])
        {
            Description = 'Stores the national identity card number of the witness';
            NotBlank = true;
        }
        field(73; "Declaration Date"; Date)
        {
            Description = 'Stores the date when the declaration was signed';
            NotBlank = true;
        }
        field(74; "Acceptance Date"; Date)
        {
            Description = 'Stores the date when the acceptance letter was signed';
        }
        field(75; "Accepted ?"; Boolean)
        {
            Description = 'Stores the state of the offer whether it was accepted or rejected';
        }
        field(76; "Family Problem"; Boolean)
        {
        }
        field(77; "Health Problem"; Boolean)
        {
        }
        field(78; "Overseas Scholarship"; Boolean)
        {
        }
        field(79; "Course Not Preference"; Boolean)
        {
        }
        field(80; Employment; Boolean)
        {
        }
        field(81; "Other Reason"; Text[100])
        {
        }
        field(82; "Home District"; Code[20])
        {
        }
        field(83; "Res. District"; Code[20])
        {
        }
        field(84; Status; Option)
        {
            Description = 'Stores the status  of the admission record in the database';
            OptionCaption = 'New,Doc. Verification,Payment Verification,Filled,Admitted';
            OptionMembers = New,"Doc. Verification","Payment Verification",Filled,Admitted;
        }
        field(85; "Declaration ID Number"; Code[20])
        {
            Description = 'Stores the declaration id number';
        }
        field(86; Select; Boolean)
        {
            Description = 'Stores the state of the record in the database';
        }
        field(87; "Stage Admitted To"; Code[20])
        {
            Description = 'Stores the stage that the student is admitted to';
            TableRelation = "ACA-Programme Stages" WHERE("Programme Code" = FIELD("Degree Admitted To"));
        }
        field(88; "Semester Admitted To"; Code[20])
        {
            Description = 'Stores the semester that the student is to be admitted to';
            TableRelation = "ACA-Programme Semesters" WHERE("Programme Code" = FIELD("Degree Admitted To"));
        }
        field(89; Tribe; Code[20])
        {
            Description = 'Stores the reference to the student tribe in the database';
            //TableRelation = "HRM-Hiring Criteria"."Application Code";
        }
        field(90; "Settlement Type"; Code[20])
        {
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(91; "Intake Code"; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(92; "ID Number"; Code[20])
        {
        }
        field(93; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50000; "Documents Verified"; Boolean)
        {
        }
        field(50001; "Documents Verified By"; Code[50])
        {
        }
        field(50002; "Documents Verification Remarks"; Text[100])
        {
        }
        field(50003; "Space No"; Code[20])
        {

        }
        field(50004; "Programme Campus"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme Stages"."Campus Code" WHERE("Programme Code" = FIELD("Degree Admitted To"),
                                                                              Code = FIELD("Stage Admitted To")));
            FieldClass = FlowField;
        }
        field(50005; "Confirm Order"; Integer)
        {
        }
        field(50006; "Admission Comments"; Text[250])
        {
        }
        field(50007; Salutation; Code[10])
        {
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Titles));
        }
        field(50008; Title; Code[10])
        {
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Titles));
        }
        field(50010; "Knew Through (Other)"; Text[250])
        {

            trigger OnValidate()
            begin
                IF "Knew Through (Other)" <> '' THEN
                    "Knew College Thru" := 'OTHER'
            end;
        }
        field(50011; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CAMPUS'));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(50012; "Knew College Thru"; Text[30])
        {
            // TableRelation = Table50022.Field1;
        }
        field(50013; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50014; County; Code[20])
        {
            Description = 'Stores the district or the applicant in the database';
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Counties));
        }
        field(50015; "Research Institution"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; Languages; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "First Name"; Text[50])
        {

        }
    }

    keys
    {
        key(Key1; "Admission No.")
        {
        }
        key(Key2; "Confirm Order")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Programme: Record "ACA-Programme";
        Immunization: Record "ACA-Immunization";
        MedicalCondition: Record "ACA-Medical Condition";
        IntC: Integer;
        AdmissionMedicalCondition: Record "ACA-Students Applicants";
        AdmissionFamily: Record "ACA-Adm. Form Family Medical";
}

