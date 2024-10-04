report 78001 "Special/Supp. Exams Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/SpecialSupp. Exams Report.rdl';

    dataset
    {
        dataitem("Aca-Special Exams Details"; "Aca-Special Exams Details")
        {
            /* DataItemLink = Semester = FIELD(Field2),"Exam Session"=FIELD(Field3),
                           "Student No."=FIELD(Field4),Stage=FIELD(Field5), Programme=FIELD(Field6); */
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Address1; CompanyInformation.Address)
            {
            }
            column(Address2; CompanyInformation."Address 2")
            {
            }
            column(Phone1; CompanyInformation."Phone No.")
            {
            }
            column(Phone2; CompanyInformation."Phone No. 2")
            {
            }
            column(Pics; CompanyInformation.Picture)
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            column(HomeP; CompanyInformation."Home Page")
            {
            }
            column(StudentNo; "Aca-Special Exams Details"."Student No.")
            {
            }
            column(StdName; Customer.Name)
            {
            }
            column(Category; UPPERCASE(FORMAT("Aca-Special Exams Details".Catogory) + ' Examinations'))
            {
            }
            column(Stage; "Aca-Special Exams Details".Stage)
            {
            }
            column(AcadYear; "Aca-Special Exams Details"."Academic Year")
            {
            }
            column(ExamSession; "Aca-Special Exams Details"."Current Academic Year")
            {
            }
            column(UnitCount; 1)
            {
            }
            column(TotalCharge; 0)
            {
            }
            column(UnitCharge; 0)
            {
            }
            column(Semester; "Aca-Special Exams Details".Semester)
            {
            }
            column(ProgCode; "Aca-Special Exams Details".Programme)
            {
            }
            column(ProgName; ACAProgramme.Description)
            {
            }
            column(GroupByPhrase; "Aca-Special Exams Details"."Student No." + "Aca-Special Exams Details".Stage + "Aca-Special Exams Details".Programme + "Aca-Special Exams Details".Semester)
            {
            }
            column(UnitCode; "Aca-Special Exams Details"."Unit Code")
            {
            }
            column(UnitDescription; "Aca-Special Exams Details"."Unit Description")
            {
            }
            column(CostPerUnit; "Aca-Special Exams Details"."Cost Per Exam")
            {
            }
            column(UnitCountApproved; '')
            {
            }
            column(TotalApprovedCharge; '')
            {
            }
            column(UnitChargeApproved; '')
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Customer.GET("Aca-Special Exams Details"."Student No.") THEN BEGIN
                END;
                IF ACAProgramme.GET("Aca-Special Exams Details".Programme) THEN BEGIN
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
        IF CompanyInformation.GET THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        ACAProgramme: Record 61511;
        Customer: Record 18;
        CompanyInformation: Record 79;
}

