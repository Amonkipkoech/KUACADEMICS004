table 61647 "ACA-Online Application"
{

    fields
    {
        field(2; "Applicant Id Number"; Code[30])
        {
            NotBlank = false;
        }
        field(3; Surname; Text[100])
        {
        }
        field(4; "Other Names"; Text[100])
        {
        }
        field(5; Level; Option)
        {
            OptionMembers = " ",Certificate,Diploma,"Higher Diploma",Undergraduate,PostGraduate,PHD;
        }
        field(6; Nationality; Code[20])
        {
        }
        field(7; Programe_Code1; Code[50])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(8; TelNo_1; Code[20])
        {
        }
        field(9; TelNo_2; Code[20])
        {
        }
        field(10; email; Text[50])
        {
        }
        field(11; BankSlipNo; Code[30])
        {
        }
        field(12; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(13; BankSlipDate; Date)
        {
        }
        field(14; Programe_Code2; Code[50])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(15; box; Text[30])
        {
        }
        field(16; "code"; Text[30])
        {
        }
        field(17; Town; Text[30])
        {
        }
        field(18; County; Code[10])
        {
        }
        field(19; BankSlipImage; BLOB)
        {
            SubType = Bitmap;
        }
        field(20; "Application Date"; Date)
        {
        }
        field(21; Intake; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(22; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Cancelled';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Cancelled;

            trigger OnValidate()
            var
                acadYear: Record 61382;
            begin
                VALIDATE("National ID");
                VALIDATE("Study Mode");
                VALIDATE("Receipt Number");
                VALIDATE("Receipt Date");
                VALIDATE(Programe_Code1);
                VALIDATE(TelNo_1);
                //VALIDATE(Intake);
                VALIDATE("Marketing Strategy");

                semz.RESET;
                semz.SETRANGE(semz."Current Semester", TRUE);
                IF semz.FIND('-') THEN BEGIN
                END;
                acadYear.RESET;
                acadYear.SETRANGE(acadYear.Current, TRUE);
                IF acadYear.FIND('-') THEN BEGIN
                END;
                IF Status = Status::Approved THEN BEGIN
                    applic.INIT;
                    applic."Application No." := "Applicant Id Number";
                    applic.Date := "Application Date";
                    applic."Application Date" := "Application Date";
                    applic.Surname := Surname;
                    applic."Other Names" := "Other Names";
                    applic."Date Of Birth" := "Date of Birth";
                    applic.Gender := Gender;
                    applic."Marital Status" := applic."Marital Status"::Married;
                    applic.Nationality := Nationality;
                    applic."Address for Correspondence1" := box;
                    applic."Telephone No. 1" := TelNo_1;
                    applic."Telephone No. 2" := TelNo_2;
                    applic."First Degree Choice" := Programe_Code1;
                    applic."Second Degree Choice" := Programe_Code2;
                    applic."Date of Receipt" := "Receipt Date";
                    applic."User ID" := USERID;
                    applic.County := County;
                    applic."Date of Admission" := TODAY;
                    applic."Application Form Receipt No." := "Receipt Number";
                    applic."No. Series" := 'APP';
                    applic.Status := applic.Status::Open;
                    applic."Date Of Receipt Slip" := "Receipt Date";
                    applic."Receipt Slip No." := "Receipt Number";
                    applic."Academic Year" := acadYear.Code;
                    applic."Admitted To Stage" := "Prog. Entry level";
                    applic."Admitted Semester" := semz.Code;
                    applic."First Choice Stage" := "Prog. Entry level";
                    applic."First Choice Semester" := semz.Code;
                    applic."Intake Code" := Intake;
                    applic."Settlement Type" := 'DIRECT';
                    applic."ID Number" := "National ID";
                    applic."Date Sent for Approval" := TODAY;
                    applic.Email := email;
                    applic.Campus := 'TOWN';
                    applic."Mode of Study" := "Study Mode";
                    applic."First Choice Qualify" := TRUE;
                    applic."Knew Through (Other)" := "Other Marketing (Specify)";
                    applic.Salutation := Title;
                    applic."Admission Comments" := "Approval Comments";
                    applic."Knew College Thru" := "Marketing Strategy";
                    //applic.Denomination:=;
                    applic.Title := Title;
                    applic."Emergency Name" := "Emergency Contact Name";
                    applic."Emergency Email" := "Emergency Contact Email";
                    applic."Emergency Telephone" := "Emergency Contact Tel";
                    applic."Emergency Fax" := "Emergency Contact Fax";
                    applic."Emergency Relationship" := "Emergency Contact Relationship";
                    applic."Got Health Insurance" := "Health Insured";
                    applic."Name of Insurer" := "Insurer Name";
                    applic."Language 1" := "Language (1)";
                    applic."Language 2" := "Language (2)";
                    applic."Country of Origin" := Nationality;
                    // applic."First Choice Category":=Level;
                    applic.INSERT;
                END;
            end;
        }
        field(23; "Marketing Strategy"; Code[60])
        {
            TableRelation = "ACA-Marketing Strategies".Code;
        }
        field(24; "Other Marketing (Specify)"; Text[250])
        {
        }
        field(25; Password; Text[30])
        {
        }
        field(26; "Application Status"; Option)
        {
            OptionCaption = 'New,Submitted,Approved,Rejected';
            OptionMembers = New,Submitted,Approved,Rejected;
        }
        field(27; "National ID"; Code[30])
        {
        }
        field(28; "Date of Birth"; Date)
        {
        }
        field(29; "Passport Number"; Code[30])
        {
        }
        field(30; "Study Mode"; Code[50])
        {
            TableRelation = "ACA-Student Types".Code;
        }
        field(31; Activated; Boolean)
        {
        }
        field(32; "Approval Comments"; Text[250])
        {
        }
        field(33; "Receipt Number"; Code[30])
        {
        }
        field(34; "Receipt Date"; Date)
        {
        }
        field(35; Title; Code[20])
        {
        }
        field(36; Fax; Code[10])
        {
        }
        field(37; "Knew us through (Name)"; Text[150])
        {
        }
        field(38; "Emergency Contact Name"; Text[150])
        {
        }
        field(39; "Emergency Contact Tel"; Text[150])
        {
        }
        field(40; "Emergency Contact Email"; Text[150])
        {
        }
        field(41; "Emergency Contact Fax"; Text[150])
        {
        }
        field(42; "Emergency Contact Relationship"; Text[150])
        {
        }
        field(43; "Health Insured"; Boolean)
        {
        }
        field(44; "Insurer Name"; Code[40])
        {
            //TableRelation = Table50076.Field1;
        }
        field(45; "Highest Institution/University"; Code[150])
        {
        }
        field(46; "Highest Qualification"; Code[30])
        {
            TableRelation = "ACA-Exam Category".Code;
        }
        field(47; "Language (1)"; Code[20])
        {
            TableRelation = Language.Code;
        }
        field(48; "Language (2)"; Code[20])
        {
            TableRelation = Language.Code;
        }
        field(49; "Present Employer (Name)"; Text[150])
        {
        }
        field(50; "Present Employer (Address)"; Text[150])
        {
        }
        field(51; "Present Employer (Telephone)"; Text[150])
        {
        }
        field(52; "Present Employer (Position)"; Text[150])
        {
        }
        field(53; "Present Employer (Email)"; Text[150])
        {
        }
        field(54; "Sponsor Name"; Text[150])
        {
        }
        field(55; "Declaration Name"; Text[150])
        {
        }
        field(56; "Declaration Date"; Date)
        {
        }
        field(57; "Date Submitted"; Date)
        {
        }
        field(58; "Prog. Entry level"; Code[20])
        {
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programe_Code1"));
        }
        field(59; "Emergency Phone"; Code[20])
        {
        }
        field(60; "No. Series"; Code[50])
        {
            Description = 'Stores the reference to the number series in the database';
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Applicant Id Number")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Applicant Id Number" = '' THEN BEGIN
            genstup.GET;
            genstup.TESTFIELD(genstup.Picture);
            //  NoSeriesMgt.InitSeries(genstup.Picture,xRec."No. Series",0D,"Applicant Id Number","No. Series");
        END;

        "Application Date" := TODAY;
    end;

    var
        genstup: Record 61534;
        applic: Record 61358;
        semz: Record 61692;
        AppSetup: Record 61367;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Apps: Record 61358;
        EnqH: Record 61348;
        modes: Code[10];
        DegreeName1: Text[100];
        DegreeName2: Text[100];
        FacultyName1: Text[100];
        FacultyName2: Text[100];
        NationalityName: Text[100];
        CountryOfOriginName: Text[100];
        Age: Text[100];
        FormerSchoolName: Text[100];
        CustEntry: Record 21;
        recProgramme: Record 61511;
        Applications: Record 61358;
        AdminSetup: Record 61371;
        NewAdminCode: Code[20];
        Admissions: Record 61372;
        ApplicationSubject: Record 61362;
        AdmissionSubject: Record 61375;
        LineNo: Integer;
        PrintAdmission: Boolean;
        MedicalCondition: Record 61379;
        Immunization: Record 61380;
        AdmissionMedical: Record 61376;
        AdmissionImmunization: Record 61378;
        AdmissionFamily: Record 61377;
        sem: Text[2];
        Campo: Code[10];
        intake: Code[10];
        prog: Record 61511;
}

