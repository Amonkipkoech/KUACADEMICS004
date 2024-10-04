page 68507 "ACA-Admission Form Filled"
{
    PageType = Document;
    SourceTable = "ACA-Adm. Form Header";
    SourceTableView = WHERE(Status = CONST("Doc. Verification"));

    layout
    {
        area(content)
        {
            field("Admission Type"; Rec."Admission Type")
            {
                Editable = false;
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
            field("Settlement Type"; Rec."Settlement Type")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Degree Admitted To"; Rec."Degree Admitted To")
            {
                Editable = false;
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
                Editable = false;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    GetAge(Rec."Date Of Birth", AgeText);
                end;
            }
            field(AgeText; AgeText)
            {
                Editable = false;
                ApplicationArea = All;
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
            field("Spouse Name"; Rec."Spouse Name")
            {
                Editable = false;
                Enabled = "Spouse NameEnable";
                ApplicationArea = All;
            }
            field("Spouse Address 1"; Rec."Spouse Address 1")
            {
                Editable = false;
                Enabled = "Spouse Address 1Enable";
                ApplicationArea = All;
            }
            field("Spouse Address 2"; Rec."Spouse Address 2")
            {
                Editable = false;
                Enabled = "Spouse Address 2Enable";
                ApplicationArea = All;
            }
            field("Spouse Address 3"; Rec."Spouse Address 3")
            {
                Editable = false;
                Enabled = "Spouse Address 3Enable";
                ApplicationArea = All;
            }
            field(Tribe; Rec.Tribe)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Place Of Birth Village"; Rec."Place Of Birth Village")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Place Of Birth Location"; Rec."Place Of Birth Location")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Place Of Birth District"; Rec."Place Of Birth District")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Name of Chief"; Rec."Name of Chief")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Nearest Police Station"; Rec."Nearest Police Station")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Declaration Full Name"; Rec."Declaration Full Name")
            {
                Caption = 'Name';
                Editable = false;
                ApplicationArea = All;
            }
            field("Declaration Relationship"; Rec."Declaration Relationship")
            {
                Caption = 'Relationship';
                Editable = false;
                ApplicationArea = All;
            }
            field("Declaration National ID No"; Rec."Declaration National ID No")
            {
                Caption = 'National Identity Card No.';
                Editable = false;
                ApplicationArea = All;
            }
            field("Declaration Date"; Rec."Declaration Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Acceptance Date"; Rec."Acceptance Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Accepted ?"; Rec."Accepted ?")
            {
                Editable = false;
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
                Editable = false;
                Enabled = "Family ProblemEnable";
                ApplicationArea = All;
            }
            field("Health Problem"; Rec."Health Problem")
            {
                Editable = false;
                Enabled = "Health ProblemEnable";
                ApplicationArea = All;
            }
            field("Overseas Scholarship"; Rec."Overseas Scholarship")
            {
                Editable = false;
                Enabled = "Overseas ScholarshipEnable";
                ApplicationArea = All;
            }
            field("Course Not Preference"; Rec."Course Not Preference")
            {
                Editable = false;
                Enabled = "Course Not PreferenceEnable";
                ApplicationArea = All;
            }
            field(Employment; Rec.Employment)
            {
                Editable = false;
                Enabled = EmploymentEnable;
                ApplicationArea = All;
            }
            field("Other Reason"; Rec."Other Reason")
            {
                Editable = false;
                Enabled = "Other ReasonEnable";
                ApplicationArea = All;
            }
            field("Admission No."; Rec."Admission No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Semester Admitted To"; Rec."Semester Admitted To")
            {
                ApplicationArea = All;
            }
            field(Nationality; Rec.Nationality)
            {
                Editable = false;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    GetCountry(Rec.Nationality, NationalityName);
                end;
            }
            field(NationalityName; NationalityName)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Religion; Rec.Religion)
            {
                Editable = false;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    GetReligionName(Rec.Religion, ReligionName);
                end;
            }
            field(ReligionName; ReligionName)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Correspondence Address 1"; Rec."Correspondence Address 1")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Correspondence Address 2"; Rec."Correspondence Address 2")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Correspondence Address 3"; Rec."Correspondence Address 3")
            {
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
            field("Fax No."; Rec."Fax No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Emergency Consent Relationship"; Rec."Emergency Consent Relationship")
            {
                Caption = 'Relationship';
                Editable = false;
                ApplicationArea = All;
            }
            field("Emergency Consent Full Name"; Rec."Emergency Consent Full Name")
            {
                Caption = 'Full  Name';
                Editable = false;
                ApplicationArea = All;
            }
            field("Emergency National ID Card No."; Rec."Emergency National ID Card No.")
            {
                Caption = 'National ID Card No';
                Editable = false;
                ApplicationArea = All;
            }
            field("Emergency Consent Address 1"; Rec."Emergency Consent Address 1")
            {
                Caption = 'Address 1';
                Editable = false;
                ApplicationArea = All;
            }
            field("Emergency Consent Address 2"; Rec."Emergency Consent Address 2")
            {
                Caption = 'Address 2';
                Editable = false;
                ApplicationArea = All;
            }
            field("Emergency Consent Address 3"; Rec."Emergency Consent Address 3")
            {
                Caption = 'Address 3';
                Editable = false;
                ApplicationArea = All;
            }
            field("Emergency Date of Consent"; Rec."Emergency Date of Consent")
            {
                Caption = 'Date of Consent';
                Editable = false;
                ApplicationArea = All;
            }
            field("Mother Alive Or Dead"; Rec."Mother Alive Or Dead")
            {
                Editable = false;
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
                Editable = false;
                ApplicationArea = All;
            }
            field("Mother Occupation"; Rec."Mother Occupation")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Father Alive Or Dead"; Rec."Father Alive Or Dead")
            {
                Editable = false;
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
                Editable = false;
                ApplicationArea = All;
            }
            field("Father Occupation"; Rec."Father Occupation")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Guardian Full Name"; Rec."Guardian Full Name")
            {
                Editable = false;
                Enabled = "Guardian Full NameEnable";
                ApplicationArea = All;
            }
            field("Guardian Occupation"; Rec."Guardian Occupation")
            {
                Editable = false;
                Enabled = "Guardian OccupationEnable";
                ApplicationArea = All;
            }
            field(Photo; Rec.Photo)
            {
                ApplicationArea = All;
            }
            /*  field(; '')
             {
                 CaptionClass = Text19025049;
                 Style = Standard;
                 StyleExpr = TRUE;
             }
             field(; '')
             {
                 CaptionClass = Text19058780;
                 Style = Standard;
                 StyleExpr = TRUE;
             }
             field(; '')
             {
                 CaptionClass = Text19059485;
                 Style = Standard;
                 StyleExpr = TRUE;
             } */
        }
    }

    actions
    {
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
        Text19059485: Label 'Declaration Form In The Presence Of Parent/Guardian';
        Text19058780: Label 'Acceptance of Offer/Non-Acceptance of Offer';
        Text19025049: Label 'Reasons for Non-Acceptance of Offer';

    /// <summary>
    /// GetCountry.
    /// </summary>
    /// <param name="CountryCode">VAR Code[20].</param>
    /// <param name="CountryName">VAR Text[30].</param>
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
        DimVal: Record 349;
    begin
        /*Get the faculty name and return the result*/
        Programme.RESET;
        FacultyName := '';

        IF Programme.GET(DegreeCode) THEN BEGIN
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Dimension Code", 'FACULTY');
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
    /// <param name="AgeText">VAR Text[100].</param>
    procedure GetAge(var StartDate: Date; var AgeText: Text[100])
    var
        HRDates: Codeunit "ACA-Dates";
    begin
        /*Get the age based on the dates inserted*/
        IF StartDate = 0D THEN BEGIN StartDate := TODAY END;

        AgeText := HRDates.DetermineAge(StartDate, TODAY);

    end;

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

