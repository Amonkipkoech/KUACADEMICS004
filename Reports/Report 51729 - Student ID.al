report 51729 "Student ID"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student ID.rdl';

    dataset
    {
        dataitem(Custz; 18)
        {
            DataItemTableView = WHERE("Customer Type" = FILTER(Student));
            column(studNo; Custz."No.")
            {
            }
            column(StudName; Custz.Name)
            {
            }
            column(cardExpiry; Custz."ID Card Expiry Year")
            {
            }
            column(Genders; FORMAT(Custz.Gender))
            {
            }
            column(Cust_Picture; Custz.Image)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(progdesc; Prog.Description)
            {
            }
            column(Signature; genset.Picture)
            {
            }
            column(Contacts1; CompInfo.Address + '-' + CompInfo."Post Code" + ', ' + CompInfo.City + '. Tel: ' + CompInfo."Phone No.")
            {
            }
            column(RegDate; Custz."Date Registered")
            {
            }
            column(ExpiryDates; ExpiryDates)
            {
            }
            column(Brc2; '*' + Custz."No." + '*')
            {
            }

            trigger OnAfterGetRecord()
            var
            //  Barcode: Record 60003;
            //Barcode2: Record 60003;
            begin
                //CardExpiry:=Cust."ID Card Expiry Year";
                Custz.CALCFIELDS(Custz.Image);
                IF NOT Custz.Image.HASVALUE THEN CurrReport.SKIP;
                courseReg.RESET;
                courseReg.SETRANGE(courseReg."Student No.", Custz."No.");
                courseReg.SETFILTER(courseReg.Programmes, '<>%1', '');
                IF courseReg.FIND('+') THEN BEGIN
                    Prog.RESET;
                    Prog.SETRANGE(Prog.Code, courseReg.Programmes);
                    IF Prog.FIND('-') THEN BEGIN
                    END ELSE
                        CurrReport.SKIP;
                END ELSE
                    CurrReport.SKIP;

                CLEAR(CountedStages);
                CLEAR(CurrCounts);
                ACAProgrammeStages.RESET;
                ACAProgrammeStages.SETRANGE(ACAProgrammeStages."Programme Code", Prog.Code);
                IF ACAProgrammeStages.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        CLEAR(CurrStage);
                        IF EVALUATE(CurrStage, COPYSTR(ACAProgrammeStages.Code, 2, 1)) THEN BEGIN
                            IF CurrStage <> LastStage THEN BEGIN
                                LastStage := CurrStage;
                                CountedStages := CountedStages + 1;
                            END;
                        END;
                    END;
                    UNTIL ACAProgrammeStages.NEXT = 0;
                END;

                CLEAR(ExpiryDates);
                courseReg.RESET;
                courseReg.SETRANGE(courseReg."Student No.", Custz."No.");
                courseReg.SETFILTER(courseReg.Programmes, '<>%1', '');
                courseReg.SETFILTER(courseReg."Academic Year", '<>%1', '');
                IF courseReg.FIND('-') THEN BEGIN
                    ACAAcademicYear.RESET;
                    ACAAcademicYear.SETFILTER(ACAAcademicYear.Code, '%1..', courseReg."Academic Year");
                    IF ACAAcademicYear.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            CurrCounts := CurrCounts + 1;
                        END;
                        UNTIL ((ACAAcademicYear.NEXT = 0) OR (CurrCounts = CountedStages - 1));
                        ExpiryDates := ACAAcademicYear."ID Card Validity";
                    END;
                END;
                IF Custz.Image.HASVALUE THEN BEGIN
                    ACASttudentIDPrintTracker.RESET;
                    ACASttudentIDPrintTracker.SETRANGE("Student No.", Custz."No.");
                    IF ACASttudentIDPrintTracker.FIND('-') THEN BEGIN
                        ACASttudentIDPrintTracker.Printed := TRUE;
                        ACASttudentIDPrintTracker."Last Printed By" := USERID;
                        ACASttudentIDPrintTracker."Last Printed Date/time" := CREATEDATETIME(TODAY, TIME);
                        ACASttudentIDPrintTracker.MODIFY;
                    END ELSE BEGIN
                        ACASttudentIDPrintTracker.INIT;
                        ACASttudentIDPrintTracker."Student No." := Custz."No.";
                        ACASttudentIDPrintTracker."Original Printed By" := USERID;
                        ACASttudentIDPrintTracker."Original Printed Date/Time" := CREATEDATETIME(TODAY, TIME);
                        ACASttudentIDPrintTracker.Printed := TRUE;
                        ACASttudentIDPrintTracker."Last Printed By" := USERID;
                        ACASttudentIDPrintTracker."Last Printed Date/time" := CREATEDATETIME(TODAY, TIME);
                        ACASttudentIDPrintTracker.INSERT;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                StudentsList.RESET;
                StudentsList.COPYFILTERS(Custz);
                IF StudentsList.FIND('-') THEN;
                ACASttudentIDPrintTracker.RESET;
                IF ACASttudentIDPrintTracker.FIND('-') THEN ACASttudentIDPrintTracker.DELETEALL;
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

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);
        CompInfo.CALCFIELDS(CompInfo.Picture);
    end;

    var
        Custest: Record 18;
        Prog: Record 61511;
        Stages: Record 61516;
        RFound: Boolean;
        UDesc: Text[200];
        Units: Record 61517;
        CompInfo: Record 79;
        LevelCaptionLbl: Label 'Level';
        ProgrammeCaptionLbl: Label 'Programme';
        NamesCaptionLbl: Label 'Names';
        Signature_CaptionLbl: Label 'Signature:';
        STUDENT_ID_CARDCaptionLbl: Label 'STUDENT ID CARD';
        CardExpiry: Integer;
        No: Code[20];
        courseReg: Record 61532;
        genset: Record 61534;
        CountedStages: Integer;
        Progz: Record 61511;
        ACAProgrammeStages: Record 61516;
        LastStage: Integer;
        CurrStage: Integer;
        ACAAcademicYear: Record 61382;
        ExpiryDates: Text[30];
        CurrCounts: Integer;
        BarcodeXters: Code[20];
        StudentsList: Record 18;
        ACASttudentIDPrintTracker: Record 77700;
        PrintSignoff: Option "ID Only","ID & Chenklist";
}

