/// <summary>
/// Page ACA-Pending Payments List (ID 68522).
/// </summary>
page 68522 "ACA-Pending Payments List"
{
    CardPageID = "ACA-Applic. Payment Conf. Card";
    PageType = List;
    SourceTable = "ACA-Applic. Form Header";
    SourceTableView = WHERE(Status = FILTER("Provisional Admission"),
                            "Documents Verified" = FILTER(true),
                            "Payments Verified" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Admission No"; Rec."Admission No")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
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
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field("Country of Origin"; Rec."Country of Origin")
                {
                    ApplicationArea = All;
                }
                field("Address for Correspondence1"; Rec."Address for Correspondence1")
                {
                    ApplicationArea = All;
                }
                field("Address for Correspondence2"; Rec."Address for Correspondence2")
                {
                    ApplicationArea = All;
                }
                field("Address for Correspondence3"; Rec."Address for Correspondence3")
                {
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
                field("First Degree Choice"; Rec."First Degree Choice")
                {
                    ApplicationArea = All;
                }
                field(School1; Rec.School1)
                {
                    ApplicationArea = All;
                }
                field("Second Degree Choice"; Rec."Second Degree Choice")
                {
                    ApplicationArea = All;
                }
                field("School 2"; Rec."School 2")
                {
                    ApplicationArea = All;
                }
                field("Date of Receipt"; Rec."Date of Receipt")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Former School Code"; Rec."Former School Code")
                {
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
                field("Mean Grade Acquired"; Rec."Mean Grade Acquired")
                {
                    ApplicationArea = All;
                }
                field("Points Acquired"; Rec."Points Acquired")
                {
                    ApplicationArea = All;
                }
                field("Principal Passes"; Rec."Principal Passes")
                {
                    ApplicationArea = All;
                }
                field("Subsidiary Passes"; Rec."Subsidiary Passes")
                {
                    ApplicationArea = All;
                }
                field(Examination; Rec.Examination)
                {
                    ApplicationArea = All;
                }
                field("Application Form Receipt No."; Rec."Application Form Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Index Number"; Rec."Index Number")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("HOD User ID"; Rec."HOD User ID")
                {
                    ApplicationArea = All;
                }
                field("HOD Date"; Rec."HOD Date")
                {
                    ApplicationArea = All;
                }
                field("HOD Time"; Rec."HOD Time")
                {
                    ApplicationArea = All;
                }
                field("HOD Recommendations"; Rec."HOD Recommendations")
                {
                    ApplicationArea = All;
                }
                field("Dean User ID"; Rec."Dean User ID")
                {
                    ApplicationArea = All;
                }
                field("Dean Date"; Rec."Dean Date")
                {
                    ApplicationArea = All;
                }
                field("Dean Time"; Rec."Dean Time")
                {
                    ApplicationArea = All;
                }
                field("Dean Recommendations"; Rec."Dean Recommendations")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Batch Date"; Rec."Batch Date")
                {
                    ApplicationArea = All;
                }
                field("Batch Time"; Rec."Batch Time")
                {
                    ApplicationArea = All;
                }
                field("Admission Board Recommendation"; Rec."Admission Board Recommendation")
                {
                    ApplicationArea = All;
                }
                field("Admission Board Date"; Rec."Admission Board Date")
                {
                    ApplicationArea = All;
                }
                field("Admission Board Time"; Rec."Admission Board Time")
                {
                    ApplicationArea = All;
                }
                field("Admitted Degree"; Rec."Admitted Degree")
                {
                    ApplicationArea = All;
                }
                field("Admitted Department"; Rec."Admitted Department")
                {
                    ApplicationArea = All;
                }
                field("Deferred Until"; Rec."Deferred Until")
                {
                    ApplicationArea = All;
                }
                field("Date Of Meeting"; Rec."Date Of Meeting")
                {
                    ApplicationArea = All;
                }
                field("Date Of Receipt Slip"; Rec."Date Of Receipt Slip")
                {
                    ApplicationArea = All;
                }
                field("Receipt Slip No."; Rec."Receipt Slip No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admitted To Stage"; Rec."Admitted To Stage")
                {
                    ApplicationArea = All;
                }
                field("Admitted Semester"; Rec."Admitted Semester")
                {
                    ApplicationArea = All;
                }
                field("First Choice Stage"; Rec."First Choice Stage")
                {
                    ApplicationArea = All;
                }
                field("First Choice Semester"; Rec."First Choice Semester")
                {
                    ApplicationArea = All;
                }
                field("Second Choice Stage"; Rec."Second Choice Stage")
                {
                    ApplicationArea = All;
                }
                field("Second Choice Semester"; Rec."Second Choice Semester")
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Date Sent for Approval"; Rec."Date Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Post Graduate"; Rec."Post Graduate")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field("Admissable Status"; Rec."Admissable Status")
                {
                    ApplicationArea = All;
                }
                field("Mode of Study"; Rec."Mode of Study")
                {
                    ApplicationArea = All;
                }
                field("Enquiry No"; Rec."Enquiry No")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Admit/NotAdmit"; Rec."Admit/NotAdmit")
                {
                    ApplicationArea = All;
                }
                field("Documents Verified"; Rec."Documents Verified")
                {
                    ApplicationArea = All;
                }
                field("Documents Verification Remarks"; Rec."Documents Verification Remarks")
                {
                    ApplicationArea = All;
                }
                field("Medical Verified"; Rec."Medical Verified")
                {
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
                    RunObject = Page "ACA-Application Form Academic";
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Professional Qualifications")
                {
                    Caption = 'Professional Qualifications';
                    Image = ProfileCalender;
                    Promoted = false;
                    RunObject = Page "ACA-Application Form Qualif.";
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = Employee;
                    Promoted = false;
                    RunObject = Page "ACA-Application Form Employ.";
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Academic Referees")
                {
                    Caption = 'Academic Referees';
                    Image = CustomerContact;
                    Promoted = false;
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
                        Rec."Documents Verified" :=   Rec."Documents Verified"::Yes;
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

        SettlmentType: Record "ACA-Settlement Type";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApplicationSubject: Record "ACA-Applic. Form Academic";
        AdmissionSubject: Record "ACA-Adm. Form Academic";
        LineNo: Integer;
        PrintAdmission: Boolean;
        MedicalCondition: Record "ACA-Medical Condition";
        Immunization: Record "ACA-Immunization";
        AdmissionMedical: Record "ACA-Adm. Form Medical Form";
        AdmissionImmunization: Record "ACA-Adm. Form Immunization";
        AdmissionFamily: Record "ACA-Adm. Form Family Medical";



    procedure GetDegree1(var DegreeCode: Code[20]) DegreeName: Text[100]
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


    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Age := Rec.GetAge(Rec."Date Of Birth");
        NationalityName := Rec.GetCountry(Rec.Nationality);
        CountryOfOriginName := Rec.GetCountry(Rec."Country of Origin");
        DegreeName1 := GetDegree1(Rec."First Degree Choice");
        DegreeName2 := GetDegree1(Rec."Second Degree Choice");
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

    procedure TransferToAdmission(var AdmissionNumber: Code[20])
    var
        AdminSetup: Record "ACA-Adm. Number Setup";
        NewAdminCode: Code[20];
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/
        Rec.TESTFIELD("Settlement Type");
        SettlmentType.GET(Rec."Settlement Type");
        IF AdmissionNumber = '' THEN BEGIN
            AdminSetup.RESET;
            AdminSetup.SETRANGE(AdminSetup.Degree, Rec."Admitted Degree");
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
        Rec.INIT;
        Admissions."Admission No." := NewAdminCode;
        Admissions.VALIDATE("Admission No.");
        Rec.Date := TODAY;
        Rec."Application No." := Rec."Application No.";
        Admissions."Admission Type" := Rec."Settlement Type";
        Rec."Academic Year" := Rec."Academic Year";
        Rec.Surname := Rec.Surname;
        Rec."Other Names" := Rec."Other Names";
        Rec.Status := Rec.Status::open;
        Admissions."Degree Admitted To" := Rec."Admitted Degree";
        Admissions.VALIDATE("Degree Admitted To");
        Rec."Date Of Birth" := Rec."Date Of Birth";
        Rec.Gender := Rec.Gender + 1;
        Rec."Marital Status" := Rec."Marital Status";
        Rec.Campus := Rec.Campus;
        Rec.Nationality := Rec.Nationality;
        Admissions."Correspondence Address 1" := Rec."Address for Correspondence1";
        Admissions."Correspondence Address 2" := Rec."Address for Correspondence2";
        Admissions."Correspondence Address 3" := Rec."Address for Correspondence3";
        Rec."Telephone No. 1" := Rec."Telephone No. 1";
        Rec."Telephone No. 2" := Rec."Telephone No. 2";
        Rec."Former School Code" := Rec."Former School Code";
        Rec."Index Number" := Rec."Index Number";
        Admissions."Stage Admitted To" := Rec."Admitted To Stage";
        Admissions."Semester Admitted To" := Rec."Admitted Semester";
        Rec."Settlement Type" := Rec."Settlement Type";
        Rec."Intake Code" := Rec."Intake Code";
        Rec."ID Number" := Rec."ID Number";
        Rec.INSERT();
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
                Rec.INIT;
                AdmissionSubject."Line No." := LineNo + 1;
                AdmissionSubject."Admission No." := NewAdminCode;
                AdmissionSubject."Subject Code" := ApplicationSubject."Subject Code";
                AdmissionSubject.Grade := AdmissionSubject.Grade;
                Rec.INSERT();
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

    var
        Admissions: Record "ACA-Adm. Form Header";
}

