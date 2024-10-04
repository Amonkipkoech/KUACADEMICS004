report 65207 "Lect Class Attendance List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Lect Class Attendance List.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 65202)
        {
            DataItemTableView = SORTING(Programme, Stage, Unit, Semester, Lecturer)
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = Semester, Lecturer, Programme, Stage, Unit;
            column(progName; progName)
            {
            }
            column(faculty; ACAProgramme.Faculty)
            {
            }
            column(LectName; LectName)
            {
            }
            column(Programme; Programme)
            {
            }
            column(UnitsStage; Stage)
            {
            }
            column(UnitCode; Unit)
            {
            }
            column(UnitDesc; Description)
            {
            }
            column(Semester; Semester)
            {
            }
            column(LectCode; Lecturer)
            {
            }
            column(MarksSubmitted; "Marks Submitted")
            {
            }
            column(RegStudents; "Registered Students")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompPhone1; CompanyInformation."Phone No.")
            {
            }
            column(CompPhone2; CompanyInformation."Phone No. 2")
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompPage; CompanyInformation."Home Page")
            {
            }
            // column(CompPin; CompanyInformation."Company P.I.N")
            // {
            // }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompRegNo; CompanyInformation."Registration No.")
            {
            }
            column(GroupingConcortion; Programme + Lecturer + Semester + Unit)
            {
            }
            dataitem(DataItem1000000009; 61549)
            {
                DataItemLink = Semester = FIELD(Semester),
                               Unit = FIELD(Unit);
                DataItemTableView = SORTING("Student No.", Unit)
                                    ORDER(Ascending);
                column(studNo; "Student No.")
                {
                }
                column(StudName; StudName)
                {
                }
                column(seq; seq)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(StudName);
                    IF Customer.GET("Student No.") THEN
                        StudName := Customer.Name;

                    seq := seq + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(seq);
                CLEAR(LectName);
                IF HRMEmployeeC.GET(Lecturer) THEN
                    LectName := HRMEmployeeC.Initials + ' ' + HRMEmployeeC."Last Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."First Name";

                CLEAR(progName);
                IF ACAProgramme.GET(Programme) THEN progName := ACAProgramme.Description;
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
        IF CompanyInformation.GET() THEN
            CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        CLEAR(Gtoto);
        CLEAR(seq);
    end;

    var
        CompanyInformation: Record 79;
        Gtoto: Decimal;
        seq: Integer;
        StudName: Code[150];
        Customer: Record 18;
        HRMEmployeeC: Record 61188;
        LectName: Text[220];
        progName: Code[150];
        ACAProgramme: Record 61511;
}

