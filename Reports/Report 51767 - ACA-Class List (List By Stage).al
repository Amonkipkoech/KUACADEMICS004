report 51767 "ACA-Class List (List By Stage)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Class List (List By Stage).rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            PrintOnlyIfDetail = true;
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                PrintOnlyIfDetail = true;
                column(progcode; "ACA-Programme Stages"."Programme Code")
                {
                }
                column(stages; "ACA-Programme Stages".Code)
                {
                }
                column(progName; "ACA-Programme".Description)
                {
                }
                column(ProgNameAndCode; "ACA-Programme Stages".Code + ': ' + "ACA-Programme Stages"."Programme Code")
                {
                }
                dataitem("ACA-Course Registration"; "ACA-Course Registration")
                {
                    DataItemLink = Programmes = FIELD("Programme Code"),
                                   Stage = FIELD(Code);
                    RequestFilterFields = Programmes, Stage, Semester, "Settlement Type", Options, "Class Code", Unit;
                    column(Title1; 'Students Attendance Register')
                    {
                    }
                    column(pic; CompanyInfo.Picture)
                    {
                    }
                    column("Count"; cou)
                    {
                    }
                    column(Gender; FORMAT(Cust.Gender))
                    {
                    }
                    column(No; Cust."No.")
                    {
                    }
                    column(Name; Cust.Name)
                    {
                    }
                    column(stdType; courseRegst."Student Type")
                    {
                    }
                    column(Phone_No; Cust."Phone No.")
                    {
                    }
                    column(stage; "ACA-Course Registration".Stage)
                    {
                    }
                    column(RegDate; "ACA-Course Registration"."Registration Date")
                    {
                    }
                    column(BottomLabel; '')
                    {
                    }
                    column(regStatus; regStatus)
                    {
                    }
                    column(seq; FORMAT(seq) + '.')
                    {
                    }
                    column(PrintDate; TODAY)
                    {
                    }
                    column(Semesters; Semesters)
                    {
                    }
                    column(Unit_CourseRegistration; "ACA-Course Registration".Unit)
                    {
                    }
                    column(UnitDesc; UnitDesc)
                    {
                    }
                    column(Phone; Cust."Phone No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        CLEAR(regStatus);
                        customers1.RESET;
                        customers1.SETRANGE(customers1."No.", "ACA-Course Registration"."Student No.");
                        IF customers1.FIND('-') THEN BEGIN
                            regStatus := FORMAT(customers1.Status);
                        END;
                        bal := 0;
                        stud.RESET;
                        stud.SETRANGE(stud."No.", "ACA-Course Registration"."Student No.");
                        IF stud.FIND('-') THEN BEGIN
                            stud.CALCFIELDS(stud."Balance (LCY)");
                            bal := stud."Balance (LCY)";
                        END;



                        Display := TRUE;
                        Disp := TRUE;

                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.", "ACA-Course Registration"."Student No.");
                        IF Cust.FIND('-') THEN BEGIN
                            sFound := TRUE;
                            GEND := '';
                            IF Cust.Gender = 0 THEN BEGIN
                                GEND := 'MALE';
                                TotalMale := TotalMale + 1;
                            END ELSE
                                IF Cust.Gender = 1 THEN BEGIN
                                    GEND := 'FEMALE';
                                    TotalFEMale := TotalFEMale + 1;
                                END;
                        END;

                        courseRegst.RESET;
                        courseRegst.SETRANGE(courseRegst."Reg. Transacton ID", "ACA-Course Registration"."Reg. Transacton ID");
                        //IF StudType<>StudType::" " THEN
                        //courseRegst.SETRANGE(courseRegst."Student Type",StudType);
                        IF Semesters <> '' THEN
                            courseRegst.SETRANGE(courseRegst.Semester, FORMAT(Semesters));
                        //IF stages=stages::"New Students" THEN
                        //courseRegst.SETFILTER(courseRegst.Stage,'=Y1S1')
                        //ELSE IF stages=stages::"Continuing Students" THEN
                        //courseRegst.SETFILTER(courseRegst.Stage,'<>Y1S1');
                        //IF campCode<>'' THEN
                        //courseRegst.SETRANGE(courseRegst."Campus Code",FORMAT(campCode));
                        //IF Genders<>Genders::"BOTH GENDER" THEN
                        //IF Genders=Genders::Male THEN
                        //courseRegst.SETRANGE(courseRegst.Gender,courseRegst.Gender::Male)
                        //ELSE IF Genders=Genders::Female THEN
                        //courseRegst.SETRANGE(courseRegst.Gender,courseRegst.Gender::Female);

                        IF NOT (courseRegst.FIND('-')) THEN
                            Disp := FALSE;



                        IF ((Display = TRUE) AND (Disp = TRUE)) THEN BEGIN
                            cou := cou + 1;
                            seq := seq + 1;
                            //CurrReport.SHOWOUTPUT(TRUE);
                        END
                        ELSE BEGIN
                            CurrReport.SKIP;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(seq);
                end;
            }

            trigger OnPreDataItem()
            begin
                UnitRec.RESET;
                UnitRec.SETFILTER(UnitRec.Code, "ACA-Course Registration".GETFILTER("ACA-Course Registration".Unit));
                UnitRec.SETFILTER(UnitRec."Programme Code", "ACA-Programme".GETFILTER("ACA-Programme".Code));
                IF UnitRec.FIND('-') THEN
                    UnitDesc := UnitRec.Desription;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Semz; Semesters)
                {
                    Caption = 'Semester:';
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;
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
        IF Info.GET() THEN Semesters := Info."Last Semester Filter";
    end;

    trigger OnPostReport()
    begin
        IF Info.GET() THEN BEGIN
            Info."Last Semester Filter" := Semesters;
            Info.MODIFY;

        END;
    end;

    trigger OnPreReport()
    begin

        // IF acaYear='' THEN ERROR('Please Specify the Academic Year.');
        IF Semesters = '' THEN ERROR('Please Specify the Semester.');
        cou := 0;

        constLine := '==================================================================================================';
        CLEAR(TotalFEMale);
        CLEAR(TotalMale);

        CompanyInfo.RESET;
        IF CompanyInfo.FIND('-') THEN BEGIN
            CompanyInfo.CALCFIELDS(Picture);
        END;

        Info.RESET;
        IF Info.FIND('-') THEN
            Info.CALCFIELDS(Picture);
    end;

    var
        seq: Integer;
        customers1: Record 18;
        regStatus: Code[50];
        TotalMale: Integer;
        TotalFEMale: Integer;
        campCode: Code[10];
        Genders: Option "BOTH GENDER",Male,Female;
        Names: Text[250];
        Cust: Record 18;
        Prog: Text[250];
        Stage: Text[250];
        Unit: Text[250];
        Sem: Text[250];

        Hesabu: Integer;
        StudFilter: Code[10];
        StudType: Option " ","Full Time","Part Time","Distance Learning","School Based";
        Info: Record 79;
        CompanyInfo: Record 79;

        sFound: Boolean;
        GEND: Text[30];
        Display: Boolean;
        Disp: Boolean;
        cou: Integer;
        acaYear: Code[50];
        Semesters: Code[50];
        courseRegst: Record 61532;
        stages: Option "New Students","Continuing Students",All;
        bal: Decimal;
        stud: Record 18;
        constLine: Text[250];
        Text000: Label 'Period: %1';
        Text001: Label 'NORMINAL ROLE';
        Text002: Label 'NORMINAL ROLE';
        Text003: Label 'Reg. No.';
        Text004: Label 'Phone No.';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'G/L Filter';
        Text011: Label 'Period Filter';
        Text012: Label 'Gender';
        Text013: Label 'Mode of Study';
        Text014: Label 'Total Amount';
        Text015: Label 'Name';
        Text016: Label 'Reg. Date';
        Text017: Label 'Stage';
        Text020: Label 'ACAD. YEAR';
        Text021: Label 'STAGE';
        Text022: Label 'STUD. TYPE';
        Text023: Label 'SEMESTER';
        Text024: Label '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
        UnitRec: Record 61517;
        UnitDesc: Text[200];
}

