page 68482 "ACA-Application Form Dean"
{
    PageType = Document;
    SourceTable = 61358;
    SourceTableView = WHERE(Status = FILTER("Department Approved" | "Department Rejected"));

    layout
    {
        area(content)
        {
            group("General Information")
            {
                field("Application No."; Rec."Application No.")
                {
                    Caption = 'Apptn No./Date/Rcpt No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Caption = 'Settlement Type/Academic Year';
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Display the age of the user*/
                        Age := Rec.GetAge(Rec."Date Of Birth");

                    end;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    Editable = false;
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
                field("Country of Origin"; Rec."Country of Origin")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Get the name of the country of origin name*/
                        CountryOfOriginName := Rec.GetCountry(Rec."Country of Origin");

                    end;
                }
                field(CountryOfOriginName; CountryOfOriginName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Application Form Receipt No."; Rec."Application Form Receipt No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Check if the receipt number is valid or not*/
                        CustEntry.RESET;
                        CustEntry.SETRANGE(CustEntry."Source Code", 'CASHRECJNL');
                        CustEntry.SETRANGE(CustEntry."Document No.", Rec."Application Form Receipt No.");
                        IF CustEntry.FIND('-') THEN //record has been located in the database
                          BEGIN
                            /*Check if the receipt number has been used by another student*/
                            Apps.RESET;
                            Apps.SETRANGE(Apps."Application Form Receipt No.");
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
                field(Age; Age)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Correspondence Address")
            {
                field("Address for Correspondence1"; Rec."Address for Correspondence1")
                {
                    Caption = 'Address 1';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address for Correspondence2"; Rec."Address for Correspondence2")
                {
                    Caption = 'Address 2';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address for Correspondence3"; Rec."Address for Correspondence3")
                {
                    Caption = 'Address 3';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("First Choice")
            {
                field("First Degree Choice"; Rec."First Degree Choice")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Display the name of the programme*/
                        DegreeName1 := GetDegree1(Rec."First Degree Choice");
                        recProgramme.RESET;
                        IF recProgramme.GET(Rec."First Degree Choice") THEN BEGIN
                            Rec.School1 := recProgramme.Faculty;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Choice Semester"; Rec."First Choice Semester")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Second Choice")
            {
                field("Second Degree Choice"; Rec."Second Degree Choice")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Display the programme name*/
                        DegreeName2 := GetDegree1(Rec."Second Degree Choice");
                        recProgramme.RESET;
                        IF recProgramme.GET(Rec."Second Degree Choice") THEN BEGIN
                            Rec."School 2" := recProgramme.Faculty;
                            FacultyName2 := Rec.GetFaculty(Rec."Second Degree Choice");
                        END;

                    end;
                }
                field(DegreeName2; DegreeName2)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("School 2"; Rec."School 2")
                {
                    Caption = 'Faculty';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(FacultyName2; FacultyName2)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Second Choice Stage"; Rec."Second Choice Stage")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Second Choice Semester"; Rec."Second Choice Semester")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Qualifications)
            {
                field("Former School Code"; Rec."Former School Code")
                {
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Year of Examination"; Rec."Year of Examination")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Examination Body"; Rec."Examination Body")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Examination; Rec.Examination)
                {
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Mean Grade Acquired"; Rec."Mean Grade Acquired")
                {
                    Editable = false;
                    Visible = "Mean Grade AcquiredVisible";
                    ApplicationArea = All;
                }
                field("Principal Passes"; Rec."Principal Passes")
                {
                    Editable = false;
                    Visible = "Principal PassesVisible";
                    ApplicationArea = All;
                }
                field("Points Acquired"; Rec."Points Acquired")
                {
                    Editable = false;
                    Visible = "Points AcquiredVisible";
                    ApplicationArea = All;
                }
                field("Subsidiary Passes"; Rec."Subsidiary Passes")
                {
                    Editable = false;
                    Visible = "Subsidiary PassesVisible";
                    ApplicationArea = All;
                }
            }
            group(Recommendations)
            {
                field("HOD Recommendations"; Rec."HOD Recommendations")
                {
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Admissable Status"; Rec."Admissable Status")
                {
                    ApplicationArea = All;
                }
                field("Dean Recommendations"; Rec."Dean Recommendations")
                {
                    Editable = true;
                    MultiLine = true;
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
                    RunObject = Page 68471;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Professional Qualifications")
                {
                    Caption = 'Professional Qualifications';
                    RunObject = Page 68470;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    RunObject = Page 68469;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Academic Referees")
                {
                    Caption = 'Academic Referees';
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
                action("Mark as Approved")
                {
                    Caption = 'Mark as Approved';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Send the current record to the department approval stage*/
                        IF CONFIRM('Mark the Application as Approved?', TRUE) = FALSE THEN BEGIN EXIT END;
                        Rec.Status := Rec.Status::"Dean Approved";
                        Rec."Dean User ID" := USERID;
                        Rec."Dean Date" := TODAY;
                        Rec."Dean Time" := TIME;
                        Rec.MODIFY;
                        MESSAGE('The Application has been sent to the Next Approval Level');

                    end;
                }
                action("Mark as Rejected")
                {
                    Caption = 'Mark as Rejected';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Send the current record to the department approval stage*/
                        IF CONFIRM('Mark the Application as Rejected?', TRUE) = FALSE THEN BEGIN EXIT END;
                        Rec.Status := Rec.Status::"Dean Rejected";
                        Rec."Dean User ID" := USERID;
                        Rec."Dean Date" := TODAY;
                        Rec."Dean Time" := TIME;
                        Rec.MODIFY;
                        MESSAGE('The Application has been marked as REJECTED');

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
        [InDataSet]
        "Principal PassesVisible": Boolean;
        [InDataSet]
        "Subsidiary PassesVisible": Boolean;
        [InDataSet]
        "Mean Grade AcquiredVisible": Boolean;
        [InDataSet]
        "Points AcquiredVisible": Boolean;
        Text19047369: Label 'PERSONAL DETAILS';
        Text19055215: Label 'DEGREE CHOICES';
        Text19074524: Label 'Head of Department Recommendations';
        Text19064842: Label 'School Recommendations';


    procedure GetDegree1(var DegreeCode: Code[20]) DegreeName: Text[200]
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
}

