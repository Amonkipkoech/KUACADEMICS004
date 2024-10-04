/// <summary>
/// Page ACA-New Admissions List (ID 68850).
/// </summary>
page 68850 "ACA-New Admissions List"
{
    CardPageID = "ACA-Admission Form Header GOK";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Adm. Form Header";
    SourceTableView = WHERE(Status = FILTER(New));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
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
                field("Faculty Admitted To"; Rec."Faculty Admitted To")
                {
                    ApplicationArea = All;
                }
                field("Degree Admitted To"; Rec."Degree Admitted To")
                {
                    ApplicationArea = All;
                }
                field("Correspondence Address 1"; Rec."Correspondence Address 1")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
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
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
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
                action("Next of Kin")
                {
                    Caption = 'Next of Kin';
                    Image = ContactReference;
                    RunObject = Page 68497;
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
                action("Emergency Communication")
                {
                    Caption = 'Emergency Communication';
                    Image = ContactPerson;
                    RunObject = Page 68498;
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
                action("Subjects Qualification")
                {
                    Caption = 'Subjects Qualification';
                    Image = QualificationOverview;
                    RunObject = Page 68499;
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("&Mark as Admitted")
            {
                Caption = '&Mark as Admitted';
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Ask for confirmation  about the filling in*/
                    IF CONFIRM('Mark the Admission Form as Filled?', TRUE) = FALSE THEN BEGIN EXIT END;

                    /*Mark the record as filled*/
                    TakeStudentToRegistration();
                    Rec.Status := Rec.Status::"Doc. Verification";
                    Rec.MODIFY;
                    MESSAGE('The Admission record has been marked as filled');

                end;
            }
        }
    }

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
        Text19071252: Label 'Ever suffered or had symptoms of the following';
        Text19025049: Label 'Reasons for Non-Acceptance of Offer';
        Text19049741: Label 'Medical details not covered by above';
        Text19069419: Label 'Last School Attended and Address of School';
        Text19015920: Label 'Family member ever suffered from';
        Text19012476: Label 'Immunizations received';
        Text19059485: Label 'Declaration Form In The Presence Of Parent/Guardian';
        Text19079474: Label 'Part II (Completed by a medical practioner)';

    /// <summary>
    /// GetCountry.
    /// </summary>
    /// <param name="CountryCode">VAR Code[20].</param>
    /// <param name="CountryName">VAR Text[30].</param>
    procedure GetCountry(var CountryCode: Code[20]; var CountryName: Text[30])
    var
        Country: Record "Country/Region";
    begin
        /*Get the country name and display the result*/
        Country.RESET;
        CountryName := '';
        IF Country.GET(CountryCode) THEN BEGIN
            CountryName := Country.Name;
        END;

    end;

    /// <summary>
    /// GetSchoolName.
    /// </summary>
    /// <param name="SchoolCode">VAR Code[20].</param>
    /// <param name="SchoolName">VAR Text[30].</param>
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

    /// <summary>
    /// GetDegreeName.
    /// </summary>
    /// <param name="DegreeCode">VAR Code[20].</param>
    /// <param name="DegreeName">VAR Text[200].</param>
    procedure GetDegreeName(var DegreeCode: Code[20]; var DegreeName: Text[200])
    var
        Programme: Record "ACA-Programme";
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
        Programme: Record "ACA-Programme";
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
        Religion: Record "ACA-Academics Central Setups";
    begin
        /*Get the religion name and display the result*/
        Religion.RESET;
        Religion.SETRANGE(Religion."Title Code", ReligionCode);
        Religion.SETRANGE(Religion.Category, Religion.Category::Religions);

        ReligionName := '';
        IF Religion.FIND('-') THEN BEGIN
            ReligionName := Religion.Description;
        END;

    end;

    /// <summary>
    /// TakeStudentToRegistration.
    /// </summary>
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
            Cust."Application No." := Rec."Admission No.";
            Cust."Marital Status" := Rec."Marital Status";
            Cust.Citizenship := FORMAT(Rec.Nationality);
            Cust.Religion := FORMAT(Rec.Religion);
            Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
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
            //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
            CourseRegistration.INSERT;

            CourseRegistration.RESET;
            CourseRegistration.SETRANGE(CourseRegistration."Student No.", Rec."Admission No.");
            //  CourseRegistration.SETRANGE();
            IF CourseRegistration.FIND('+') THEN BEGIN
                CourseRegistration."Registration Date" := TODAY;
                CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                CourseRegistration."Settlement Type" := Rec."Settlement Type";
                CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
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

