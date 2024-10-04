report 51343 "Official Admission LetterJAb"
{
    Caption = 'Official Letter GSS';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Official Admission LetterJAb.rdl';

    dataset
    {
        dataitem("Application Form Header"; 70082)
        {
            column(ApplicationNo_ApplicationFormHeader; "Application Form Header".Index)
            {
            }
            column(Surname_ApplicationFormHeader; "Application Form Header".Names)
            {
            }
            column(OtherNames_ApplicationFormHeader; "Application Form Header".Names)
            {
            }
            column(Gender_ApplicationFormHeader; "Application Form Header".Gender)
            {
            }
            column(address; "Application Form Header".Box)
            {
            }
            column(adresscode; "Application Form Header".Codes)
            {
            }
            column(addresstown; "Application Form Header".Town)
            {
            }
            column(TelephoneNo1_ApplicationFormHeader; "Application Form Header".Phone)
            {
            }
            column(TelephoneNo2_ApplicationFormHeader; "Application Form Header"."Alt. Phone")
            {
            }
            column(Degree; "Application Form Header".Prog)
            {
            }
            column(School; "Application Form Header"."Slt Mail")
            {
            }
            column(IndexNumber_ApplicationFormHeader; "Application Form Header".Index)
            {
            }
            column(AcademicYear_ApplicationFormHeader; "Application Form Header".Admin)
            {
            }
            column(AdmissionNo_ApplicationFormHeader; "Application Form Header".Admin)
            {
            }
            column(Names_ApplicationFormHeader; "Application Form Header".Names)
            {
            }
            column(Surname_ApplicationFormHeader1; "Application Form Header".Surname)
            {
            }
            column(CampusLocation_ApplicationFormHeader; "Application Form Header"."Campus Location")
            {
            }
            column(CompName; Info.Name)
            {
            }
            column(InforPict; Info.Picture)
            {
            }
            column(InfoAddress; Info.Address)
            {
            }
            column(InfoPhone; Info."Phone No.")
            {
            }
            column(InfoCity; Info.City)
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
            column(email; Email)
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
            dataitem("New Student Charges"; 61543)
            {
                DataItemLink = "Programme Code" = FIELD(Prog);
                column(Code_NewStudentCharges; "New Student Charges".Code)
                {
                }
                column(Description_NewStudentCharges; "New Student Charges".Description)
                {
                }
                column(Amount_NewStudentCharges; "New Student Charges".Amount)
                {
                }
            }

            trigger OnPreDataItem()
            begin

                if IndexNo <> '' then begin
                    "Application Form Header".Reset();
                    "Application Form Header".SetRange(Index, IndexNo);
                    if "Application Form Header".FindFirst() then;
                end;

            end;

            trigger OnAfterGetRecord()
            var
                TTTT: Text[30];
            begin

              

                // FullNames:="Application Form Header".Surname+' '+"Application Form Header"."Other Names";
                ProgName := '';
                IF Prog1.GET("Application Form Header".Prog) THEN BEGIN
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
                IF ("Application Form Header".Prog = 'BMED') OR ("Application Form Header".Prog = 'BSC NURSING') THEN
                    ReportDate := 20190322D ELSE
                    ReportDate := 20190321D;

                StageRec.RESET;
                StageRec.SETRANGE(StageRec."Programme Code", "Application Form Header".Prog);
                // StageRec.SETRANGE(StageRec.Code,"Application Form Header"."Admitted To Stage");
                IF StageRec.FIND('-') THEN
                    StageName := COPYSTR(StageRec.Description, 1, 7);
                Sname := '';
                lngPos := STRPOS(Names, ' ');
                IF lngPos <> 0 THEN BEGIN
                    Sname := COPYSTR(Names, 1, lngPos - 1);

                END;


                IF "Application Form Header".Gender = "Application Form Header".Gender::Male THEN
                    Salutation := 'Mr';
                IF "Application Form Header".Gender = "Application Form Header".Gender::Female THEN
                    Salutation := 'Miss';

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field("Index No."; IndexNo)
                {
                    ApplicationArea = all;
                    Caption = 'Index No.';

                }
            }
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

        info.Get();
        info.Calcfields(Picture);
    end;

    var
        StageName: Text[100];
        CompName: Code[100];
        ReportDate: Date;
        FullNames: Text[100];
        ProgName: Code[100];
        Prog1: Record 61511;
        IntakeRec: Record 61383;
        ComenceDate: Date;
        DateStr: Text[50];
        FacultyName: Text[100];
        FacRec: Record 349;

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
        IndexNo: Code[50];

        Info: Record "Company Information";
}

