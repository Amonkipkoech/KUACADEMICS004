report 51766 "List By Programme"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/List By Programme.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            column(Title1; 'STUDENT LIST BY PROGRAMME,  ' + FORMAT(Semester))
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            // column("Count"; cou)
            // {
            // }
            column(Gender; FORMAT(Cust.Gender))
            {
            }
            column(Student_No_; "Student No.")
            {
            }
            column(Student_Name; "Student Name")
            {
            }
            column(Student_Type; "Student Type")
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
            column(Progcode; Progcode)
            {
            }
            column(setType; "ACA-Course Registration"."Settlement Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                // if "Course Registration".Semester<>Semesters then "Course Registration"."Academic Year"
                CLEAR(Progcode);
                prog1.RESET;
                prog1.SETRANGE(prog1.Code, "ACA-Course Registration".Programmes);
                IF prog1.FIND('-') THEN BEGIN
                    Progcode := prog1.Code + ': ' + prog1.Description;
                END;


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


                Info.RESET;
                IF Info.FIND('-') THEN
                    Info.CALCFIELDS(Picture);

                Display := TRUE;
                Disp := TRUE;
                //IF "Course Registration".Stage='Y1S1' THEN Display:=FALSE;
                IF "ACA-Course Registration".Stage = ' ' THEN Disp := FALSE;


                sems.RESET;
                sems.SETRANGE(sems."Current Semester", TRUE);
                IF sems.FIND('-') THEN BEGIN
                    sFound := TRUE;
                END;

                acadYear.RESET;
                acadYear.SETRANGE(acadYear.Current, TRUE);
                IF acadYear.FIND('-') THEN BEGIN
                    sFound := TRUE;
                END;

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
                IF acaYear <> '' THEN
                    courseRegst.SETRANGE(courseRegst."Academic Year", FORMAT(acaYear));
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

                IF courseRegst.FIND('-') = FALSE THEN
                    Disp := FALSE;



                IF ((Display = TRUE) AND (Disp = TRUE)) THEN BEGIN
                    cou := cou + 1;
                    //CurrReport.SHOWOUTPUT(TRUE);
                END
                ELSE BEGIN
                    CurrReport.SKIP;
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETCURRENTKEY("Settlement Type", "Student No.")
            end;
        }
    }

    /*  requestpage
     {

         layout
         {
             area(content)
             {
                 field(Semz; Semester)
                 {
                     Caption = 'Semester:';
                     TableRelation = "ACA-Semesters".Code;
                 }
             }
         }

         actions
         {
         }
     } */

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
    end;

    var
        cust3: Record 18;
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
        Programmes: Record 61511;
        ProgStage: Record 61516;
        "Unit/Subjects": Record 61517;
        Semeters: Record 61518;
        Hesabu: Integer;
        StudFilter: Code[10];
        StudType: Option " ","Full Time","Part Time","Distance Learning","School Based";
        CourseReg: Record 61532;
        Info: Record 79;
        CompanyInfo: Record 79;
        sems: Record 61518;
        acadYear: Record 61382;
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
        Progcode: Text[250];
        prog1: Record 61511;
}
