report 51348 "Process JAB Admissions"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("KUCCPS Imports"; "KUCCPS Imports")
        {

            trigger OnAfterGetRecord()
            var
                strNames: Text[100];
            begin
                /*This function processes the JAB admission and takes them to the Applications list*/

                SettlementType.GET('GSS');
                Applications."Application No." := "KUCCPS Imports".Index;
                // Applications.ref
                Applications.Date := TODAY;
                //SplitNames(Names,Applications.Surname,Applications."Other Names");
                Applications.Surname := "KUCCPS Imports".Names;
                Applications."Application Date" := TODAY;
                Applications.Gender := "KUCCPS Imports".Gender - 1;
                Applications."Marital Status" := Applications."Marital Status"::Single;
                Applications.Nationality := 'KENYAN';
                Applications."Address for Correspondence1" := "KUCCPS Imports".Box;
                Applications."Address for Correspondence2" := "KUCCPS Imports".Codes;
                Applications."Address for Correspondence3" := "KUCCPS Imports".Town;
                Applications."Telephone No. 1" := "KUCCPS Imports".Phone;
                Applications."Telephone No. 2" := "KUCCPS Imports"."Alt. Phone";
                Applications.Email := "KUCCPS Imports".Email;
                Applications."Emergency Email" := "KUCCPS Imports"."Slt Mail";
                Applications."Country of Origin" := 'KENYA';
                Applications."First Degree Choice" := "KUCCPS Imports".Prog;
                Applications."Date of Receipt" := TODAY;
                Applications."User ID" := USERID;
                Applications."Date of Admission" := TODAY;
                Applications."Application Form Receipt No." := '';
                Applications."Index Number" := "KUCCPS Imports".Index;
                Applications.Status := Applications.Status::"Provisional Admission";
                Applications."Admission Board Recommendation" := 'Admitted Through KUCCPS';
                Applications."Admission Board Date" := TODAY;
                Applications."Admission Board Time" := TIME;
                Applications."Admitted Degree" := "KUCCPS Imports".Prog;
                Applications."Date Of Meeting" := TODAY;
                Applications."Date Of Receipt Slip" := TODAY;
                Applications."Receipt Slip No." := '';
                Applications."Academic Year" := Year;
                Applications."Admission No" := "KUCCPS Imports".Admin;
                Applications."Admitted To Stage" := 'Y1S1';
                Applications."Admitted Semester" := semester;
                Applications."First Choice Stage" := 'Y1S1';
                Applications."First Choice Semester" := semester;
                Applications."Intake Code" := Intake;
                Applications."Settlement Type" := 'GSS';
                Applications."ID Number" := '';
                Applications."Date Sent for Approval" := TODAY;
                Applications."Issued Date" := TODAY;
                Applications.Campus := 'MAIN';
                Applications."Admissable Status" := 'QUALIFY';
                Applications."Mode of Study" := 'FULL TIME';
                Applications."Responsibility Center" := 'MAIN';
                Applications."First Choice Qualify" := TRUE;
                Applications."Programme Level" := Applications."Programme Level"::Bachelor;
                Applications."Admission Comments" := 'Admitted through the KUCCPS';
                Applications."Knew College Thru" := 'KUCCPS';
                Applications."First Choice Category" := Applications."First Choice Category"::Undergraduate;
                Applications.INSERT;
                "KUCCPS Imports".Processed := TRUE;
                "KUCCPS Imports".MODIFY;

            end;

            trigger OnPreDataItem()
            begin
                //LastFieldNo := FIELDNO("Line No.");
                IF Year = '' THEN ERROR('Please specify the academic year');
                IF Intake = '' THEN ERROR('Please specify the intake code');
                IF semester = '' THEN ERROR('Please specify the Semester');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Year; Year)
                {
                    Caption = 'Academic Year';
                    Lookup = true;
                    TableRelation = "ACA-Academic Year".Code;
                    ApplicationArea = All;
                }
                field(Intake; Intake)
                {
                    Caption = 'Intake';
                    TableRelation = "ACA-Intake".Code;
                    ApplicationArea = All;
                }
                field(semester; semester)
                {
                    Caption = 'Semester';
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        acadYears.RESET;
        acadYears.SETRANGE(acadYears.Current, TRUE);
        sems.RESET;
        sems.SETRANGE(sems."Current Semester", TRUE);
        Intakes.RESET;
        Intakes.SETRANGE(Intakes.Current, TRUE);
        IF acadYears.FIND('-') THEN Year := acadYears.Code;
        IF sems.FIND('-') THEN semester := sems.Code;
        IF Intakes.FIND('-') THEN Intake := Intakes.Code;

        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
        END;
    end;

    trigger OnPostReport()
    begin
        MESSAGE('Processed Successfully');
    end;

    trigger OnPreReport()
    begin
        IF Year = '' THEN BEGIN
            ERROR('Academic Year Missing');
        END;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;

        AdminCode: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Applications: Record 61358;
        Year: Code[20];
        LineNo: Integer;
        SettlementType: Record 61522;
        Intake: Code[20];
        semester: Code[20];
        Processed_JAB_AdmissionsCaptionLbl: Label 'Processed JAB Admissions';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        acadYears: Record 61382;
        Intakes: Record 61383;
        sems: Record 61692;
        CompanyInformation: Record 79;
        SirNamez: Code[100];
        OtherNamez: Code[100];
}

