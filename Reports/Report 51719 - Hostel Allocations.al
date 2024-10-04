report 51719 "Hostel Allocations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Allocations.rdl';

    dataset
    {
        dataitem(DataItem1; 61155)
        {
            //DataItemTableView = WHERE(Cleared = FILTER(No),
            //Allocated = FILTER(Yes));
            column(pic; Info.Picture)
            {
            }
            column(Title1; 'HOSTEL ALLOCATIONS')
            {
            }
            column(StdNo; Student)
            {
            }
            column(stdName; "Student Name")
            {
            }
            column(host; "Hostel No")
            {
            }
            column(room; "Space No")
            {
            }
            column(AmountCharged; Charges)
            {
            }
            column(settlement; "Settlement Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Settlement Type");
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
        //IF Info.GET() THEN Semesters := Info."Last Semester Filter";
    end;

    trigger OnPreReport()
    begin

        // IF acaYear='' THEN ERROR('Please Specify the Academic Year.');
        IF Semesters = '' THEN ERROR('Please Specify the Semester.');
        cou := 0;
        CLEAR(overaltotal);

        Info.RESET;
        IF Info.FIND('-') THEN BEGIN
            Info.CALCFIELDS(info.picture);
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
        Programmes: Record 61511;
        ProgStage: Record 61516;
        "Unit/Subjects": Record 61517;
        Semeters: Record 61518;
        Hesabu: Integer;
        StudFilter: Code[10];
        StudType: Option " ",Boarder,Dayscholar,"Distance Learning","School Based";
        CourseReg: Record 61532;
        Info: Record 79;
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

