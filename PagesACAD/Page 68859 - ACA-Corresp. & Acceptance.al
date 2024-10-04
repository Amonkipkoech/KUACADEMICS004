page 68859 "ACA-Corresp. & Acceptance"
{
    PageType = List;
    SourceTable = "ACA-Adm. Form Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                /*  group("Offer Acceptance"; "Offer Acceptance")
                 {
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
}

