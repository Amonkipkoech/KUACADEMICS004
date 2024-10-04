page 68230 "ACA-Admissions Card"
{
    PageType = Document;
    SourceTable = "ACA-Adm. Form Header";
    SourceTableView = WHERE(Status = CONST(New));

    layout
    {
        area(content)
        {
            group("Student Personal Details")
            {
                Caption = 'Student Personal Details';
                field("Admission Type"; Rec."Admission Type")
                {
                    Caption = 'Admission Type/No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                /* field(; '')
                {
                    CaptionClass = Text19069419;
                    Style = Standard;
                    StyleExpr = TRUE;
                } */
                field("Admission No."; Rec."Admission No.")
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
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Degree Admitted To"; Rec."Degree Admitted To")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetDegreeName(Rec."Degree Admitted To", DegreeName);
                    end;
                }
                field(DegreeName; DegreeName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Stage Admitted To"; Rec."Stage Admitted To")
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetAge(Rec."Date Of Birth", AgeText);
                    end;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Former School Code"; Rec."Former School Code")
                {
                    Caption = 'Last School Code';
                    ApplicationArea = All;
                }
                field(FormerSchoolName; FormerSchoolName)
                {
                    Caption = 'Last School Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Index Number"; Rec."Index Number")
                {
                    ApplicationArea = All;
                }
                field("Mean Grade"; Rec."Mean Grade")
                {
                    ApplicationArea = All;
                }
                field("Semester Admitted To"; Rec."Semester Admitted To")
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetCountry(Rec.Nationality, NationalityName);
                    end;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Check the mariatl status of the student*/
                        IF Rec."Marital Status" = Rec."Marital Status"::Single THEN BEGIN
                            /*Disable the spouse details*/
                            "Spouse NameEnable" := FALSE;
                            "Spouse Address 1Enable" := FALSE;
                            "Spouse Address 2Enable" := FALSE;
                            "Spouse Address 3Enable" := FALSE;
                        END
                        ELSE BEGIN
                            /*Enable the spouse details*/
                            "Spouse NameEnable" := TRUE;
                            "Spouse Address 1Enable" := TRUE;
                            "Spouse Address 2Enable" := TRUE;
                            "Spouse Address 3Enable" := TRUE;
                        END;

                    end;
                }
                field(NationalityName; NationalityName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetReligionName(Rec.Religion, ReligionName);
                    end;
                }
                field(Photo; Rec.Photo)
                {
                    ApplicationArea = All;
                }
            }
            group("Spouse details if married")
            {
                Caption = 'Spouse details if married';
                field("Spouse Name"; Rec."Spouse Name")
                {
                    Enabled = "Spouse NameEnable";
                    ApplicationArea = All;
                }
                field("Spouse Address 1"; Rec."Spouse Address 1")
                {
                    Enabled = "Spouse Address 1Enable";
                    ApplicationArea = All;
                }
                field("Spouse Address 2"; Rec."Spouse Address 2")
                {
                    Enabled = "Spouse Address 2Enable";
                    ApplicationArea = All;
                }
                field("Spouse Address 3"; Rec."Spouse Address 3")
                {
                    Enabled = "Spouse Address 3Enable";
                    ApplicationArea = All;
                }
            }
            group("Place Of Birth")
            {
                Caption = 'Place Of Birth';
                /* field(; '')
                {
                    CaptionClass = Text19073905;
                    Style = Standard;
                    StyleExpr = TRUE;
                } */
                field(Tribe; Rec.Tribe)
                {
                    ApplicationArea = All;
                }
                field("Place Of Birth Village"; Rec."Place Of Birth Village")
                {
                    ApplicationArea = All;
                }
                field("Place Of Birth Location"; Rec."Place Of Birth Location")
                {
                    ApplicationArea = All;
                }
                field("Place Of Birth District"; Rec."Place Of Birth District")
                {
                    ApplicationArea = All;
                }
                field("Name of Chief"; Rec."Name of Chief")
                {
                    ApplicationArea = All;
                }
                field("Nearest Police Station"; Rec."Nearest Police Station")
                {
                    ApplicationArea = All;
                }
                field("Physical Impairment Details"; Rec."Physical Impairment Details")
                {
                    ApplicationArea = All;
                }
                field("Communication to University"; Rec."Communication to University")
                {
                    ApplicationArea = All;
                }
            }
            group("Correspondence Address")
            {
                Caption = 'Correspondence Address';
                field("Correspondence Address 1"; Rec."Correspondence Address 1")
                {
                    ApplicationArea = All;
                }
                field("Correspondence Address 2"; Rec."Correspondence Address 2")
                {
                    ApplicationArea = All;
                }
                field("Correspondence Address 3"; Rec."Correspondence Address 3")
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
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                /*  field(; '')
                 {
                     CaptionClass = Text19059485;
                     Style = Standard;
                     StyleExpr = TRUE;
                 } */
                field("Declaration Full Name"; Rec."Declaration Full Name")
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field("Declaration Relationship"; Rec."Declaration Relationship")
                {
                    Caption = 'Relationship';
                    ApplicationArea = All;
                }
                field("Declaration National ID No"; Rec."Declaration National ID No")
                {
                    Caption = 'National Identity Card No.';
                    ApplicationArea = All;
                }
                field("Declaration Date"; Rec."Declaration Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Mother/Father/Guardian Details")
            {
                Caption = 'Mother/Father/Guardian Details';
                field("Mother Alive Or Dead"; Rec."Mother Alive Or Dead")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Check if the mother or the father is alive or dead*/
                        IF (Rec."Mother Alive Or Dead" = Rec."Mother Alive Or Dead"::Deceased) AND (Rec."Father Alive Or Dead" = Rec."Father Alive Or Dead"::Deceased) THEN BEGIN
                            /*Disable the guardian details*/
                            "Guardian Full NameEnable" := NOT FALSE;
                            "Guardian OccupationEnable" := NOT FALSE;
                        END
                        ELSE
                            IF (Rec."Mother Alive Or Dead" = Rec."Mother Alive Or Dead"::Alive) AND (Rec."Father Alive Or Dead" = Rec."Father Alive Or Dead"::Alive) THEN BEGIN
                                /*Disable the guardian details*/
                                "Guardian Full NameEnable" := FALSE;
                                "Guardian OccupationEnable" := FALSE;
                            END;

                    end;
                }
                field("Mother Full Name"; Rec."Mother Full Name")
                {
                    ApplicationArea = All;
                }
                field("Mother Occupation"; Rec."Mother Occupation")
                {
                    ApplicationArea = All;
                }
                field("Father Alive Or Dead"; Rec."Father Alive Or Dead")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Check if the mother or the father is alive or dead*/
                        IF (Rec."Mother Alive Or Dead" = Rec."Mother Alive Or Dead"::Deceased) AND (Rec."Father Alive Or Dead" = Rec."Father Alive Or Dead"::Deceased) THEN BEGIN
                            /*Disable the guardian details*/
                            "Guardian Full NameEnable" := NOT FALSE;
                            "Guardian OccupationEnable" := NOT FALSE;
                        END
                        ELSE
                            IF (Rec."Mother Alive Or Dead" = Rec."Mother Alive Or Dead"::Alive) AND (Rec."Father Alive Or Dead" = Rec."Father Alive Or Dead"::Alive) THEN BEGIN
                                /*Disable the guardian details*/
                                "Guardian Full NameEnable" := FALSE;
                                "Guardian OccupationEnable" := FALSE;
                            END;

                    end;
                }
                field("Father Full Name"; Rec."Father Full Name")
                {
                    ApplicationArea = All;
                }
                field("Father Occupation"; Rec."Father Occupation")
                {
                    ApplicationArea = All;
                }
                field("Guardian Full Name"; Rec."Guardian Full Name")
                {
                    Enabled = "Guardian Full NameEnable";
                    ApplicationArea = All;
                }
                field("Guardian Occupation"; Rec."Guardian Occupation")
                {
                    Enabled = "Guardian OccupationEnable";
                    ApplicationArea = All;
                }
                field("Emergency Consent Relationship"; Rec."Emergency Consent Relationship")
                {
                    ApplicationArea = All;
                }
                field("Emergency Consent Full Name"; Rec."Emergency Consent Full Name")
                {
                    ApplicationArea = All;
                }
                field("Emergency National ID Card No."; Rec."Emergency National ID Card No.")
                {
                    ApplicationArea = All;
                }
                field("Emergency Consent Address 1"; Rec."Emergency Consent Address 1")
                {
                    ApplicationArea = All;
                }
                field("Emergency Consent Address 2"; Rec."Emergency Consent Address 2")
                {
                    ApplicationArea = All;
                }
                field("Emergency Consent Address 3"; Rec."Emergency Consent Address 3")
                {
                    ApplicationArea = All;
                }
                field("Emergency Date of Consent"; Rec."Emergency Date of Consent")
                {
                    ApplicationArea = All;
                }
            }
            group(Acceptance)
            {
                Caption = 'Acceptance';
                /* field(; '')
                {
                    CaptionClass = Text19058780;
                    Style = Standard;
                    StyleExpr = TRUE;
                } */
                /*  field(; '')
                 {
                     CaptionClass = Text19025049;
                     Style = Standard;
                     StyleExpr = TRUE;
                 } */
                field("Acceptance Date"; Rec."Acceptance Date")
                {
                    ApplicationArea = All;
                }
                field("Accepted ?"; Rec."Accepted ?")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Check if the student has accepted or rejected the offer*/
                        IF Rec."Accepted ?" = TRUE THEN BEGIN
                            "Family ProblemEnable" := FALSE;
                            "Health ProblemEnable" := FALSE;
                            "Overseas ScholarshipEnable" := FALSE;
                            "Course Not PreferenceEnable" := FALSE;
                            EmploymentEnable := FALSE;
                            "Other ReasonEnable" := FALSE;
                        END
                        ELSE BEGIN
                            "Family ProblemEnable" := NOT FALSE;
                            "Health ProblemEnable" := NOT FALSE;
                            "Overseas ScholarshipEnable" := NOT FALSE;
                            "Course Not PreferenceEnable" := NOT FALSE;
                            EmploymentEnable := NOT FALSE;
                            "Other ReasonEnable" := NOT FALSE;
                        END;

                    end;
                }
                field("Family Problem"; Rec."Family Problem")
                {
                    Enabled = "Family ProblemEnable";
                    ApplicationArea = All;
                }
                field("Health Problem"; Rec."Health Problem")
                {
                    Enabled = "Health ProblemEnable";
                    ApplicationArea = All;
                }
                field("Overseas Scholarship"; Rec."Overseas Scholarship")
                {
                    Enabled = "Overseas ScholarshipEnable";
                    ApplicationArea = All;
                }
                field("Course Not Preference"; Rec."Course Not Preference")
                {
                    Enabled = "Course Not PreferenceEnable";
                    ApplicationArea = All;
                }
                field(Employment; Rec.Employment)
                {
                    Enabled = EmploymentEnable;
                    ApplicationArea = All;
                }
                field("Other Reason"; Rec."Other Reason")
                {
                    Enabled = "Other ReasonEnable";
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Photo Functions")
            {
                Caption = '&Photo Functions';
                action("&Import Photo")
                {
                    Caption = '&Import Photo';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Enable the user to import an image of the student*/
                        HasValue := Rec.Photo.HASVALUE();

#pragma warning disable AL0695
                        IF Rec.Photo.IMPORT('*.bmp') <> '' THEN BEGIN
#pragma warning restore AL0695
                            /*User has selected an image*/
                            IF HasValue = TRUE THEN BEGIN
                                IF CONFIRM('Replace Existing Photo?', FALSE) = FALSE THEN BEGIN EXIT END;
                            END;
                            CurrPage.SAVERECORD;
                        END
                        ELSE BEGIN
                            ERROR('No Photo Selected');
                        END;

                    end;
                }
                action("&Export Photo")
                {
                    Caption = '&Export Photo';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Checkif the record has ny image atttached to the same*/
                        HasValue := Rec.Photo.HASVALUE;

                        IF HasValue = FALSE THEN BEGIN
                            ERROR('The Admission record does not have a Photo Attached');
                        END;
#pragma warning disable AL0695
                        IF Rec.Photo.Export('*.bmp') = '' THEN BEGIN
#pragma warning restore AL0695
                            ERROR('Export Process Cancelled By User');
                        END;

                    end;
                }
                separator(_______________)
                {
                }
                action("Delete Photo")
                {
                    Caption = 'Delete Photo';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Check if the admission record has any photo attached to the same*/
                        HasValue := Rec.Photo.HASVALUE;

                        IF HasValue = FALSE THEN BEGIN
                            ERROR('The Admission record does not have any Photo attached. Operation Cancelled');
                        END;
                        /*Ask for user confirmation*/
                        IF CONFIRM('Delete Admission Photo?', FALSE) = FALSE THEN BEGIN EXIT END;
                        /*Clear the picture*/
                        CLEAR(Rec.Photo);
                        CurrPage.SAVERECORD;

                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                action("Next of Kin")
                {
                    Caption = 'Next of Kin';
                    RunObject = Page 68497;
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
                action("Emergency Communication")
                {
                    Caption = 'Emergency Communication';
                    RunObject = Page 68498;
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
                action("Subjects Qualification")
                {
                    Caption = 'Subjects Qualification';
                    RunObject = Page 68499;
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("&Mark as Filled")
            {
                Caption = '&Mark as Filled';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Ask for confirmation  about the filling in*/
                    IF CONFIRM('Mark the Admission Form as Filled?', TRUE) = FALSE THEN BEGIN EXIT END;

                    /*Mark the record as filled*/
                    Rec.TESTFIELD(Campus);
                    Rec.TESTFIELD("Intake Code");
                    TakeStudentToRegistration();
                    Rec.Status := Rec.Status::"Doc. Verification";
                    Rec.MODIFY;
                    MESSAGE('The Admission record has been marked as filled');

                end;
            }
        }
    }



    trigger OnInit()
    begin
        "Other ReasonEnable" := TRUE;
        EmploymentEnable := TRUE;
        "Course Not PreferenceEnable" := TRUE;
        "Overseas ScholarshipEnable" := TRUE;
        "Health ProblemEnable" := TRUE;
        "Family ProblemEnable" := TRUE;
        "Spouse Address 3Enable" := TRUE;
        "Spouse Address 2Enable" := TRUE;
        "Spouse Address 1Enable" := TRUE;
        "Spouse NameEnable" := TRUE;
        "Guardian OccupationEnable" := TRUE;
        "Guardian Full NameEnable" := TRUE;
    end;



    var
        FacultyName: Text[30];
        DegreeName: Text[200];
        AgeText: Text[100];
        NationalityName: Text[30];
        ReligionName: Text[30];
        FormerSchoolName: Text[30];
        HasValue: Boolean;
        Cust: Record Customer;
        CourseRegistration: Record "ACA-Course Registration";
        StudentKin: Record "ACA-Student Kin";
        AdminKin: Record "ACA-Adm. Form Next of Kin";
        StudentGuardian: Record "ACA-Student Sponsors Details";
        [InDataSet]
        "Guardian Full NameEnable": Boolean;
        [InDataSet]
        "Guardian OccupationEnable": Boolean;
        [InDataSet]
        "Spouse NameEnable": Boolean;
        [InDataSet]
        "Spouse Address 1Enable": Boolean;
        [InDataSet]
        "Spouse Address 2Enable": Boolean;
        [InDataSet]
        "Spouse Address 3Enable": Boolean;
        [InDataSet]
        "Family ProblemEnable": Boolean;
        [InDataSet]
        "Health ProblemEnable": Boolean;
        [InDataSet]
        "Overseas ScholarshipEnable": Boolean;
        [InDataSet]
        "Course Not PreferenceEnable": Boolean;
        [InDataSet]
        EmploymentEnable: Boolean;
        [InDataSet]
        "Other ReasonEnable": Boolean;
        Text19058780: Label 'Acceptance of Offer/Non-Acceptance of Offer';
        Text19025049: Label 'Reasons for Non-Acceptance of Offer';
        Text19073905: Label 'Any information student might think useful to Communicate to the University';
        Text19069419: Label 'Last School Attended and Address of School';
        Text19059485: Label 'Declaration Form In The Presence Of Parent/Guardian';

    procedure GetCountry(var CountryCode: Code[20]; var CountryName: Text[30])
    var
        Country: Record 9;
    begin
        /*Get the country name and display the result*/
        Country.RESET;
        CountryName := '';
        IF Country.GET(CountryCode) THEN BEGIN
            CountryName := Country.Name;
        END;

    end;

    procedure GetSchoolName(var SchoolCode: Code[20]; var SchoolName: Text[30])
    var
        FormerSchool: Record "ACA-Applic. Setup Fmr School";
    begin
        /*Get the former school name and display the results*/
        FormerSchool.RESET;
        SchoolName := '';
        IF FormerSchool.GET(SchoolCode) THEN BEGIN
            SchoolName := FormerSchool.Description;
        END;

    end;

    procedure GetDegreeName(var DegreeCode: Code[20]; var DegreeName: Text[200])
    var
        Programme: Record "ACA-PROGRAMME";
    begin
        /*get the degree name and display the results*/
        Programme.RESET;
        DegreeName := '';
        IF Programme.GET(DegreeCode) THEN BEGIN
            DegreeName := Programme.Description;
        END;

    end;

    /// <summary>
    /// GetFacultyName.
    /// </summary>
    /// <param name="DegreeCode">VAR Code[20].</param>
    /// <param name="FacultyName">VAR Text[30].</param>
    procedure GetFacultyName(var DegreeCode: Code[20]; var FacultyName: Text[30])
    var
        Programme: Record "ACA-PROGRAMME";
        DimVal: Record "Dimension Value";
    begin
        /*Get the faculty name and return the result*/
        Programme.RESET;
        FacultyName := '';

        IF Programme.GET(DegreeCode) THEN BEGIN
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Dimension Code", 'FACULTY');
            DimVal.SETRANGE(DimVal.Code, Programme.Faculty);
            IF DimVal.FIND('-') THEN BEGIN
                FacultyName := DimVal.Name;
            END;
        END;

    end;

    /// <summary>
    /// GetAge.
    /// </summary>
    /// <param name="StartDate">VAR Date.</param>
    /// <param name="AgeText">VAR Text[100].</param>
    procedure GetAge(var StartDate: Date; var AgeText: Text[100])
    var
        HRDates: Codeunit "ACA-Dates";
    begin
        /*Get the age based on the dates inserted*/
        IF StartDate = 0D THEN BEGIN StartDate := TODAY END;

        AgeText := HRDates.DetermineAge(StartDate, TODAY);

    end;

    /// <summary>
    /// GetReligionName.
    /// </summary>
    /// <param name="ReligionCode">VAR Code[20].</param>
    /// <param name="ReligionName">VAR Text[30].</param>
    procedure GetReligionName(var ReligionCode: Code[20]; var ReligionName: Text[30])
    var
        Religion: Record "ACA-Religion List";
    begin
        /*Get the religion name and display the result*/
        Religion.RESET;
        ReligionName := '';
        IF Religion.GET(ReligionCode) THEN BEGIN
            ReligionName := Religion.Description;
        END;

    end;

    procedure TakeStudentToRegistration()
    begin


        BEGIN
            Cust.INIT;
            Cust."No." := Rec."Admission No.";
            Cust.Name := COPYSTR(Rec.Surname + ' ' + Rec."Other Names", 1, 30);
            Cust."Search Name" := UPPERCASE(COPYSTR(Rec.Surname + ' ' + Rec."Other Names", 1, 30));
            Cust.Address := Rec."Correspondence Address 1";
            Cust."Address 2" := COPYSTR(Rec."Correspondence Address 2" + ',' + Rec."Correspondence Address 3", 1, 30);
            Cust."Phone No." := Rec."Telephone No. 1" + ',' + Rec."Telephone No. 2";
            Cust."Telex No." := Rec."Fax No.";
            Cust."E-Mail" := Rec."E-Mail";
            Cust.Gender := Rec.Gender;
            Cust."Date Of Birth" := Rec."Date Of Birth";
            Cust."Date Registered" := TODAY;
            Cust."Customer Type" := Cust."Customer Type"::Student;
            //        Cust."Student Type":=FORMAT(Enrollment."Student Type");
            //        Cust."ID No":=;
            Cust."Application No." := Rec."Application No.";
            Cust."Marital Status" := Rec."Marital Status";
            Cust.Citizenship := FORMAT(Rec.Nationality);
            Cust.Religion := FORMAT(Rec.Religion);
            Cust."ID No" := Rec."ID Number";
            Cust."Global Dimension 1 Code" := Rec.Campus;
            Cust."Customer Posting Group" := 'STUDENT';
            Cust.VALIDATE(Cust."Customer Posting Group");
            Cust.INSERT();


            //insert the course registration details
            CourseRegistration.RESET;
            CourseRegistration.INIT;
            CourseRegistration."Reg. Transacton ID" := '';
            CourseRegistration.VALIDATE(CourseRegistration."Reg. Transacton ID");
            CourseRegistration."Student No." := Rec."Admission No.";
            CourseRegistration.Programmes := Rec."Degree Admitted To";
            CourseRegistration.Semester := Rec."Semester Admitted To";
            CourseRegistration.Stage := Rec."Stage Admitted To";
            CourseRegistration."Student Type" := CourseRegistration."Student Type"::"Full Time";
            CourseRegistration."Registration Date" := TODAY;
            CourseRegistration."Settlement Type" := Rec."Settlement Type";
            CourseRegistration.Session := Rec."Intake Code";
            //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
            CourseRegistration.INSERT;

            CourseRegistration.RESET;
            CourseRegistration.SETRANGE(CourseRegistration."Student No.", Rec."Admission No.");
            IF CourseRegistration.FIND('+') THEN BEGIN
                CourseRegistration."Registration Date" := TODAY;
                CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                //CourseRegistration."Settlement Type":="Settlement Type";
                //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                CourseRegistration.MODIFY;

            END;



            //insert the details related to the next of kin of the student into the database
            AdminKin.RESET;
            AdminKin.SETRANGE(AdminKin."Admission No.", Rec."Admission No.");
            IF AdminKin.FIND('-') THEN BEGIN
                REPEAT
                    StudentKin.RESET;
                    StudentKin.INIT;
                    StudentKin."Student No" := Rec."Admission No.";
                    StudentKin.Relationship := AdminKin.Relationship;
                    StudentKin.Name := AdminKin."Full Name";
                    //StudentKin."Other Names":=EnrollmentNextofKin."Other Names";
                    //StudentKin."ID No/Passport No":=EnrollmentNextofKin."ID No/Passport No";
                    //StudentKin."Date Of Birth":=EnrollmentNextofKin."Date Of Birth";
                    //StudentKin.Occupation:=EnrollmentNextofKin.Occupation;
                    StudentKin."Office Tel No" := AdminKin."Telephone No. 1";
                    StudentKin."Home Tel No" := AdminKin."Telephone No. 2";
                    //StudentKin.Remarks:=EnrollmentNextofKin.Remarks;
                    StudentKin.INSERT;
                UNTIL AdminKin.NEXT = 0;
            END;

            //insert the details in relation to the guardian/sponsor into the database in relation to the current student
            IF Rec."Mother Alive Or Dead" = Rec."Mother Alive Or Dead"::Alive THEN BEGIN
                IF Rec."Mother Full Name" <> '' THEN BEGIN
                    StudentGuardian.RESET;
                    StudentGuardian.INIT;
                    StudentGuardian."Student No." := Rec."Admission No.";
                    StudentGuardian.Names := Rec."Mother Full Name";
                    StudentGuardian.INSERT;
                END;
            END;
            IF Rec."Father Alive Or Dead" = Rec."Father Alive Or Dead"::Alive THEN BEGIN
                IF Rec."Father Full Name" <> '' THEN BEGIN
                    StudentGuardian.RESET;
                    StudentGuardian.INIT;
                    StudentGuardian."Student No." := Rec."Admission No.";
                    StudentGuardian.Names := Rec."Father Full Name";
                    StudentGuardian.INSERT;
                END;
            END;
            IF Rec."Guardian Full Name" <> '' THEN BEGIN
                IF Rec."Guardian Full Name" <> '' THEN BEGIN
                    StudentGuardian.RESET;
                    StudentGuardian.INIT;
                    StudentGuardian."Student No." := Rec."Admission No.";
                    StudentGuardian.Names := Rec."Guardian Full Name";
                    StudentGuardian.INSERT;
                END;
            END;

            /*

                    //insert the details in relation to the student history as detailed in the application
                        EnrollmentEducationHistory.RESET;
                        EnrollmentEducationHistory.SETRANGE(EnrollmentEducationHistory."Enquiry No.",Enrollment."Enquiry No.");
                        IF EnrollmentEducationHistory.FIND('-') THEN
                            BEGIN
                                REPEAT
                                    EducationHistory.RESET;
                                    EducationHistory.INIT;
                                        EducationHistory."Student No.":=Rec."No.";
                                        EducationHistory.From:=EnrollmentEducationHistory.From;
                                        EducationHistory."To":=EnrollmentEducationHistory."To";
                                        EducationHistory.Qualifications:=EnrollmentEducationHistory.Qualifications;
                                        EducationHistory.Instituition:=EnrollmentEducationHistory.Instituition;
                                        EducationHistory.Remarks:=EnrollmentEducationHistory.Remarks;
                                        EducationHistory."Aggregate Result/Award":=EnrollmentEducationHistory."Aggregate Result/Award";
                                    EducationHistory.INSERT;
                                UNTIL EnrollmentEducationHistory.NEXT=0;
                            END;
                    //update the status of the application
                        Enrollment."Registration No":=Rec."No.";
                        Enrollment.Status:=Enrollment.Status::Admitted;
                        Enrollment.MODIFY;

             */
        END;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        /*Display the details from the database*/
        GetFacultyName(Rec."Degree Admitted To", FacultyName);
        GetDegreeName(Rec."Degree Admitted To", DegreeName);
        GetCountry(Rec.Nationality, NationalityName);
        GetReligionName(Rec.Religion, ReligionName);
        GetAge(Rec."Date Of Birth", AgeText);

        /*Check if the mother or the father is alive or dead*/
        IF (Rec."Mother Alive Or Dead" = Rec."Mother Alive Or Dead"::Deceased) AND (Rec."Father Alive Or Dead" = Rec."Father Alive Or Dead"::Deceased) THEN BEGIN
            /*Disable the guardian details*/
            "Guardian Full NameEnable" := NOT FALSE;
            "Guardian OccupationEnable" := NOT FALSE;
        END
        ELSE
            IF (Rec."Mother Alive Or Dead" = Rec."Mother Alive Or Dead"::Alive) AND (Rec."Father Alive Or Dead" = Rec."Father Alive Or Dead"::Alive) THEN BEGIN
                /*Disable the guardian details*/
                "Guardian Full NameEnable" := FALSE;
                "Guardian OccupationEnable" := FALSE;
            END;

        /*Check the mariatl status of the student*/
        IF Rec."Marital Status" = Rec."Marital Status"::Single THEN BEGIN
            /*Disable the spouse details*/
            "Spouse NameEnable" := FALSE;
            "Spouse Address 1Enable" := FALSE;
            "Spouse Address 2Enable" := FALSE;
            "Spouse Address 3Enable" := FALSE;
        END
        ELSE BEGIN
            /*Enable the spouse details*/
            "Spouse NameEnable" := TRUE;
            "Spouse Address 1Enable" := TRUE;
            "Spouse Address 2Enable" := TRUE;
            "Spouse Address 3Enable" := TRUE;
        END;

    end;
}

