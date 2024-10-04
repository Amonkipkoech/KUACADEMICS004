/// <summary>
/// Page ACA-Application Form Header a (ID 50059).
/// </summary>
/// <summary>
/// Page ACA-Application Form Header a (ID 50059).
/// </summary>
page 50059 "ACA-Application Form Header a"
{
    PageType = Document;
    SourceTable = 61358;

    layout
    {
        area(content)
        {
            group("General Information")
            {
                field("Application No."; Rec."Application No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Enquiry No"; Rec."Enquiry No")
                {
                    ApplicationArea = All;
                }
                field(Salutation; Rec.Salutation)
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Application Form Receipt No."; Rec."Application Form Receipt No.")
                {
                    Caption = 'Receipt No.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Check if the receipt number is valid or not
                        EXIT;
                        CustEntry.RESET;
                        //CustEntry.SETRANGE(CustEntry."Source Code",'CASHRECJNL');
                        CustEntry.SETRANGE(CustEntry."Document No.", Rec."Application Form Receipt No.");
                        IF CustEntry.FIND('-') THEN //record has been located in the database
                          BEGIN
                            /*Check if the receipt number has been used by another student*/
                            Apps.RESET;
                            Apps.SETRANGE(Apps."Application Form Receipt No.", Rec."Application Form Receipt No.");
                            IF Apps.FIND('-') THEN BEGIN
                                REPEAT
                                    IF Apps."Application No." <> Rec."Application No." THEN BEGIN
                                        ERROR('Receipt Number already utilised within the System by Application No.' + FORMAT(Apps."Application No."));
                                    END;
                                UNTIL Apps.NEXT = 0;
                            END;
                        END
                        ELSE//record not located within the database
                          BEGIN
                            ERROR('Receipt Number not located within Valid Receipts');
                        END;

                    end;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Mode of Study"; Rec."Mode of Study")
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Display the age of the user*/
                        Age := Rec.GetAge(Rec."Date Of Birth");

                    end;
                }
                field(Age; Age)
                {
                    Caption = 'Age';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Caption = 'ID Number';
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    Caption = 'Nationality';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Get the name of the country of nationality*/
                        NationalityName := Rec.GetCountry(Rec.Nationality);

                    end;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Caption = 'Admission Type';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Date Of Receipt Slip"; Rec."Date Of Receipt Slip")
                {
                    ApplicationArea = All;
                }
                field("Programme Level"; Rec."Programme Level")
                {
                    ApplicationArea = All;
                }
                field("Knew College Thru"; Rec."Knew College Thru")
                {
                    Caption = 'Knew College Through';
                    ApplicationArea = All;
                }
            }
            group("Correspondence Address")
            {
                field("Address for Correspondence1"; Rec."Address for Correspondence1")
                {
                    Caption = 'Address 1';
                    ApplicationArea = All;
                }
                field("Address for Correspondence2"; Rec."Address for Correspondence2")
                {
                    Caption = 'Address 2';
                    ApplicationArea = All;
                }
                field("Address for Correspondence3"; Rec."Address for Correspondence3")
                {
                    Caption = 'Address 3';
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    Caption = 'Telephone 1';
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    Caption = 'Telephone 2';
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
            }
            group("First Choice")
            {
                field("First Degree Choice"; Rec."First Degree Choice")
                {
                    Caption = 'First Degree Code';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Display the name of the programme*/
                        //DegreeName1:=GetDegree("First Degree Choice");
                        recProgramme.RESET;
                        IF recProgramme.GET(Rec."First Degree Choice") THEN BEGIN
                            DegreeName1 := recProgramme.Description;
                            Rec.School1 := recProgramme."School Code";
                            FacultyName1 := Rec.GetFaculty(Rec."First Degree Choice");
                        END;

                    end;
                }
                field(DegreeName1; DegreeName1)
                {
                    Caption = 'Degree Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Choice Stage"; Rec."First Choice Stage")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        FirstChoiceStageName := GetStageName(Rec."First Choice Stage");
                    end;
                }
                field("First Choice Semester"; Rec."First Choice Semester")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        FirstChoiceSemesterName := GetSemesterName(Rec."First Choice Semester");
                    end;
                }
            }
            group(Qualifications)
            {
                field("Former School Code"; Rec."Former School Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Display the name of the former school*/
                        FormerSchoolName := Rec.GetFormerSchool(Rec."Former School Code");

                    end;
                }
                field(FormerSchoolName; FormerSchoolName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date of Admission"; Rec."Date of Admission")
                {
                    ApplicationArea = All;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = All;
                }
                field("Year of Examination"; Rec."Year of Examination")
                {
                    ApplicationArea = All;
                }
                field("Examination Body"; Rec."Examination Body")
                {
                    ApplicationArea = All;
                }
                field(Examination; Rec.Examination)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (Rec.Examination = Rec.Examination::KCSE) OR (Rec.Examination = Rec.Examination::KCE) OR (Rec.Examination = Rec.Examination::EACE) THEN BEGIN
                            "Principal PassesVisible" := FALSE;
                            "Subsidiary PassesVisible" := FALSE;
                            "Mean Grade AcquiredVisible" := TRUE;
                            "Points AcquiredVisible" := TRUE;
                        END
                        ELSE BEGIN
                            "Principal PassesVisible" := TRUE;
                            "Subsidiary PassesVisible" := TRUE;
                            "Mean Grade AcquiredVisible" := FALSE;
                            "Points AcquiredVisible" := FALSE;
                        END;
                    end;
                }
                field("Index Number"; Rec."Index Number")
                {
                    ApplicationArea = All;
                }
                field("Mean Grade Acquired"; Rec."Mean Grade Acquired")
                {
                    Visible = "Mean Grade AcquiredVisible";
                    ApplicationArea = All;
                }
                field("Principal Passes"; Rec."Principal Passes")
                {
                    Visible = "Principal PassesVisible";
                    ApplicationArea = All;
                }
                field("Subsidiary Passes"; Rec."Subsidiary Passes")
                {
                    Visible = "Subsidiary PassesVisible";
                    ApplicationArea = All;
                }
                field("Points Acquired"; Rec."Points Acquired")
                {
                    Visible = "Points AcquiredVisible";
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Documents)
            {
                Caption = 'Documents';
                action("Academic Background Subjects")
                {
                    Caption = 'Academic Background Subjects';
                    Image = History;
                    Promoted = true;
                    RunObject = Page 68471;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Professional Qualifications")
                {
                    Caption = 'Professional Qualifications';
                    Image = ProfileCalender;
                    RunObject = Page 68470;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = Employee;
                    RunObject = Page 68469;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Academic Referees")
                {
                    Caption = 'Academic Referees';
                    Image = CustomerContact;
                    RunObject = Page "ACA-Application Form Acad. Ref";
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    ApplicationArea = All;
                    RunObject = page "Fin-Approval Entries";
                    RunPageLink = "Document No." = field("Application No.");
                }
                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                    begin
                        //Release the Application for Approval
                        Rec.TESTFIELD(Surname);
                        Rec.TESTFIELD("First Degree Choice");
                        Rec.TESTFIELD("Settlement Type");
                        Rec.TESTFIELD("Intake Code");
                        Rec.TESTFIELD(Campus);
                        //TESTFIELD("Application Form Receipt No.");
                        //TESTFIELD("Address for Correspondence1");
                        //TESTFIELD("Date Of Birth");
                        IF AppSetup.GET() THEN
                            //IF (TODAY-"Date Of Birth")<(AppSetup."Minimum Age"*365) THEN ERROR('The Minimum Required Age for Admission is '+FORMAT(AppSetup."Minimum Age")+' years');

                            IF CONFIRM('Send this Application for Approval?', TRUE) = FALSE THEN EXIT;

                        IF Rec."Application No." = '' THEN
                            ERROR('There are no Applicants Specified.');

                        Apps.RESET;
                        Apps.SETRANGE(Apps."Application No.", Rec."Application No.");

                        IF Rec."Application Date" = 0D THEN
                            ERROR('Provide the Application Date First!');
                        //IF "Application Form Receipt No."='' THEN
                        //  ERROR('Provide the Bank Slip number.');
                        //WITH Apps DO
                        //   BEGIN
                        Rec."User ID" := USERID;
                        Rec."Date of Receipt" := TODAY;
                        Rec."Documents Verified" := Rec."Documents Verified"::Yes;
                        Rec.Status := Rec.Status::"Provisional Admission";
                        Rec.MODIFY;
                        //END;

                        /*
                          State:=State::Open;
                         IF Status<>Status::Open THEN State:=State::"Pending Approval" ;
                         DocType:=DocType::"Student Applications";
                         CLEAR(tableNo);
                         tableNo:=DATABASE::"Application Form Header";
                          IF ApprovalMgt.SendApproval(tableNo,"Application No.",DocType,State) THEN BEGIN
                        MESSAGE(FORMAT(xRec.Surname)+' successfully send for Approval');
                        CurrPage.UPDATE;
                        END;
                        */

                    end;
                }
                action(cancellsApproval)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                    begin
                        DocType := DocType::"Student Applications";
                        showmessage := TRUE;
                        ManualCancel := TRUE;
                        CLEAR(tableNo);
                        tableNo := DATABASE::"ACA-Applic. Form Header";
                        // IF ApprovalMgt.CancelApproval(tableNo, DocType, Rec."Application No.", showmessage, ManualCancel) THEN;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //  OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Points AcquiredVisible" := TRUE;
        "Mean Grade AcquiredVisible" := TRUE;
        "Subsidiary PassesVisible" := TRUE;
        "Principal PassesVisible" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Settlement Type" := 'SSP';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //  OnAfterGetCurrRecord;
    end;

    var
        DegreeName1: Text[200];
        DegreeName2: Text[200];
        FacultyName1: Text[200];
        FacultyName2: Text[200];
        NationalityName: Text[200];
        CountryOfOriginName: Text[200];
        Age: Text[200];
        FormerSchoolName: Text[200];
        CustEntry: Record "Cust. Ledger Entry";
        Apps: Record "ACA-Applic. Form Header";
        recProgramme: Record "ACA-Programme";
        FirstChoiceSemesterName: Text[200];
        FirstChoiceStageName: Text[200];
        SecondChoiceSemesterName: Text[200];
        SecondChoiceStageName: Text[200];
        [InDataSet]
        "Principal PassesVisible": Boolean;
        [InDataSet]
        "Subsidiary PassesVisible": Boolean;
        [InDataSet]
        "Mean Grade AcquiredVisible": Boolean;
        [InDataSet]
        "Points AcquiredVisible": Boolean;
        Text19076066: Label 'Personal Details';
        Text19060472: Label 'Degree Choices';
        Text19037194: Label 'Academic Background';
        UserMgt: Codeunit 50114;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,Admission;
        ApprovalEntries: Page "Approval Entries";
        AppSetup: Record "ACA-Applic. Setup";
        AdmissionsQualif: Codeunit 50140;
        EnqH: Record "ACA-Enquiry Header";

    /// <summary>
    /// GetCountry.
    /// </summary>
    /// <param name="CountryCode">VAR Code[20].</param>
    /// <returns>Return variable CountryName of type Text[30].</returns>
#pragma warning disable AL0523
    procedure GetCountry(var CountryCode: Code[20]) CountryName: Text[30]
#pragma warning restore AL0523
    var
        Country: Record "Country/Region";
    begin
        /*This function gets the country name from the database and returns the resultant string value*/
        Country.RESET;
        IF Country.GET(CountryCode) THEN BEGIN
            CountryName := Country.Name;
        END
        ELSE BEGIN
            CountryName := '';
        END;

    end;

    /// <summary>
    /// GetDegree.
    /// </summary>
    /// <param name="DegreeCode">VAR Code[20].</param>
    /// <returns>Return variable DegreeName of type Text[200].</returns>
#pragma warning disable AL0523
    procedure GetDegree(var DegreeCode: Code[20]) DegreeName: Text[200]
#pragma warning restore AL0523
    var
        Programme: Record "ACA-Programme";
    begin
        /*This function gets the programme name and returns the resultant string*/
        Programme.RESET;
        IF Programme.GET(DegreeCode) THEN BEGIN
            DegreeName := Programme.Description;
        END
        ELSE BEGIN
            DegreeName := '';
        END;

    end;

    /// <summary>
    /// GetFaculty.
    /// </summary>
    /// <param name="DegreeCode">VAR Code[20].</param>
    /// <returns>Return variable FacultyName of type Text[200].</returns>
#pragma warning disable AL0523
    procedure GetFaculty(var DegreeCode: Code[20]) FacultyName: Text[200]
#pragma warning restore AL0523
    var
        Programme: Record "ACA-Programme";
        DimVal: Record "Dimension Value";
    begin
        /*The function gets and returns the faculty name to the calling client*/
        FacultyName := '';
        Programme.RESET;
        IF Programme.GET(DegreeCode) THEN BEGIN
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Dimension Code", 'COURSE');
            DimVal.SETRANGE(DimVal.Code, Programme."School Code");
            IF DimVal.FIND('-') THEN BEGIN
                FacultyName := DimVal.Name;
            END;
        END;

    end;

    /// <summary>
    /// GetAge.
    /// </summary>
    /// <param name="StartDate">VAR Date.</param>
    /// <returns>Return variable AgeText of type Text[200].</returns>
#pragma warning disable AL0523
    procedure GetAge(var StartDate: Date) AgeText: Text[200]
#pragma warning restore AL0523
    var
        HrDates: Codeunit "ACA-Dates";
    begin
        /*This function gets the age of the applicant and returns the resultant age to the calling client*/
        AgeText := '';
        IF StartDate = 0D THEN BEGIN StartDate := TODAY END;
        AgeText := HrDates.DetermineAge(StartDate, TODAY);

    end;

    /// <summary>
    /// getFormerSchool.
    /// </summary>
    /// <param name="FormerSchoolCode">VAR Code[20].</param>
    /// <returns>Return variable FormerSchoolName of type Text[200].</returns>
#pragma warning disable AL0523
    procedure getFormerSchool(var FormerSchoolCode: Code[20]) FormerSchoolName: Text[200]
#pragma warning restore AL0523
    var
        FormerSchool: Record "ACA-Applic. Setup Fmr School";
    begin
        /*This function gets the description of the former school and returns the result to the calling client*/
        FormerSchool.RESET;
        FormerSchoolName := '';
        IF FormerSchool.GET(FormerSchoolCode) THEN BEGIN
            FormerSchoolName := FormerSchool.Description;
        END;

    end;

    /// <summary>
    /// GetStageName.
    /// </summary>
    /// <param name="StageCode">VAR Code[20].</param>
    /// <returns>Return variable StageName of type Text[200].</returns>
    procedure GetStageName(var StageCode: Code[20]) StageName: Text[200]
    var
        Stage: Record "ACA-Programme Stages";
    begin
        Stage.RESET;
        Stage.SETRANGE(Stage.Code, StageCode);
        IF Stage.FIND('-') THEN BEGIN
            StageName := Stage.Description;
        END;
    end;

    /// <summary>
    /// GetSemesterName.
    /// </summary>
    /// <param name="SemesterCode">VAR Code[20].</param>
    /// <returns>Return variable SemesterName of type Text[200].</returns>
    procedure GetSemesterName(var SemesterCode: Code[20]) SemesterName: Text[200]
    var
        Semester: Record "ACA-Semesters";
    begin
        Semester.RESET;
        Semester.SETRANGE(Semester.Code, SemesterCode);
        IF Semester.FIND('-') THEN BEGIN
            SemesterName := Semester.Description;
        END;
    end;

    /// <summary>
    /// GetCounty.
    /// </summary>
    /// <param name="CountyCode">VAR Code[20].</param>
    /// <returns>Return variable CountyName of type Text[100].</returns>
    procedure GetCounty(var CountyCode: Code[20]) CountyName: Text[100]
    var
        CountySetup: Record "ACA-Academics Central Setups";
    begin
        /*This function gets the county name from the database and returns the resultant string value*/
        CountySetup.RESET;
        CountySetup.SETRANGE(CountySetup."Title Code", CountyCode);
        CountySetup.SETRANGE(CountySetup.Category, CountySetup.Category::Countries);
        IF CountySetup.FIND('-') THEN BEGIN
            CountyName := CountySetup.Description;
        END
        ELSE BEGIN
            CountyName := '';
        END;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Age := Rec.GetAge(Rec."Date Of Birth");
        NationalityName := Rec.GetCountry(Rec.Nationality);
        CountryOfOriginName := Rec.GetCountry(Rec."Country of Origin");
        //DegreeName1:=GetDegree("First Degree Choice");
        //DegreeName2:=GetDegree("Second Degree Choice");
        FacultyName1 := Rec.GetFaculty(Rec."First Degree Choice");
        FacultyName2 := Rec.GetFaculty(Rec."Second Degree Choice");
        FormerSchoolName := Rec.GetFormerSchool(Rec."Former School Code");
        IF (Rec.Examination = Rec.Examination::KCSE) OR (Rec.Examination = Rec.Examination::KCE) OR (Rec.Examination = Rec.Examination::EACE) THEN BEGIN
            "Principal PassesVisible" := FALSE;
            "Subsidiary PassesVisible" := FALSE;
            "Mean Grade AcquiredVisible" := TRUE;
            "Points AcquiredVisible" := TRUE;
        END
        ELSE BEGIN
            "Principal PassesVisible" := TRUE;
            "Subsidiary PassesVisible" := TRUE;
            "Mean Grade AcquiredVisible" := FALSE;
            "Points AcquiredVisible" := FALSE;
        END;
    end;

    /// <summary>
    /// Testfields.
    /// </summary>
    procedure Testfields()
    begin
        //
        Rec.TESTFIELD("Application Date");
        Rec.TESTFIELD("Date Of Receipt Slip");
        Rec.TESTFIELD("Intake Code");
        Rec.TESTFIELD("Knew College Thru");
        Rec.TESTFIELD("Issued Date");
        Rec.TESTFIELD("Settlement Type");
        Rec.TESTFIELD("Academic Year");
        Rec.TESTFIELD("Programme Level");
        Rec.TESTFIELD("Address for Correspondence1");
        Rec.TESTFIELD("First Degree Choice");
        Rec.TESTFIELD("First Choice Stage");
        Rec.TESTFIELD("First Choice Semester");
        //Personal Details
        Rec.TESTFIELD(Surname);
        Rec.TESTFIELD("Other Names");
        Rec.TESTFIELD("Date Of Birth");
        //TESTFIELD(Gender);
        Rec.TESTFIELD(Nationality);
        //TESTFIELD(Salutation);
        Rec.TESTFIELD("ID Number");
        //TESTFIELD("Marital Status");
    end;
}

