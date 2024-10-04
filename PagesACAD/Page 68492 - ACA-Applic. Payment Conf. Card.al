page 68492 "ACA-Applic. Payment Conf. Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "ACA-Applic. Form Header";
    SourceTableView = WHERE(Status = FILTER("Provisional Admission"),
                            "Documents Verified" = FILTER(true),
                            "Payments Verified" = FILTER(false));

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Editable = false;
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Enquiry No"; Rec."Enquiry No")
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
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
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
                field(NationalityName; NationalityName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Get the name of the country of nationality*/
                        CountryOfOriginName := GetCounty(Rec.County);

                    end;
                }
                field(CountryOfOriginName; CountryOfOriginName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
            }
            group("Payments Details")
            {
                Caption = 'Payments Details';
                field("Receipt Slip No."; Rec."Receipt Slip No.")
                {
                    ApplicationArea = All;
                }
                field("Date Of Receipt Slip"; Rec."Date Of Receipt Slip")
                {
                    ApplicationArea = All;
                }
            }
            group("Correspondence Address")
            {
                Editable = false;
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
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
            }
            group("First Choice")
            {
                Editable = true;
                field("First Degree Choice"; Rec."First Degree Choice")
                {
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field(School1; Rec.School1)
                {
                    Caption = 'Faculty';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(FacultyName1; FacultyName1)
                {
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
                field(FirstChoiceStageName; FirstChoiceStageName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Choice Semester"; Rec."First Choice Semester")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        FirstChoiceSemesterName := GetSemesterName(Rec."First Choice Semester");
                    end;
                }
                field(FirstChoiceSemesterName; FirstChoiceSemesterName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Second Choice")
            {
                Editable = false;
                field("Second Degree Choice"; Rec."Second Degree Choice")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Display the programme name*/
                        //DegreeName2:=GetDegree("Second Degree Choice");
                        recProgramme.RESET;
                        IF recProgramme.GET(Rec."Second Degree Choice") THEN BEGIN
                            Rec."School 2" := recProgramme."School Code";
                            FacultyName2 := Rec.GetFaculty(Rec."Second Degree Choice");
                        END;

                    end;
                }
                field("School 2"; Rec."School 2")
                {
                    Caption = 'Faculty';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Second Choice Stage"; Rec."Second Choice Stage")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SecondChoiceStageName := GetStageName(Rec."Second Choice Stage");
                    end;
                }
                field("Second Choice Semester"; Rec."Second Choice Semester")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SecondChoiceStageName := GetSemesterName(Rec."Second Choice Semester");
                    end;
                }
            }
            group(Qualifications)
            {
                Editable = false;
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
            group(Recommendations)
            {
                Editable = false;
                field(Status; Rec.Status)
                {
                    Caption = 'Approval Status';
                    Editable = false;
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
                    Promoted = false;
                    RunObject = Page 68471;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Professional Qualifications")
                {
                    Caption = 'Professional Qualifications';
                    Image = ProfileCalender;
                    Promoted = false;
                    RunObject = Page 68470;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = Employee;
                    Promoted = false;
                    RunObject = Page 68469;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Academic Referees")
                {
                    Caption = 'Academic Referees';
                    Image = CustomerContact;
                    Promoted = false;
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
                action("Generate Reg. No")
                {
                    Caption = 'Generate Reg. No';
                    Image = Filed;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Send the current record to the department approval stage*/
                        IF CONFIRM('Take Admission to Admissions Listings?', TRUE) = FALSE THEN BEGIN EXIT END;
                        /*Check if the receipt slip no is entered*/
                        /*
                        IF "Receipt Slip No."='' THEN
                          BEGIN
                           ERROR('Please ensure that the Bank Deposit slip number is inserted');
                          END;
                        {Check if the slip date is inserted}
                        IF "Date Of Receipt Slip"=0D THEN
                          BEGIN
                            ERROR('Please ensure that the Bank Deposit Slip Date is inserted');
                          END;
                         */
                        /*This function transfers the details of the applicant to the admissions database table*/

                        TransferToAdmission(Rec."Admission No");
                        Rec.Status := Rec.Status::Approved;
                        Rec.VALIDATE(Status);
                        Rec."Documents Verified" := Rec."Documents Verified"::Yes;
                        Rec."Payments Verified" := TRUE;
                        Rec.MODIFY;
                        MESSAGE('Send to pending Admissions confirmation.');

                    end;
                }
            }
        }
    }

    var
        DegreeName1: Text[200];
        DegreeName2: Text[200];
        FacultyName1: Text[200];
        FacultyName2: Text[200];
        NationalityName: Text[200];
        CountryOfOriginName: Text[200];
        Age: Text[200];
        FormerSchoolName: Text[200];
        CustEntry: Record 21;
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
        UserMgt: Codeunit 50114;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,Admission;
        ApprovalEntries: Page "Approval Entries";
        AppSetup: Record "ACA-Applic. Setup";
        SettlmentType: Record "ACA-Settlement Type";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Admissions: Record "ACA-Adm. Form Header";
        ApplicationSubject: Record "ACA-Applic. Form Academic";
        AdmissionSubject: Record "ACA-Adm. Form Academic";
        LineNo: Integer;
        PrintAdmission: Boolean;
        MedicalCondition: Record "ACA-Medical Condition";
        Immunization: Record "ACA-Immunization";
        AdmissionMedical: Record "ACA-Adm. Form Medical Form";
        AdmissionImmunization: Record "ACA-Adm. Form Immunization";
        AdmissionFamily: Record "ACA-Adm. Form Family Medical";




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
        CountySetup: Record "ACA-Applic. Setup County";
    begin
        /*This function gets the county name from the database and returns the resultant string value*/
        CountySetup.RESET;
        IF CountySetup.GET(CountyCode) THEN BEGIN
            CountyName := CountySetup.Description;
        END
        ELSE BEGIN
            CountyName := '';
        END;

    end;

    /// <summary>
    /// TransferToAdmission.
    /// </summary>
    /// <param name="AdmissionNumber">VAR Code[20].</param>
    procedure TransferToAdmission(var AdmissionNumber: Code[20])
    var
        AdminSetup: Record 61371;
        NewAdminCode: Code[20];
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/
        Rec.TESTFIELD("Settlement Type");
        SettlmentType.GET(Rec."Settlement Type");
        IF AdmissionNumber = '' THEN BEGIN
            AdminSetup.RESET;
            AdminSetup.SETRANGE(AdminSetup.Degree, Rec."First Degree Choice");
            IF AdminSetup.FIND('-') THEN BEGIN
                NewAdminCode := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", 0D, TRUE);
                NewAdminCode := AdminSetup."Programme Prefix" + '/' + NewAdminCode + '/' + AdminSetup.Year;

                //If Prefix is Needed add this code <<+ AdminSetup."SSP Prefix" >>
            END
            ELSE BEGIN
                ERROR('The Admission Number Setup For Programme ' + FORMAT(Rec."Admitted Degree") + ' Does Not Exist');
            END;
        END ELSE
            NewAdminCode := AdmissionNumber;

        /*Get the record and transfer the details to the admissions database*/
        //ERROR('TEST- '+NewAdminCode);
        /*Transfer the details into the admission database table*/
#pragma warning disable AL0606
#pragma warning restore AL0606
        /*Transfer the details into the admission database table*/
        Admissions.INIT;
        Admissions."Admission No." := NewAdminCode;
        Admissions.VALIDATE("Admission No.");
        Admissions.Date := TODAY;
        Admissions."Application No." := Rec."Application No.";
        Admissions."Admission Type" := Rec."Settlement Type";
        Admissions."Academic Year" := Rec."Academic Year";
        Admissions.Surname := Rec.Surname;
        Admissions."Other Names" := Rec."Other Names";
        Admissions.Status := Admissions.Status::New;
        Admissions."Degree Admitted To" := Rec."Admitted Degree";
        Admissions.VALIDATE("Degree Admitted To");
        Admissions."Date Of Birth" := Rec."Date Of Birth";
        Admissions.Gender := Rec.Gender + 1;
        Admissions.Campus := Rec.Campus;
        Admissions."Marital Status" := Rec."Marital Status";
        Admissions.Nationality := Rec.Nationality;
        Admissions."Correspondence Address 1" := Rec."Address for Correspondence1";
        Admissions."Correspondence Address 2" := Rec."Address for Correspondence2";
        Admissions."Correspondence Address 3" := Rec."Address for Correspondence3";
        Admissions."Telephone No. 1" := Rec."Telephone No. 1";
        Admissions."Telephone No. 2" := Rec."Telephone No. 2";
        Admissions."Former School Code" := Rec."Former School Code";
        Admissions."Index Number" := Rec."Index Number";
        Admissions."Stage Admitted To" := Rec."Admitted To Stage";
        Admissions."Semester Admitted To" := Rec."Admitted Semester";
        Admissions."Settlement Type" := Rec."Settlement Type";
        Admissions."Intake Code" := Rec."Intake Code";
        Admissions."ID Number" := Admissions."ID Number";
        Admissions.INSERT();
        Rec."Admission No" := NewAdminCode;
        /*Get the subject details and transfer the  same to the admissions subject*/
        ApplicationSubject.RESET;
        ApplicationSubject.SETRANGE(ApplicationSubject."Application No.", Rec."Application No.");
        IF ApplicationSubject.FIND('-') THEN BEGIN
            /*Get the last number in the admissions table*/
            AdmissionSubject.RESET;
            IF AdmissionSubject.FIND('+') THEN BEGIN
                LineNo := AdmissionSubject."Line No." + 1;
            END
            ELSE BEGIN
                LineNo := 1;
            END;

            /*Insert the new records into the database table*/
            REPEAT
#pragma warning disable AL0606
#pragma warning restore AL0606
                AdmissionSubject.INIT;
                AdmissionSubject."Line No." := LineNo + 1;
                AdmissionSubject."Admission No." := NewAdminCode;
                AdmissionSubject."Subject Code" := ApplicationSubject."Subject Code";
                AdmissionSubject.Grade := AdmissionSubject.Grade;
                AdmissionSubject.INSERT();
                LineNo := LineNo + 1;
            UNTIL ApplicationSubject.NEXT = 0;
        END;




        /*Insert the medical conditions into the admission database table containing the medical condition*/
        MedicalCondition.RESET;
        MedicalCondition.SETRANGE(MedicalCondition.Mandatory, TRUE);
        IF MedicalCondition.FIND('-') THEN BEGIN
            /*Get the last line number from the medical condition table for the admissions module*/
            AdmissionMedical.RESET;
            IF AdmissionMedical.FIND('+') THEN BEGIN
                LineNo := AdmissionMedical."Line No." + 1;
            END
            ELSE BEGIN
                LineNo := 1;
            END;
            AdmissionMedical.RESET;
            /*Loop thru the medical conditions*/
            REPEAT
                AdmissionMedical.INIT;
                AdmissionMedical."Line No." := LineNo + 1;
                AdmissionMedical."Admission No." := NewAdminCode;
                AdmissionMedical."Medical Condition Code" := MedicalCondition.Code;
                AdmissionMedical.INSERT();
                LineNo := LineNo + 1;
            UNTIL MedicalCondition.NEXT = 0;
        END;
        /*Insert the details into the family table*/
        MedicalCondition.RESET;
        MedicalCondition.SETRANGE(MedicalCondition.Mandatory, TRUE);
        MedicalCondition.SETRANGE(MedicalCondition.Family, TRUE);
        IF MedicalCondition.FIND('-') THEN BEGIN
            /*Get the last number in the family table*/
            AdmissionFamily.RESET;
            IF AdmissionFamily.FIND('+') THEN BEGIN
                LineNo := AdmissionFamily."Line No.";
            END
            ELSE BEGIN
                LineNo := 0;
            END;
            REPEAT
                AdmissionFamily.INIT;
                AdmissionFamily."Line No." := LineNo + 1;
                AdmissionFamily."Medical Condition Code" := MedicalCondition.Code;
                AdmissionFamily."Admission No." := NewAdminCode;
                AdmissionFamily.INSERT();
                LineNo := LineNo + 1;
            UNTIL MedicalCondition.NEXT = 0;
        END;

        /*Insert the immunization details into the database*/
        Immunization.RESET;
        //Immunization.SETRANGE(Immunization.Mandatory,TRUE);
        IF Immunization.FIND('-') THEN BEGIN
            /*Get the last line number from the database*/
            AdmissionImmunization.RESET;
            IF AdmissionImmunization.FIND('+') THEN BEGIN
                LineNo := AdmissionImmunization."Line No." + 1;
            END
            ELSE BEGIN
                LineNo := 1;
            END;
            /*loop thru the immunizations table adding the details into the admissions table for immunizations*/
            REPEAT
                AdmissionImmunization.INIT;
                AdmissionImmunization."Line No." := LineNo + 1;
                AdmissionImmunization."Admission No." := NewAdminCode;
                AdmissionImmunization."Immunization Code" := Immunization.Code;
                AdmissionImmunization.INSERT();
            UNTIL Immunization.NEXT = 0;
        END;

    end;
}

