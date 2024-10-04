/// <summary>
/// Report Population By Programme (ID 51778).
/// </summary>
report 51778 "Population By Programme"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Population By Programme.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            RequestFilterFields = "Stage Filter", "Semester Filter", "Date Filter";
            column(pic; Info.Picture)
            {
            }
            column(Title1; 'STUDENT POPULATION BY PROGRAMME - ' + Semesters)
            {
            }
            column(progCode; Code)
            {
            }
            column(ProgDesc; Description)
            {
            }
            column(StudNo; "Student Registered")
            {
            }
            column(stageFilter; GETFILTER("Stage Filter"))
            {
            }
            column(datefilter; GETFILTER("Date Filter"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Student Registered");


                CLEAR("Student Registered");
                //"Course Registration".CALCFIELDS("Course Registration".Gender);
                /*
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg.Programme,Programme.Code);
                IF CourseReg.FIND('-') THEN
                BEGIN
                IF Genders=1 THEN BEGIN
                  CourseReg.SETRANGE(CourseReg.Gender,CourseReg.Gender::Male);
                END;
                
                IF Genders=2 THEN BEGIN
                 CourseReg.SETRANGE(CourseReg.Gender,CourseReg.Gender::Female);
                END;
                
                IF campCode<>'' THEN BEGIN
                  CourseReg.SETRANGE(CourseReg."Campus Code",campCode);
                END;
                
                END;
                
                //IF intk<>'' THEN BEGIN
                //  CourseReg.SETRANGE(CourseReg.Intake,intk);
                //END;
                
                
                IF acaYear<>'' THEN
                  CourseReg.SETRANGE(CourseReg."Academic Year",acaYear);
                IF Semesters<>'' THEN
                  CourseReg.SETRANGE(CourseReg.Semester,Semesters);
                
                IF CourseReg.FIND('-') THEN BEGIN
                  studnumber:=CourseReg.COUNT;
                  overaltotal:=overaltotal+CourseReg.COUNT;
                END;
                */
                //studnumber := "Student Registered";

                // IF studnumber = 0 THEN CurrReport.SKIP;

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
                    TableRelation = "ACA-Semesters".code;
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

    trigger OnPreReport()
    begin

        // IF acaYear='' THEN ERROR('Please Specify the Academic Year.');
        IF Semesters = '' THEN ERROR('Please Specify the Semester.');
        cou := 0;
        CLEAR(overaltotal);

        Info.RESET;
        IF Info.FIND('-') THEN BEGIN
            Info.CALCFIELDS(Picture);
        END;
    end;

    var
        overaltotal: Integer;
        studnumber: Integer;
        strgs: Code[20];
        progys: Code[20];
        intk: Code[20];
        TotalMale: Integer;
        TotalFEMale: Integer;
        campCode: Code[20];

        Genders: Option "BOTH GENDER",Male,Female;
        Names: Text[250];
        Cust: Record 18;
        Prog: Text[250];
        Stage: Text[250];
        Unit: Text[250];
        Sem: Text[250];
        info: Record "Company Information";

        Hesabu: Integer;
        StudFilter: Code[10];
        StudType: Option " ",Boarder,Dayscholar,"Distance Learning","School Based";

        sFound: Boolean;
        GEND: Text[30];
        Display: Boolean;
        Disp: Boolean;
        cou: Integer;
        acaYear: Code[50];
        Semesters: Code[50];

        stages: Option " ","New Students","Continuing Students","All Stages";
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
}

