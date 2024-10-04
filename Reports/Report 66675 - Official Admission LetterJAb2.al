report 66675 "Official Admission LetterJAb2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Official Admission LetterJAb2.rdl';

    dataset
    {
        dataitem(Studs; 18)
        {
            RequestFilterFields = "No.";
            column(ApplicationNo_ApplicationFormHeader; '')
            {
            }
            column(Surname_ApplicationFormHeader; Studs.Name)
            {
            }
            column(OtherNames_ApplicationFormHeader; Studs.Name)
            {
            }
            column(Gender_ApplicationFormHeader; Studs.Gender)
            {
            }
            column(address; Studs.Address)
            {
            }
            column(adresscode; Studs."Address 2")
            {
            }
            column(addresstown; Studs.City)
            {
            }
            column(TelephoneNo1_ApplicationFormHeader; Studs."Phone No.")
            {
            }
            column(TelephoneNo2_ApplicationFormHeader; '')
            {
            }
            column(Degree; Prog1.Description)
            {
            }
            column(School; FacultyName)
            {
            }
            column(IndexNumber_ApplicationFormHeader; '')
            {
            }
            column(Accademic_Year; ACACourseRegistration."Academic Year")
            {
            }
            column(AdmissionNo_ApplicationFormHeader; Studs."No.")
            {
            }
            column(Names_ApplicationFormHeader; Studs.Name)
            {
            }
            column(Surname_ApplicationFormHeader1; Studs.Name)
            {
            }
            column(CampusLocation_ApplicationFormHeader; Studs."Global Dimension 1 Code")
            {
            }
            column(CompName; CompName)
            {
            }
            column(Faculty; FacultyName)
            {
            }
            column(RepDate; ReportDate)
            {
            }
            column(FNames; FullNames)
            {
            }
            column(ProgName; ProgName)
            {
            }
            column(DateStr; DateStr)
            {
            }
            column(telephone; Telphone)
            {
            }
            column(AdminNo; Admin)
            {
            }
            column(email; email)
            {
            }
            column(Salutation; Salutation)
            {
            }
            column(StageName; StageName)
            {
            }
            column(Sname; Sname)
            {
            }
            column(Campus; Campus)
            {
            }

            trigger OnAfterGetRecord()
            var
                TTTT: Text[30];
            begin

                // FullNames:="Application Form Header".Surname+' '+"Application Form Header"."Other Names";
                ACACourseRegistration.RESET;
                ACACourseRegistration.SETRANGE(ACACourseRegistration.Reversed, FALSE);
                ACACourseRegistration.SETRANGE(ACACourseRegistration."Student No.", Studs."No.");
                IF ACACourseRegistration.FIND('-') THEN BEGIN
                    ProgName := '';
                    IF Prog1.GET(ACACourseRegistration.Programmes) THEN BEGIN
                        ProgName := Prog1.Description;
                        Campus := Prog1."Campus Code";
                        FacultyName := '';
                        FacRec.RESET;
                        FacRec.SETRANGE("Dimension Code", 'FACULTY');
                        FacRec.SETRANGE(FacRec.Code, Prog1."School Code");
                        IF FacRec.FIND('-') THEN
                            FacultyName := FacRec.Name;
                    END;

                    /*IF IntakeRec.GET("Application Form Header"."Intake Code") THEN BEGIN
                     IntakeRec.TESTFIELD(IntakeRec."Reporting Date");
                     ReportDate:= FORMAT(IntakeRec."Reporting Date",0,'<Day> <Month Text>') +' '+FORMAT(DATE2DMY(IntakeRec."Reporting Date",3));
                    END;*/
                    DateStr := FORMAT(TODAY, 0, '<Day> <Month Text>') + ' ' + FORMAT(DATE2DMY(TODAY, 3));
                    IF (ACACourseRegistration.Programmes = 'BMED') OR (ACACourseRegistration.Programmes = 'BSC NURSING') THEN
                        ReportDate := 20180121D ELSE
                        ReportDate := 20190920D;

                    StageRec.RESET;
                    StageRec.SETRANGE(StageRec."Programme Code", ACACourseRegistration.Programmes);
                    // StageRec.SETRANGE(StageRec.Code,"Application Form Header"."Admitted To Stage");
                    IF StageRec.FIND('-') THEN
                        StageName := COPYSTR(StageRec.Description, 1, 7);
                    Sname := '';
                    lngPos := STRPOS(Studs.Name, ' ');
                    IF lngPos <> 0 THEN BEGIN
                        Sname := COPYSTR(Studs.Name, 1, lngPos - 1);

                    END;


                    IF Studs.Gender = Studs.Gender::Male THEN
                        Salutation := 'Mr';
                    IF Studs.Gender = Studs.Gender::Female THEN
                        Salutation := 'Miss';
                END;

            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CompName := COMPANYNAME;
    end;

    var
        StageName: Text[100];
        CompName: Code[100];
        ReportDate: Date;
        FullNames: Text[100];
        ProgName: Code[100];
        Prog1: Record 61511;
        ACAAcademicYear: Record 61382;
        ACACourseRegistration: Record 61532;
        IntakeRec: Record 61383;
        ComenceDate: Date;
        DateStr: Text[50];
        FacultyName: Text[100];
        FacRec: Record 349;
        StudHostel: Record 61155;
        RoomNo: Code[20];
        HostelRec: Record 61162;
        HostelName: Text[50];
        StageRec: Record 61516;
        KUCCPSImports: Record 70082;
        email: Code[30];
        Telphone: Code[20];
        Admin: Code[20];
        address: Code[10];
        Salutation: Text;
        lngPos: Integer;
        Sname: Text[100];
        Campus: Code[50];
}

