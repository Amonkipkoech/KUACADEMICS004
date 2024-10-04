page 51576 "FAB Rejection List"
{
    CardPageID = "Admission FAB Card";
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "ACA-Applic. Form Header";
    SourceTableView = WHERE(Status = FILTER("Dean Rejected"));

    layout
    {
        area(content)
        {
            repeater("General Information")
            {
                Caption = 'General Information';
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Appeal Reason"; Rec."Appeal Reason")
                {
                    ApplicationArea = All;
                }
                field("Enquiry No"; Rec."Enquiry No")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                field("Submission Status"; Rec."Submission Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submission Status field.';
                }
                field(NationalityName; NationalityName)
                {
                    Caption = 'Nationality Desc.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Caption = 'County';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Get the name of the country of nationality*/
                        CountryOfOriginName := GetCounty(Rec.County);

                    end;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Caption = 'Settlement Type';
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
                    Caption = 'Primary Tel.';
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    Caption = 'Alt Tel.';
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
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
                    RunObject = Page "ACA-Application Form Academic";
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
                    RunObject = Page 68468;
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
                action(rgrT)
                {
                    Caption = 'Send Regret Letter';
                    Image = Reject;
                    ApplicationArea = ALL;
                    Promoted = true;
                    PromotedCategory = Category4;

                }
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
                    Caption = 'Appeal';
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
                        /*
                        //Return this code for normal application flow//>>>>
                        
                        //Release the Application for Approval
                        TESTFIELD(Surname);
                        TESTFIELD("First Degree Choice");
                        TESTFIELD("Settlement Type");
                        TESTFIELD("Intake Code");
                        TESTFIELD(Campus);
                        TESTFIELD("Application Form Receipt No.");
                        TESTFIELD("Address for Correspondence1");
                        TESTFIELD("Date Of Birth");
                        IF AppSetup.GET() THEN
                        IF (TODAY-"Date Of Birth")<(AppSetup."Minimum Age"*365) THEN ERROR('The Minimum Required Age for Admission is '+FORMAT(AppSetup."Minimum Age")+' years');
                        
                        IF CONFIRM('Send this Application for Approval?',TRUE)=FALSE THEN EXIT;
                        
                        IF "Application No." = '' THEN
                          ERROR('There are no Applicants Specified.');
                        
                        Apps.RESET;
                        Apps.SETRANGE(Apps."Application No.","Application No.");
                        Testfields;
                        IF "Application Date"=0D THEN
                          ERROR('Provide the Application Date First!');
                        IF "Application Form Receipt No."='' THEN
                          ERROR('Provide the Bank Slip number.');
                        //WITH Apps DO
                         //   BEGIN
                             "User ID":=USERID;
                             "Date of Receipt":=TODAY;
                             MODIFY;
                        //END;
                        
                        
                          State:=State::Open;
                         IF Status<>Status::"Pending Approval" THEN State:=State::"Pending Approval";
                         DocType:=DocType::"Student Applications";
                         CLEAR(tableNo);
                         tableNo:=DATABASE::"Application Form Header";
                          IF ApprovalMgt.SendApproval(tableNo,"Application No.",DocType,State) THEN BEGIN
                        MESSAGE(FORMAT(xRec.Surname)+' successfully send for Approval');
                        CurrPage.UPDATE;
                        END;
                        */
                        //This code has been used to bypass approval up to pending payments list
                        //Delete it and revert back to the above code


                        rec.TestField("Appeal Reason");
                        //TESTFIELD("Application Form Receipt No.");
                        //TESTFIELD("Address for Correspondence1");
                        //TESTFIELD("Date Of Birth");
                        IF AppSetup.GET() THEN
                            //IF (TODAY-"Date Of Birth")<(AppSetup."Minimum Age"*365) THEN ERROR('The Minimum Required Age for Admission is '+FORMAT(AppSetup."Minimum Age")+' years');

                            IF CONFIRM('Do you want to Revert the Application', TRUE) = FALSE THEN EXIT;

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
                        Rec.RevrtUserID := USERID;
                        //Rec."Date of Receipt" := TODAY;
                        Rec.Status := Rec.Status::"Pending Approval";
                        //Rec."Documents Verified" := Rec."Documents Verified"::No;
                        //Rec."Admitted Degree" := Rec."First Degree Choice";
                        Rec."Date Of Meeting" := TODAY;
                        //Rec."Admitted To Stage" := Rec."First Choice Stage";
                        // Rec."Admitted Semester" := Rec."First Choice Semester";
                        Rec."Admission Board Recommendation" := 'Appeal';
                        Rec.MODIFY;
                        //END;

                    end;
                }
                action(cancellsApproval)
                {
                    Caption = 'Send Back To SRO';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                    begin
                        IF AppSetup.GET() THEN
                            //IF (TODAY-"Date Of Birth")<(AppSetup."Minimum Age"*365) THEN ERROR('The Minimum Required Age for Admission is '+FORMAT(AppSetup."Minimum Age")+' years');

                            IF CONFIRM('Send Back to SRO?', TRUE) = FALSE THEN EXIT;

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
                        Rec.RevrtUserID := USERID;
                        //Rec."Date of Receipt" := TODAY;
                        Rec.Status := Rec.Status::Open;
                        //Rec."Documents Verified" := Rec."Documents Verified"::No;
                        //Rec."Admitted Degree" := Rec."First Degree Choice";
                        Rec."Date Of Meeting" := TODAY;
                        Rec."Process Application" := false;
                        //Rec."Admitted To Stage" := Rec."First Choice Stage";
                        // Rec."Admitted Semester" := Rec."First Choice Semester";
                        Rec."Admission Board Recommendation" := 'Qualifies for another prog' + ' ' + UserId;
                        Rec.MODIFY;
                    end;
                }



            }
        }
    }



    trigger OnInit()
    begin
        "Points AcquiredVisible" := TRUE;
        "Mean Grade AcquiredVisible" := TRUE;
        "Subsidiary PassesVisible" := TRUE;
        "Principal PassesVisible" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Settlement Type" := 'SSS';
    end;

    // trigger OnOpenPage()
    // begin
    //     usersetup.reset();
    //     usersetup.SetFilter("User ID", UserId);
    //     // usersetup.Setfilter("Global Dimension 2 Code", Rec."Programme Department");
    //     if usersetup.Find('-') then begin
    //         Rec.SetFilter("Programme Faculty", '=%1', usersetup."Shortcut Dimension 3 Code");
    //     end ELSE
    //         error('Contact your administrator')

    // end;


    var
        usersetup: Record "User Setup";
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